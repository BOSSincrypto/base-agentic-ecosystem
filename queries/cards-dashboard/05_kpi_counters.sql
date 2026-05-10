-- Q5: Combined KPI Counters (V2 — 5 projects)
-- 5 key numbers: total_volume_usd, unique_users, top_project, active_projects, wow_growth_pct
-- Engine: Medium (Solana queries)

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
        COALESCE(ROUND(SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6, 2), 0) AS vol,
        COUNT(DISTINCT tx_hash) AS users
    FROM polygon.logs
    WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
      AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
      AND block_date >= DATE '2026-01-01'
),

cc_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(from_owner)  AS users
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
          '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
          'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
          'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
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

phygitals_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(from_owner)  AS users
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND (
          (to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e'
           AND from_owner NOT IN ('62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '4SabGkbLc9uxzrq4f1Es9tJPZfHVzP28kwSosR2sYJRt'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
      )
),

vol_values AS (
    SELECT
        (SELECT vol FROM beezie_vol)    AS beezie_v,
        (SELECT vol FROM courtyard_vol) AS courtyard_v,
        (SELECT vol FROM cc_vol)        AS cc_v,
        (SELECT vol FROM upshot_vol)    AS upshot_v,
        (SELECT vol FROM phygitals_vol) AS phygitals_v
),

all_projects AS (
    SELECT project, vol FROM (
        SELECT 'Beezie' AS project, beezie_v AS vol FROM vol_values
        UNION ALL
        SELECT 'Courtyard', courtyard_v FROM vol_values
        UNION ALL
        SELECT 'Collector Crypt', cc_v FROM vol_values
        UNION ALL
        SELECT 'Upshot', upshot_v FROM vol_values
        UNION ALL
        SELECT 'Phygitals', phygitals_v FROM vol_values
    )
),

this_week AS (
    SELECT
        COALESCE((
            SELECT SUM(amount_usd) FROM nft.trades
            WHERE blockchain = 'base'
              AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
              AND block_time >= NOW() - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6 FROM polygon.logs
            WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
              AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
              AND block_date >= CURRENT_DATE - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(amount_usd) FROM tokens_solana.transfers
            WHERE block_date >= CURRENT_DATE - INTERVAL '7' DAY
              AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
              AND to_owner IN (
                  'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
                  'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
                  '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
              )
              AND from_owner NOT IN (
                  'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
                  '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
                  'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
                  'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
                  'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
                  'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
                  'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
                  'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
                  'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
                  'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
                  'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
                  'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
                  'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
                  'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
                  'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
                  'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
                  'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
                  'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
                  'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
                  'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
                  'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
                  '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
              )
        ), 0)
      + COALESCE((
            SELECT SUM(amount_usd) FROM tokens_solana.transfers
            WHERE block_date >= CURRENT_DATE - INTERVAL '7' DAY
              AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
              AND (
                  (to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
                   AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
                  OR
                  (to_owner = '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e'
                   AND from_owner NOT IN ('62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS',
                                          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
                  OR
                  (to_owner = '4SabGkbLc9uxzrq4f1Es9tJPZfHVzP28kwSosR2sYJRt'
                   AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
              )
        ), 0)
      + COALESCE((
            SELECT SUM(CAST(value AS DOUBLE) / 1e6) FROM erc20_base.evt_Transfer
            WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
              AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
              AND evt_block_time >= NOW() - INTERVAL '7' DAY
        ), 0) AS vol
),

prev_week AS (
    SELECT
        COALESCE((
            SELECT SUM(amount_usd) FROM nft.trades
            WHERE blockchain = 'base'
              AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
              AND block_time >= NOW() - INTERVAL '14' DAY
              AND block_time <  NOW() - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6 FROM polygon.logs
            WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
              AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
              AND block_date >= CURRENT_DATE - INTERVAL '14' DAY
              AND block_date <  CURRENT_DATE - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(amount_usd) FROM tokens_solana.transfers
            WHERE block_date >= CURRENT_DATE - INTERVAL '14' DAY
              AND block_date <  CURRENT_DATE - INTERVAL '7' DAY
              AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
              AND to_owner IN (
                  'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
                  'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
                  '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
              )
              AND from_owner NOT IN (
                  'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
                  '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
                  'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
                  'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
                  'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
                  'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
                  'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
                  'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
                  'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
                  'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
                  'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
                  'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
                  'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
                  'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
                  'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
                  'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
                  'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
                  'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
                  'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
                  'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
                  'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
                  '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
              )
        ), 0)
      + COALESCE((
            SELECT SUM(amount_usd) FROM tokens_solana.transfers
            WHERE block_date >= CURRENT_DATE - INTERVAL '14' DAY
              AND block_date <  CURRENT_DATE - INTERVAL '7' DAY
              AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
              AND (
                  (to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
                   AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
                  OR
                  (to_owner = '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e'
                   AND from_owner NOT IN ('62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS',
                                          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
                  OR
                  (to_owner = '4SabGkbLc9uxzrq4f1Es9tJPZfHVzP28kwSosR2sYJRt'
                   AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
              )
        ), 0)
      + COALESCE((
            SELECT SUM(CAST(value AS DOUBLE) / 1e6) FROM erc20_base.evt_Transfer
            WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
              AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
              AND evt_block_time >= NOW() - INTERVAL '14' DAY
              AND evt_block_time <  NOW() - INTERVAL '7' DAY
        ), 0) AS vol
)

SELECT
    ROUND((SELECT SUM(vol) FROM all_projects), 0) AS total_volume_usd,
    COALESCE((SELECT users FROM beezie_vol), 0)
  + COALESCE((SELECT users FROM courtyard_vol), 0)
  + COALESCE((SELECT users FROM cc_vol), 0)
  + COALESCE((SELECT users FROM upshot_vol), 0)
  + COALESCE((SELECT users FROM phygitals_vol), 0)   AS unique_users,
    (SELECT project FROM all_projects ORDER BY vol DESC LIMIT 1) AS top_project,
    (SELECT COUNT(*) FROM all_projects WHERE vol > 0) AS active_projects,
    ROUND(
        100.0 * ((SELECT vol FROM this_week) - (SELECT vol FROM prev_week))
        / NULLIF((SELECT vol FROM prev_week), 0)
    , 1)                                              AS wow_growth_pct
