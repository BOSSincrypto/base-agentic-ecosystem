-- OWB Agentic Gaming Dashboard - Query 2: OWB Daily Activity Time Series
-- Daily transactions, users, and DEX volume across all OWB contracts
-- With 7d moving averages and cumulative growth
-- Save as: "OWB Gaming - Daily Activity"

WITH owb_contracts AS (
    SELECT address, label, category FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token', 'Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'Rewards Claim', 'Gaming'),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'Staking', 'DeFi')
    ) AS t(address, label, category)
),

-- Daily contract interactions
daily_contract AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        oc.category,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT t."from") AS daily_users
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= DATE '2025-06-01'
      AND t.success = true
    GROUP BY 1, 2
),

-- Daily DEX volume
daily_dex AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        SUM(amount_usd) AS dex_volume_usd,
        COUNT(*) AS dex_trades,
        COUNT(DISTINCT tx_from) AS dex_traders
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= DATE '2025-06-01'
    GROUP BY 1
),

-- Date spine
date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2025-06-01', current_date, interval '1' day)) AS t(day)
),

-- Fill gaps for contract data (aggregate across categories)
daily_filled AS (
    SELECT
        ds.day,
        COALESCE(SUM(dc.daily_txs), 0) AS contract_txs,
        COALESCE(COUNT(DISTINCT CASE WHEN dc.daily_users > 0 THEN dc.category END), 0) AS active_categories,
        COALESCE(SUM(CASE WHEN dc.category = 'Token' THEN dc.daily_txs ELSE 0 END), 0) AS token_txs,
        COALESCE(SUM(CASE WHEN dc.category = 'Gaming' THEN dc.daily_txs ELSE 0 END), 0) AS gaming_txs,
        COALESCE(SUM(CASE WHEN dc.category = 'DeFi' THEN dc.daily_txs ELSE 0 END), 0) AS defi_txs
    FROM date_spine ds
    LEFT JOIN daily_contract dc ON ds.day = dc.day
    GROUP BY 1
),

combined AS (
    SELECT
        df.day,
        df.contract_txs AS "Contract Transactions",
        df.token_txs AS "Token Txs",
        df.gaming_txs AS "Gaming (Claims) Txs",
        df.defi_txs AS "Staking Txs",
        COALESCE(dd.dex_volume_usd, 0) AS "DEX Volume (USD)",
        COALESCE(dd.dex_trades, 0) AS "DEX Trades",
        COALESCE(dd.dex_traders, 0) AS "DEX Unique Traders",
        AVG(df.contract_txs) OVER (ORDER BY df.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "Contract Txs 7d MA",
        AVG(COALESCE(dd.dex_volume_usd, 0)) OVER (ORDER BY df.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "Volume 7d MA",
        SUM(df.contract_txs) OVER (ORDER BY df.day) AS "Cumulative Contract Txs",
        SUM(COALESCE(dd.dex_volume_usd, 0)) OVER (ORDER BY df.day) AS "Cumulative DEX Volume"
    FROM daily_filled df
    LEFT JOIN daily_dex dd ON df.day = dd.day
)

SELECT
    day,
    "Contract Transactions",
    "Token Txs",
    "Gaming (Claims) Txs",
    "Staking Txs",
    ROUND("DEX Volume (USD)", 2) AS "DEX Volume (USD)",
    "DEX Trades",
    "DEX Unique Traders",
    ROUND("Contract Txs 7d MA", 0) AS "Contract Txs 7d MA",
    ROUND("Volume 7d MA", 2) AS "Volume 7d MA",
    "Cumulative Contract Txs",
    ROUND("Cumulative DEX Volume", 2) AS "Cumulative DEX Volume"
FROM combined
WHERE day < current_date
ORDER BY day ASC
