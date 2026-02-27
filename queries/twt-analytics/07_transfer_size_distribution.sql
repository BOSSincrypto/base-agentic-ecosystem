-- TWT: Transfer Size Distribution (Cohort Analysis)
-- Purpose: Understand if activity is retail or whale driven
-- Visualization: Stacked area chart (100% normalized) by size bucket

WITH transfers AS (
    SELECT
        block_date AS day,
        amount_usd,
        CASE
            WHEN amount_usd < 100 THEN 'Micro (<$100)'
            WHEN amount_usd < 1000 THEN 'Small ($100-$1K)'
            WHEN amount_usd < 10000 THEN 'Medium ($1K-$10K)'
            WHEN amount_usd < 100000 THEN 'Large ($10K-$100K)'
            ELSE 'Whale ($100K+)'
        END AS size_bucket,
        CASE
            WHEN amount_usd < 100 THEN 1
            WHEN amount_usd < 1000 THEN 2
            WHEN amount_usd < 10000 THEN 3
            WHEN amount_usd < 100000 THEN 4
            ELSE 5
        END AS bucket_order
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CURRENT_DATE - INTERVAL '90' day
      AND amount_usd > 0
)
SELECT
    day,
    size_bucket,
    bucket_order,
    COUNT(*) AS tx_count,
    SUM(amount_usd) AS total_volume_usd,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY day), 1) AS pct_of_txs,
    ROUND(100.0 * SUM(amount_usd) / NULLIF(SUM(SUM(amount_usd)) OVER (PARTITION BY day), 0), 1) AS pct_of_volume
FROM transfers
GROUP BY 1, 2, 3
ORDER BY 1, 3
