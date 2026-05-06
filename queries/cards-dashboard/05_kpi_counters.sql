-- Q5: Combined KPI Counters
-- 4 key numbers for the top of the dashboard
-- Columns: total_volume_usd, unique_users, top_project, wow_growth_pct

WITH beezie_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(buyer)       AS users
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
),

courtyard_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(buyer)       AS users
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= DATE '2026-01-01'
),

cc_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0)   AS vol,
        approx_distinct(from_owner)    AS users
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

upshot_vol AS (
    SELECT
        COALESCE(SUM(CAST(value AS DOUBLE) / 1e6), 0) AS vol,
        approx_distinct("from")                        AS users
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

this_week AS (
    SELECT COALESCE(SUM(amount_usd), 0) AS vol
    FROM nft.trades
    WHERE blockchain IN ('base', 'polygon')
      AND nft_contract_address IN (
          0xbb5ec6fd4b61723bd45c399840f1d868840ca16f,
          0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      )
      AND block_time >= NOW() - INTERVAL '7' DAY
),

prev_week AS (
    SELECT COALESCE(SUM(amount_usd), 0) AS vol
    FROM nft.trades
    WHERE blockchain IN ('base', 'polygon')
      AND nft_contract_address IN (
          0xbb5ec6fd4b61723bd45c399840f1d868840ca16f,
          0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      )
      AND block_time >= NOW() - INTERVAL '14' DAY
      AND block_time <  NOW() - INTERVAL '7' DAY
),

totals AS (
    SELECT
        (SELECT vol FROM beezie_vol)
      + (SELECT vol FROM courtyard_vol)
      + (SELECT vol FROM cc_vol)
      + (SELECT vol FROM upshot_vol) AS total_volume,
        (SELECT users FROM beezie_vol)
      + (SELECT users FROM courtyard_vol)
      + (SELECT users FROM cc_vol)
      + (SELECT users FROM upshot_vol) AS total_users
),

top AS (
    SELECT project, vol FROM (
        VALUES
            ('Beezie',          (SELECT vol FROM beezie_vol)),
            ('Courtyard',       (SELECT vol FROM courtyard_vol)),
            ('Collector Crypt', (SELECT vol FROM cc_vol)),
            ('Upshot',          (SELECT vol FROM upshot_vol))
    ) AS t(project, vol)
    ORDER BY vol DESC
    LIMIT 1
)

SELECT
    ROUND((SELECT total_volume FROM totals), 0)  AS total_volume_usd,
    (SELECT total_users FROM totals)              AS unique_users,
    (SELECT project FROM top)                     AS top_project,
    ROUND(
        100.0 * ((SELECT vol FROM this_week) - (SELECT vol FROM prev_week))
        / NULLIF((SELECT vol FROM prev_week), 0)
    , 1)                                          AS wow_growth_pct
