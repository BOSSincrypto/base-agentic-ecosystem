-- Q6: Collector Crypt — Gacha Plays by Rarity (weekly)
-- Adapted from Giedi's public query (cont_2.md context)
-- Shows card distributions from rarity pools to players
-- Recommended: medium engine (Solana token transfers are heavy)

WITH rarity_wallets AS (
    SELECT * FROM (
        VALUES
            ('Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',  'Low'),
            ('Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',  'Low'),
            ('Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',  'Mid'),
            ('miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',  'Mid'),
            ('HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns', 'High'),
            ('HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',  'High'),
            ('EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',  'Epic'),
            ('epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',  'Epic'),
            ('LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',  'Legend'),
            ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',   'One'),
            ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',  'Sport')
    ) AS t(wallet, rarity)
),

excluded_recipients AS (
    SELECT address FROM (
        VALUES
            ('Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu'),
            ('Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN'),
            ('Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney'),
            ('miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt'),
            ('HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns'),
            ('HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb'),
            ('EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF'),
            ('epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn'),
            ('LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf'),
            ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs'),
            ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'),
            ('DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd'),
            ('cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'),
            ('GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3')
    ) AS t(address)
)

SELECT
    date_trunc('week', tr.block_time)   AS week,
    rw.rarity,
    approx_distinct(tr.tx_id)           AS plays,
    approx_distinct(tr.to_owner)        AS unique_players,
    COUNT(*)                            AS cards_distributed
FROM tokens_solana.transfers tr
INNER JOIN rarity_wallets rw
    ON tr.from_owner = rw.wallet
WHERE tr.block_date >= DATE '2026-01-01'
  AND tr.to_owner NOT IN (SELECT address FROM excluded_recipients)
GROUP BY 1, 2
ORDER BY week DESC, plays DESC
