-- Q3: Secondary Market Volume by Project (V2 — includes Phygitals royalties)
-- NFT secondary via nft.trades; CC secondary via CARDS DEX; Phygitals via royalty proxy
-- Engine: Small for EVM, Medium for Solana DEX

WITH beezie_secondary AS (
    SELECT
        date_trunc('week', block_time)  AS week,
        'Beezie'                        AS project,
        'Base'                          AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(buyer)          AS unique_buyers
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

courtyard_secondary AS (
    SELECT
        date_trunc('week', block_time)  AS week,
        'Courtyard'                     AS project,
        'Polygon'                       AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(buyer)          AS unique_buyers
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

collector_crypt_dex AS (
    SELECT
        date_trunc('week', block_time)  AS week,
        'Collector Crypt'               AS project,
        'Solana'                        AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(trader_id)      AS unique_buyers
    FROM dex_solana.trades
    WHERE block_date >= DATE '2026-01-01'
      AND (   token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
           OR token_sold_mint_address   = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp')
    GROUP BY 1
),

phygitals_royalties AS (
    SELECT
        date_trunc('week', block_time)  AS week,
        'Phygitals'                     AS project,
        'Solana'                        AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(from_owner)     AS unique_buyers
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND to_owner = '2CEe9G68EqWmer21DhRhxJ3coUvRspDxT9NJuc2PJYo5'
      AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                             '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf')
    GROUP BY 1
),

combined AS (
    SELECT * FROM beezie_secondary
    UNION ALL SELECT * FROM courtyard_secondary
    UNION ALL SELECT * FROM collector_crypt_dex
    UNION ALL SELECT * FROM phygitals_royalties
)

SELECT
    week,
    project,
    chain,
    ROUND(volume_usd, 2)  AS volume_usd,
    trades,
    unique_buyers
FROM combined
WHERE week < date_trunc('week', NOW())
ORDER BY week, project
