-- Section 6: Cards Leaderboard — All Projects Comparison
-- Shows 30d metrics + WoW momentum for each project
--
-- Save as: "Cards Projects Leaderboard (V1)"

-- ============================================================
-- Beezie (Base) — NFT secondary market
-- ============================================================
WITH beezie_30d AS (
    SELECT
        'Beezie' AS project,
        'Base' AS chain,
        COUNT(*) AS trades_30d,
        COUNT(DISTINCT buyer) AS buyers_30d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_30d
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= now() - interval '30' day
),

beezie_7d AS (
    SELECT
        COUNT(*) AS trades_7d,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS volume_7d
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= now() - interval '7' day
),

beezie_prev7d AS (
    SELECT
        COUNT(*) AS trades_prev7d,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS volume_prev7d
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

-- ============================================================
-- Courtyard (Polygon) — NFT secondary market
-- ============================================================
courtyard_30d AS (
    SELECT
        'Courtyard' AS project,
        'Polygon' AS chain,
        COUNT(*) AS trades_30d,
        COUNT(DISTINCT buyer) AS buyers_30d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_30d
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= now() - interval '30' day
),

courtyard_7d AS (
    SELECT
        COUNT(*) AS trades_7d,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS volume_7d
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= now() - interval '7' day
),

courtyard_prev7d AS (
    SELECT
        COUNT(*) AS trades_prev7d,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS volume_prev7d
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

-- ============================================================
-- Collector Crypt (Solana) — CARDS token DEX trades
-- ============================================================
cc_30d AS (
    SELECT
        'Collector Crypt' AS project,
        'Solana' AS chain,
        COUNT(*) AS trades_30d,
        COUNT(DISTINCT trader_id) AS buyers_30d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_30d
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= now() - interval '30' day
),

cc_7d AS (
    SELECT
        COUNT(*) AS trades_7d,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS volume_7d
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= now() - interval '7' day
),

cc_prev7d AS (
    SELECT
        COUNT(*) AS trades_prev7d,
        COALESCE(ROUND(SUM(COALESCE(amount_usd, 0)), 2), 0) AS volume_prev7d
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

-- ============================================================
-- Upshot (Base) — USDC deposits
-- ============================================================
upshot_30d AS (
    SELECT
        'Upshot' AS project,
        'Base' AS chain,
        COUNT(DISTINCT evt_tx_hash) AS trades_30d,
        COUNT(DISTINCT "from") AS buyers_30d,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS volume_30d
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= now() - interval '30' day
),

upshot_7d AS (
    SELECT
        COUNT(DISTINCT evt_tx_hash) AS trades_7d,
        COALESCE(ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2), 0) AS volume_7d
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= now() - interval '7' day
),

upshot_prev7d AS (
    SELECT
        COUNT(DISTINCT evt_tx_hash) AS trades_prev7d,
        COALESCE(ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2), 0) AS volume_prev7d
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= now() - interval '14' day
      AND evt_block_time < now() - interval '7' day
),

-- ============================================================
-- Combine into leaderboard
-- ============================================================
combined AS (
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM beezie_30d
    UNION ALL
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM courtyard_30d
    UNION ALL
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM cc_30d
    UNION ALL
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM upshot_30d
),

weekly AS (
    SELECT 'Beezie' AS project, b7.trades_7d, b7.volume_7d, bp.trades_prev7d, bp.volume_prev7d
    FROM beezie_7d b7 CROSS JOIN beezie_prev7d bp
    UNION ALL
    SELECT 'Courtyard', c7.trades_7d, c7.volume_7d, cp.trades_prev7d, cp.volume_prev7d
    FROM courtyard_7d c7 CROSS JOIN courtyard_prev7d cp
    UNION ALL
    SELECT 'Collector Crypt', cc7.trades_7d, cc7.volume_7d, ccp.trades_prev7d, ccp.volume_prev7d
    FROM cc_7d cc7 CROSS JOIN cc_prev7d ccp
    UNION ALL
    SELECT 'Upshot', u7.trades_7d, u7.volume_7d, up.trades_prev7d, up.volume_prev7d
    FROM upshot_7d u7 CROSS JOIN upshot_prev7d up
)

SELECT
    c.project AS "Project",
    c.chain AS "Chain",
    c.trades_30d AS "Trades (30d)",
    c.buyers_30d AS "Users (30d)",
    c.volume_30d AS "Volume USD (30d)",
    w.trades_7d AS "Trades (7d)",
    w.volume_7d AS "Volume USD (7d)",
    CASE
        WHEN w.trades_prev7d > 0
        THEN ROUND(100.0 * (w.trades_7d - w.trades_prev7d) / w.trades_prev7d, 1)
        ELSE NULL
    END AS "WoW Trades %",
    CASE
        WHEN COALESCE(w.volume_prev7d, 0) > 0
        THEN ROUND(100.0 * (w.volume_7d - w.volume_prev7d) / NULLIF(w.volume_prev7d, 0), 1)
        ELSE NULL
    END AS "WoW Volume %",
    ROUND(c.volume_30d / NULLIF(c.buyers_30d, 0), 2) AS "Avg Volume/User"
FROM combined c
LEFT JOIN weekly w ON c.project = w.project
ORDER BY c.volume_30d DESC
