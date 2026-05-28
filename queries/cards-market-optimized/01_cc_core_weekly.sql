-- Section 7 COMBINED: Collector Crypt — Weekly Gacha Plays + USDC Inflow + Buyback + Net Revenue
-- ONE scan of tokens_solana.transfers replaces THREE separate queries (7.1 + 7.2 + 7.3).
-- Saves ~66% Dune credits vs running 7.1, 7.2, 7.3 independently.
-- Chain: Solana | Engine: medium | Date: 2026-01-01+
--
-- Output columns serve multiple visualizations:
--   7.1 chart: week, gacha_plays, unique_players, cards_distributed
--   7.2 chart: week, usdc_inflow, inflow_transfers, unique_payers
--   7.3 chart: week, buyback_outflow, net_revenue, num_buybacks, unique_recipients
--
-- Save as: "CC Deep Dive — 7.1-7.3 Core Weekly"

WITH gacha AS (
    SELECT wallet FROM (VALUES
        ('GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'),
        ('GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z'),
        ('96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s')
    ) AS t(wallet)
),

exclusions AS (
    SELECT wallet FROM (VALUES
        ('BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M'),
        ('21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8'),
        ('DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE'),
        ('HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u'),
        ('Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu'),
        ('Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN'),
        ('Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney'),
        ('miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt'),
        ('HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns'),
        ('HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb'),
        ('EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF'),
        ('epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn'),
        ('LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf'),
        ('LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj'),
        ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs'),
        ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'),
        ('SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'),
        ('DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd'),
        ('cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'),
        ('GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'),
        ('GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z'),
        ('96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s')
    ) AS t(wallet)
),

classified AS (
    SELECT
        date_trunc('week', t.block_time) AS week,
        CASE
            WHEN t.from_owner IN (SELECT wallet FROM gacha)
                 AND t.to_owner NOT IN (SELECT wallet FROM exclusions)
                 AND t.token_mint_address != 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
            THEN 'card_out'
            WHEN t.to_owner IN (SELECT wallet FROM gacha)
                 AND t.from_owner NOT IN (SELECT wallet FROM exclusions)
                 AND t.token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
            THEN 'usdc_in'
            WHEN t.from_owner IN (SELECT wallet FROM gacha)
                 AND t.to_owner NOT IN (SELECT wallet FROM exclusions)
                 AND t.token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
            THEN 'usdc_out'
        END AS flow_type,
        t.amount,
        t.tx_id,
        t.from_owner,
        t.to_owner
    FROM tokens_solana.transfers t
    WHERE t.block_date >= DATE '2026-01-01'
      AND (
          t.from_owner IN (SELECT wallet FROM gacha)
          OR t.to_owner IN (SELECT wallet FROM gacha)
      )
)

SELECT
    week,

    -- 7.1: Gacha Plays (aggregate fallback, no tier split)
    approx_distinct(CASE WHEN flow_type = 'card_out' THEN tx_id END)      AS gacha_plays,
    approx_distinct(CASE WHEN flow_type = 'card_out' THEN to_owner END)    AS unique_players,
    COUNT(CASE WHEN flow_type = 'card_out' THEN 1 END)                     AS cards_distributed,

    -- 7.2: USDC Inflow (gross revenue)
    ROUND(SUM(CASE WHEN flow_type = 'usdc_in' THEN amount / 1e6 ELSE 0 END), 2)   AS usdc_inflow,
    approx_distinct(CASE WHEN flow_type = 'usdc_in' THEN tx_id END)                 AS inflow_transfers,
    approx_distinct(CASE WHEN flow_type = 'usdc_in' THEN from_owner END)             AS unique_payers,

    -- 7.3: Buyback Outflow
    ROUND(SUM(CASE WHEN flow_type = 'usdc_out' THEN amount / 1e6 ELSE 0 END), 2)   AS buyback_outflow,
    approx_distinct(CASE WHEN flow_type = 'usdc_out' THEN tx_id END)                 AS num_buybacks,
    approx_distinct(CASE WHEN flow_type = 'usdc_out' THEN to_owner END)              AS unique_recipients,

    -- 7.3: Net Revenue (inflow - outflow)
    ROUND(
        SUM(CASE WHEN flow_type = 'usdc_in' THEN amount / 1e6 ELSE 0 END)
      - SUM(CASE WHEN flow_type = 'usdc_out' THEN amount / 1e6 ELSE 0 END),
    2) AS net_revenue

FROM classified
WHERE flow_type IS NOT NULL
GROUP BY 1
ORDER BY week DESC
