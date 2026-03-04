-- OWB Agentic Gaming Dashboard - Query 6: Holder Distribution & Concentration
-- Pie chart data: who holds OWB and how concentrated is supply
-- Save as: "OWB Gaming - Holder Distribution"

WITH balances AS (
    SELECT
        wallet,
        SUM(net_amount) AS balance
    FROM (
        SELECT "to" AS wallet, amount AS net_amount
        FROM tokens.transfers
        WHERE blockchain = 'base'
          AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
        UNION ALL
        SELECT "from" AS wallet, -amount AS net_amount
        FROM tokens.transfers
        WHERE blockchain = 'base'
          AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
    ) t
    GROUP BY 1
    HAVING SUM(net_amount) > 0
),

total_supply AS (
    SELECT SUM(balance) AS total FROM balances
),

distribution AS (
    SELECT
        CASE
            WHEN balance < 1000 THEN 'Dust (<1K OWB)'
            WHEN balance < 10000 THEN 'Retail (1K-10K)'
            WHEN balance < 100000 THEN 'Mid (10K-100K)'
            WHEN balance < 1000000 THEN 'Large (100K-1M)'
            WHEN balance < 10000000 THEN 'Whale (1M-10M)'
            ELSE 'Mega Whale (10M+)'
        END AS "Holder Bucket",
        CASE
            WHEN balance < 1000 THEN 1
            WHEN balance < 10000 THEN 2
            WHEN balance < 100000 THEN 3
            WHEN balance < 1000000 THEN 4
            WHEN balance < 10000000 THEN 5
            ELSE 6
        END AS bucket_order,
        COUNT(*) AS "Number of Holders",
        ROUND(SUM(balance), 0) AS "Total OWB Held",
        ROUND(100.0 * SUM(balance) / NULLIF((SELECT total FROM total_supply), 0), 2) AS "% of Supply"
    FROM balances
    GROUP BY 1, 2
)

SELECT
    "Holder Bucket",
    "Number of Holders",
    "Total OWB Held",
    "% of Supply"
FROM distribution
ORDER BY bucket_order
