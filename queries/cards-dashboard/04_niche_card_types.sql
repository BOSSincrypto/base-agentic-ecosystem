-- Q4: Card Types Distribution (V2 — Niche Interest)
-- Based on Collector Crypt rarity pool distributions
-- Sport wallet = Sport cards; all other rarity wallets = Pokemon / TCG
-- Engine: Medium (Solana transfers)

WITH cc_distributions AS (
    SELECT
        CASE from_owner
            WHEN 'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'  THEN 'Sport'
            WHEN 'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'  THEN 'Sport'
            ELSE 'Pokemon / TCG'
        END AS card_type,
        COUNT(*) AS cards_distributed
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2025-01-01'
      AND from_owner IN (
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
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'
      )
      AND to_owner NOT IN (
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
)

SELECT
    card_type,
    cards_distributed,
    ROUND(
        100.0 * cards_distributed
        / NULLIF(SUM(cards_distributed) OVER (), 0)
    , 1) AS pct
FROM cc_distributions
ORDER BY cards_distributed DESC
