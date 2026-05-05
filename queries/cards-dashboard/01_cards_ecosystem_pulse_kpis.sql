-- Section 6: Cards Dashboard — Combined KPIs
-- Cross-chain: Base (Beezie, Upshot) + Polygon (Courtyard) + Solana (Collector Crypt)
-- Date range: project-specific start dates to save Dune credits
--
-- Data sources:
--   Beezie:          nft.trades (Base, ERC-721)
--   Courtyard:       nft.trades (Polygon, ERC-721)
--   Collector Crypt: dex_solana.trades (CARDS token)
--   Upshot:          erc20_base.evt_Transfer (USDC deposits)
--
-- Save as: "Cards Ecosystem Pulse — Combined KPIs (V1)"

-- ============================================================
-- 1) Beezie — NFT trades on Base
-- ============================================================
WITH beezie_trades AS (
    SELECT
        'Beezie' AS project,
        'Base' AS chain,
        block_time,
        tx_hash,
        buyer AS user_address,
        amount_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= TIMESTAMP '2026-01-01'
),

-- ============================================================
-- 2) Courtyard — NFT trades on Polygon
-- ============================================================
courtyard_trades AS (
    SELECT
        'Courtyard' AS project,
        'Polygon' AS chain,
        block_time,
        tx_hash,
        buyer AS user_address,
        amount_usd
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= TIMESTAMP '2025-01-01'
),

-- ============================================================
-- 3) Collector Crypt — CARDS token trades on Solana
-- ============================================================
collector_crypt_trades AS (
    SELECT
        'Collector Crypt' AS project,
        'Solana' AS chain,
        block_time,
        tx_id AS tx_hash,
        trader_id AS user_address,
        amount_usd
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= TIMESTAMP '2025-08-01'
),

-- ============================================================
-- 4) Upshot — USDC deposits on Base
-- ============================================================
upshot_txs AS (
    SELECT
        'Upshot' AS project,
        'Base' AS chain,
        evt_block_time AS block_time,
        evt_tx_hash AS tx_hash,
        "from" AS user_address,
        CAST(value AS DOUBLE) / 1e6 AS amount_usd
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-02-01'
),

-- ============================================================
-- Combine all projects
-- ============================================================
all_txs AS (
    SELECT project, chain, block_time, tx_hash, user_address, amount_usd FROM beezie_trades
    UNION ALL
    SELECT project, chain, block_time, tx_hash, user_address, amount_usd FROM courtyard_trades
    UNION ALL
    SELECT project, chain, block_time, tx_hash, CAST(user_address AS VARCHAR), amount_usd FROM collector_crypt_trades
    UNION ALL
    SELECT project, chain, block_time, tx_hash, CAST(user_address AS VARCHAR), amount_usd FROM upshot_txs
),

-- ============================================================
-- KPIs
-- ============================================================
total_kpi AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS total_trades,
        COUNT(DISTINCT user_address) AS unique_users,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS total_volume_usd,
        COUNT(DISTINCT project) AS active_projects
    FROM all_txs
),

this_week AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS week_trades,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS week_volume
    FROM all_txs
    WHERE block_time >= now() - interval '7' day
),

prev_week AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS prev_trades,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS prev_volume
    FROM all_txs
    WHERE block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

chain_split AS (
    SELECT
        chain,
        COUNT(DISTINCT tx_hash) AS chain_trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS chain_volume
    FROM all_txs
    GROUP BY 1
)

SELECT
    t.total_trades AS "Total Trades (All-Time)",
    t.unique_users AS "Unique Users (All-Time)",
    t.total_volume_usd AS "Total Volume USD",
    t.active_projects AS "Active Projects",
    tw.week_trades AS "This Week Trades",
    tw.week_volume AS "This Week Volume USD",
    CASE
        WHEN pw.prev_trades > 0
        THEN ROUND(100.0 * (tw.week_trades - pw.prev_trades) / pw.prev_trades, 1)
        ELSE 0
    END AS "WoW Trades Growth %",
    CASE
        WHEN pw.prev_volume > 0
        THEN ROUND(100.0 * (tw.week_volume - pw.prev_volume) / NULLIF(pw.prev_volume, 0), 1)
        ELSE 0
    END AS "WoW Volume Growth %",
    COALESCE(MAX(CASE WHEN cs.chain = 'Base' THEN cs.chain_volume END), 0) AS "Base Volume USD",
    COALESCE(MAX(CASE WHEN cs.chain = 'Polygon' THEN cs.chain_volume END), 0) AS "Polygon Volume USD",
    COALESCE(MAX(CASE WHEN cs.chain = 'Solana' THEN cs.chain_volume END), 0) AS "Solana Volume USD"
FROM total_kpi t
CROSS JOIN this_week tw
CROSS JOIN prev_week pw
CROSS JOIN chain_split cs
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
