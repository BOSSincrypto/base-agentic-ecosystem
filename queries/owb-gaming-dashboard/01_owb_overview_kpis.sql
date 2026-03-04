-- OWB Agentic Gaming Dashboard - Query 1: OWB Overview KPIs
-- Displays top-level metrics for OWB (Clash of Coins) ecosystem
-- Token: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
-- Chain: Base
-- Save as: "OWB Gaming - Overview KPIs"

WITH owb_contracts AS (
    SELECT address, label FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'Rewards Claim'),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'Staking'),
        (0xf252f51919dfca2c9c0ea279f11183580edee4d6, 'Uniswap V3 Pool'),
        (0x995985c9027e8a90c823a5e0a9112fea72d1f4dd, 'Aerodrome Pool')
    ) AS t(address, label)
),

-- Current OWB price
current_price AS (
    SELECT
        price AS owb_price_usd
    FROM prices.usd_latest
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
),

-- Total transactions across all OWB contracts (YTD)
total_txs AS (
    SELECT
        COUNT(*) AS total_transactions,
        COUNT(DISTINCT t."from") AS unique_wallets
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
),

-- This week vs last week
current_week AS (
    SELECT
        COUNT(*) AS txs_this_week,
        COUNT(DISTINCT t."from") AS users_this_week
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= date_trunc('week', now())
      AND t.success = true
),

prev_week AS (
    SELECT
        COUNT(*) AS txs_last_week,
        COUNT(DISTINCT t."from") AS users_last_week
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= date_trunc('week', now()) - interval '7' day
      AND t.block_time < date_trunc('week', now())
      AND t.success = true
),

-- DEX volume (30d)
dex_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS dex_volume_30d
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= now() - interval '30' day
),

-- Holder count (net positive balance holders)
holders AS (
    SELECT COUNT(*) AS holder_count
    FROM (
        SELECT wallet, SUM(net_amount) AS balance
        FROM (
            SELECT "to" AS wallet, amount AS net_amount
            FROM tokens.transfers
            WHERE blockchain = 'base'
              AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            UNION ALL
            SELECT "from" AS wallet, -amount AS net_amount
            FROM tokens.transfers
            WHERE blockchain = 'base'
              AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
        ) t
        GROUP BY 1
        HAVING SUM(net_amount) > 0
    )
),

-- Staking transactions count (30d)
staking_txs AS (
    SELECT COUNT(*) AS staking_actions_30d
    FROM base.transactions t
    WHERE t."to" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
      AND t.block_time >= now() - interval '30' day
      AND t.success = true
),

-- Rewards claims count (30d)
claims AS (
    SELECT COUNT(*) AS claim_actions_30d
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.block_time >= now() - interval '30' day
      AND t.success = true
)

SELECT
    cp.owb_price_usd AS "OWB Price (USD)",
    ROUND(cp.owb_price_usd * 1e9, 0) AS "Fully Diluted Valuation",
    tt.total_transactions AS "Total Txs (2026 YTD)",
    tt.unique_wallets AS "Unique Wallets (YTD)",
    h.holder_count AS "Total Holders",
    ROUND(dv.dex_volume_30d, 0) AS "DEX Volume (30d USD)",
    cw.txs_this_week AS "Txs This Week",
    pw.txs_last_week AS "Txs Last Week",
    CASE
        WHEN pw.txs_last_week > 0
        THEN ROUND(100.0 * (cw.txs_this_week - pw.txs_last_week) / pw.txs_last_week, 1)
        ELSE 0
    END AS "WoW Txs Growth %",
    cw.users_this_week AS "Users This Week",
    pw.users_last_week AS "Users Last Week",
    CASE
        WHEN pw.users_last_week > 0
        THEN ROUND(100.0 * (cw.users_this_week - pw.users_last_week) / pw.users_last_week, 1)
        ELSE 0
    END AS "WoW Users Growth %",
    st.staking_actions_30d AS "Staking Actions (30d)",
    cl.claim_actions_30d AS "Reward Claims (30d)"
FROM current_price cp
CROSS JOIN total_txs tt
CROSS JOIN current_week cw
CROSS JOIN prev_week pw
CROSS JOIN dex_vol dv
CROSS JOIN holders h
CROSS JOIN staking_txs st
CROSS JOIN claims cl
