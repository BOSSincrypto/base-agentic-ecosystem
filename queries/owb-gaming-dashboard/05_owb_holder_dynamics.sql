-- OWB Agentic Gaming Dashboard - Query 5: Holder Dynamics & Distribution
-- Tracks new holders, holder growth, and distribution by size
-- Save as: "OWB Gaming - Holder Dynamics"

WITH all_receivers AS (
    SELECT
        "to" AS wallet,
        MIN(block_date) AS first_received
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
    GROUP BY 1
),

-- Daily new holders
daily_new AS (
    SELECT
        first_received AS day,
        COUNT(DISTINCT wallet) AS new_holders
    FROM all_receivers
    GROUP BY 1
),

-- Current balance estimation (net transfers)
balances AS (
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

-- Distribution buckets
distribution AS (
    SELECT
        CASE
            WHEN balance < 1000 THEN 'Dust (<1K OWB)'
            WHEN balance < 10000 THEN 'Retail (1K-10K)'
            WHEN balance < 100000 THEN 'Mid (10K-100K)'
            WHEN balance < 1000000 THEN 'Large (100K-1M)'
            WHEN balance < 10000000 THEN 'Whale (1M-10M)'
            ELSE 'Mega Whale (10M+)'
        END AS holder_bucket,
        CASE
            WHEN balance < 1000 THEN 1
            WHEN balance < 10000 THEN 2
            WHEN balance < 100000 THEN 3
            WHEN balance < 1000000 THEN 4
            WHEN balance < 10000000 THEN 5
            ELSE 6
        END AS bucket_order,
        COUNT(*) AS holder_count,
        SUM(balance) AS total_balance
    FROM balances
    GROUP BY 1, 2
)

-- Part A: Daily new holder growth
SELECT
    day,
    new_holders AS "New Holders",
    SUM(new_holders) OVER (ORDER BY day) AS "Cumulative Holders",
    AVG(new_holders) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "New Holders 7d MA"
FROM daily_new
WHERE day >= DATE '2026-01-01'
  AND day < current_date
ORDER BY day ASC

-- NOTE: Run Part B (distribution) separately as a second visualization:
-- SELECT
--     holder_bucket AS "Holder Bucket",
--     holder_count AS "Number of Holders",
--     ROUND(total_balance, 0) AS "Total OWB Held",
--     ROUND(100.0 * total_balance / NULLIF((SELECT SUM(balance) FROM balances), 0), 2) AS "% of Supply"
-- FROM distribution
-- ORDER BY bucket_order
