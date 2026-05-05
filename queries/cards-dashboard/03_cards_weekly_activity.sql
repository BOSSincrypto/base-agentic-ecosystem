-- Section 6: Cards Weekly Activity — stacked by project
-- Shows weekly volume trend across all card platforms
--
-- Save as: "Cards Weekly Activity — Time Series (V1)"

WITH beezie_weekly AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        'Beezie' AS project,
        COUNT(*) AS trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        COUNT(DISTINCT buyer) AS unique_users
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= TIMESTAMP '2026-01-01'
    GROUP BY 1
),

courtyard_weekly AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        'Courtyard' AS project,
        COUNT(*) AS trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        COUNT(DISTINCT buyer) AS unique_users
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= TIMESTAMP '2025-01-01'
    GROUP BY 1
),

cc_weekly AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        'Collector Crypt' AS project,
        COUNT(*) AS trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        COUNT(DISTINCT trader_id) AS unique_users
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= TIMESTAMP '2025-08-01'
    GROUP BY 1
),

upshot_weekly AS (
    SELECT
        DATE_TRUNC('week', evt_block_time) AS week,
        'Upshot' AS project,
        COUNT(DISTINCT evt_tx_hash) AS trades,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS volume_usd,
        COUNT(DISTINCT "from") AS unique_users
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-02-01'
    GROUP BY 1
),

combined AS (
    SELECT * FROM beezie_weekly
    UNION ALL
    SELECT * FROM courtyard_weekly
    UNION ALL
    SELECT * FROM cc_weekly
    UNION ALL
    SELECT * FROM upshot_weekly
)

SELECT
    week AS "Week",
    project AS "Project",
    trades AS "Trades",
    volume_usd AS "Volume USD",
    unique_users AS "Unique Users",
    SUM(volume_usd) OVER (PARTITION BY project ORDER BY week) AS "Cumulative Volume USD"
FROM combined
WHERE week < DATE_TRUNC('week', now())
ORDER BY week, project
