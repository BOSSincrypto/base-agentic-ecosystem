-- Q2: Market Share — Total Volume by Project (V2 — 5 projects)
-- Donut pie chart showing each project's share of the gacha market
-- Engine: Medium (Solana queries)

WITH beezie AS (
    SELECT 'Beezie' AS project, 'Base' AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
),

courtyard AS (
    SELECT 'Courtyard' AS project, 'Polygon' AS chain,
        COALESCE(ROUND(SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6, 2), 0) AS total_volume_usd
    FROM polygon.logs
    WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
      AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
      AND block_date >= DATE '2026-01-01'
),

collector_crypt AS (
    SELECT 'Collector Crypt' AS project, 'Solana' AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
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

upshot AS (
    SELECT 'Upshot' AS project, 'Base' AS chain,
        COALESCE(SUM(CAST(value AS DOUBLE) / 1e6), 0) AS total_volume_usd
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

phygitals AS (
    SELECT 'Phygitals' AS project, 'Solana' AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
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
)

SELECT
    project,
    chain,
    ROUND(total_volume_usd, 2) AS total_volume_usd,
    project || ' (' || chain || ')' AS label
FROM (
    SELECT * FROM beezie
    UNION ALL SELECT * FROM courtyard
    UNION ALL SELECT * FROM collector_crypt
    UNION ALL SELECT * FROM upshot
    UNION ALL SELECT * FROM phygitals
)
ORDER BY total_volume_usd DESC
