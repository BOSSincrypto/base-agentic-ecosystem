-- Q2: Market Share — Total Volume by Project
-- Pie chart: each project's share of total gacha/cards market
-- Color by chain grouping (Base=blue, Polygon=purple, Solana=green)

WITH beezie AS (
    SELECT
        'Beezie'  AS project,
        'Base'    AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
),

courtyard AS (
    SELECT
        'Courtyard'  AS project,
        'Polygon'    AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= DATE '2026-01-01'
),

collector_crypt AS (
    SELECT
        'Collector Crypt'  AS project,
        'Solana'           AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner = 'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'
      )
),

upshot AS (
    SELECT
        'Upshot'  AS project,
        'Base'    AS chain,
        COALESCE(SUM(CAST(value AS DOUBLE) / 1e6), 0) AS total_volume_usd
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-01-01'
)

SELECT
    project,
    chain,
    ROUND(total_volume_usd, 2)              AS total_volume_usd,
    project || ' (' || chain || ')'         AS label
FROM (
    SELECT * FROM beezie
    UNION ALL SELECT * FROM courtyard
    UNION ALL SELECT * FROM collector_crypt
    UNION ALL SELECT * FROM upshot
)
ORDER BY total_volume_usd DESC
