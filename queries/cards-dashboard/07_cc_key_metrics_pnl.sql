-- Q7: Collector Crypt — Key Metrics P&L (weekly)
-- USDC flow analysis: gacha spend, buybacks, fees, net revenue
-- Based on DefiLlama adapter methodology (fees/collector-crypt/index.ts)
-- Engine: Medium

WITH gacha_weekly AS (
    SELECT
        date_trunc('week', block_time) AS week,
        SUM(amount_usd) AS gacha_spend
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
    GROUP BY 1
),

fees_weekly AS (
    SELECT
        date_trunc('week', block_time) AS week,
        SUM(amount_usd) AS fees
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner = 'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
    GROUP BY 1
),

buyback_weekly AS (
    SELECT
        date_trunc('week', block_time) AS week,
        SUM(amount_usd) AS buyback
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND from_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z'
      )
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND to_owner NOT IN (
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
          'Cc4pHGnoaRWL1WnHsV517T3YvQn5gLDBMiuVXkF9rZhK',
          '8373hLiAEXxaJ3oV7SRzx4KHwurEg9rEG98tUPj1sdtX',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
    GROUP BY 1
)

SELECT
    COALESCE(g.week, f.week, b.week)                                  AS week,
    COALESCE(ROUND(g.gacha_spend, 2), 0)                              AS gacha_spend,
    COALESCE(ROUND(b.buyback, 2), 0)                                  AS buyback,
    COALESCE(ROUND(f.fees, 2), 0)                                     AS fees,
    COALESCE(ROUND(g.gacha_spend, 2), 0)
      + COALESCE(ROUND(f.fees, 2), 0)
      - COALESCE(ROUND(b.buyback, 2), 0)                              AS net_revenue
FROM gacha_weekly g
FULL OUTER JOIN fees_weekly f ON g.week = f.week
FULL OUTER JOIN buyback_weekly b ON g.week = b.week
WHERE COALESCE(g.week, f.week, b.week) < date_trunc('week', NOW())
ORDER BY week DESC
