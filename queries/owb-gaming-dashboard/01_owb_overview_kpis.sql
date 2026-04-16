-- OWB Agentic Gaming Dashboard - Query 1: OWB Overview KPIs
-- Displays top-level metrics for OWB (Clash of Coins) ecosystem
-- Token: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
-- Chain: Base
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - Overview KPIs"

WITH owb_contracts AS (
    SELECT address, label FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'Rewards Claim'),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'Agentic Claim 1'),
        (0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203, 'Agentic Claim 2'),
        (0x692d11c779d43BBC12Cb8565C7f71a54A47D117c, 'Staking'),
        (0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b, 'NFT Sale (Web)'),
        (0xf46A1D3eAA84558887169CF2CEE343491364c8BA, 'NFT Sale (Base App)')
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

-- Total transactions across all OWB contracts (since agentic presale)
total_txs AS (
    SELECT
        COUNT(*) AS total_transactions,
        COUNT(DISTINCT t."from") AS unique_wallets
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= DATE '2026-03-25'
      AND t.success = true
),

-- Rolling 7d WoW comparison (avoids calendar-week bias)
current_7d AS (
    SELECT
        COUNT(*) AS txs_current_7d,
        COUNT(DISTINCT t."from") AS users_current_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= now() - interval '7' day
      AND t.success = true
),

prev_7d AS (
    SELECT
        COUNT(*) AS txs_prev_7d,
        COUNT(DISTINCT t."from") AS users_prev_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= now() - interval '14' day
      AND t.block_time < now() - interval '7' day
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

-- Staking transactions count (30d) - correct staking contract
staking_txs AS (
    SELECT COUNT(*) AS staking_actions_30d
    FROM base.transactions t
    WHERE t."to" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      AND t.block_time >= now() - interval '30' day
      AND t.success = true
),

-- Agentic claims count (30d) - both claim contracts
agentic_claims AS (
    SELECT COUNT(*) AS agentic_claim_actions_30d
    FROM base.transactions t
    WHERE t."to" IN (
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb,
        0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
    )
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
    ROUND(cp.owb_price_usd, 6) AS "OWB Price (USD)",
    ROUND(cp.owb_price_usd * 1e9, 0) AS "Fully Diluted Valuation",
    tt.total_transactions AS "Total Txs (Since Presale)",
    tt.unique_wallets AS "Unique Wallets",
    h.holder_count AS "Total Holders",
    ROUND(dv.dex_volume_30d, 0) AS "DEX Volume (30d USD)",
    c7.txs_current_7d AS "Txs (Last 7d)",
    p7.txs_prev_7d AS "Txs (Prev 7d)",
    CASE
        WHEN p7.txs_prev_7d > 0
        THEN ROUND(100.0 * (c7.txs_current_7d - p7.txs_prev_7d) / p7.txs_prev_7d, 1)
        ELSE NULL
    END AS "WoW Txs Growth %",
    c7.users_current_7d AS "Users (Last 7d)",
    p7.users_prev_7d AS "Users (Prev 7d)",
    CASE
        WHEN p7.users_prev_7d > 0
        THEN ROUND(100.0 * (c7.users_current_7d - p7.users_prev_7d) / p7.users_prev_7d, 1)
        ELSE NULL
    END AS "WoW Users Growth %",
    st.staking_actions_30d AS "Staking Actions (30d)",
    ac.agentic_claim_actions_30d AS "Agentic Claims (30d)",
    cl.claim_actions_30d AS "Reward Claims (30d)"
FROM current_price cp
CROSS JOIN total_txs tt
CROSS JOIN current_7d c7
CROSS JOIN prev_7d p7
CROSS JOIN dex_vol dv
CROSS JOIN holders h
CROSS JOIN staking_txs st
CROSS JOIN agentic_claims ac
CROSS JOIN claims cl
