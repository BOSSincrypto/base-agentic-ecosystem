-- Section 7.3: Collector Crypt — Buyback Outflow & Net Revenue per Week
-- Mirror flow: USDC paid back to users via buyback program.
-- Net revenue (line) = weekly inflow minus outflow.
-- Chain: Solana | Engine: medium | Date: 2026-01-01+
--
-- Visualization: Combo chart
--   Bars: buyback_outflow | Line (right axis): net_revenue
--   KPI: total buybacks 4wk, net margin = SUM(net)/SUM(gross),
--         buyback ratio = outflow/inflow
--
-- Save as: "CC Deep Dive — 7.3 Buyback & Net Revenue"

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

outflow AS (
    SELECT
        date_trunc('week', t.block_time) AS week,
        ROUND(SUM(t.amount / 1e6), 2)   AS usdc_outflow,
        approx_distinct(t.tx_id)         AS num_buybacks,
        approx_distinct(t.to_owner)      AS unique_recipients
    FROM tokens_solana.transfers t
    JOIN gacha g ON t.from_owner = g.wallet
    WHERE t.block_date >= DATE '2026-01-01'
      AND t.token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND t.to_owner NOT IN (SELECT wallet FROM exclusions)
    GROUP BY 1
),

inflow AS (
    SELECT
        date_trunc('week', t.block_time) AS week,
        ROUND(SUM(t.amount / 1e6), 2)   AS usdc_inflow
    FROM tokens_solana.transfers t
    JOIN gacha g ON t.to_owner = g.wallet
    WHERE t.block_date >= DATE '2026-01-01'
      AND t.token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND t.from_owner NOT IN (SELECT wallet FROM exclusions)
    GROUP BY 1
)

SELECT
    COALESCE(o.week, i.week)                                       AS week,
    COALESCE(i.usdc_inflow, 0)                                     AS gross_inflow,
    COALESCE(o.usdc_outflow, 0)                                    AS buyback_outflow,
    ROUND(COALESCE(i.usdc_inflow, 0) - COALESCE(o.usdc_outflow, 0), 2) AS net_revenue,
    o.num_buybacks,
    o.unique_recipients
FROM outflow o
FULL OUTER JOIN inflow i ON o.week = i.week
ORDER BY week DESC
