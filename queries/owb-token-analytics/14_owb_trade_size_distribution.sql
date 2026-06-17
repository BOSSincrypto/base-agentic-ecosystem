-- =====================================================================
-- OWB Token Analytics - Query 14: Trade Size Distribution (30d)
-- Histogram of trade sizes over the last 30 days
-- Shows what % of trades and volume per size bucket
-- =====================================================================

WITH recent_trades AS (
    SELECT
        amount_usd,
        CASE
            WHEN amount_usd < 10 THEN '<$10'
            WHEN amount_usd < 100 THEN '$10-$100'
            WHEN amount_usd < 1000 THEN '$100-$1K'
            WHEN amount_usd < 10000 THEN '$1K-$10K'
            ELSE '>$10K'
        END AS size_bucket,
        CASE
            WHEN amount_usd < 10 THEN 1
            WHEN amount_usd < 100 THEN 2
            WHEN amount_usd < 1000 THEN 3
            WHEN amount_usd < 10000 THEN 4
            ELSE 5
        END AS bucket_order
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= now() - interval '30' day
      AND amount_usd > 0
),

totals AS (
    SELECT
        COUNT(*) AS total_trades,
        SUM(amount_usd) AS total_volume
    FROM recent_trades
)

SELECT
    rt.size_bucket AS "Trade Size",
    COUNT(*) AS "Number of Trades",
    ROUND(100.0 * COUNT(*) / NULLIF(t.total_trades, 0), 1) AS "% of Trades",
    ROUND(SUM(rt.amount_usd), 2) AS "Volume (USD)",
    ROUND(100.0 * SUM(rt.amount_usd) / NULLIF(t.total_volume, 0), 1) AS "% of Volume",
    ROUND(AVG(rt.amount_usd), 2) AS "Avg Trade Size",
    MIN(rt.bucket_order) AS sort_order
FROM recent_trades rt
CROSS JOIN totals t
GROUP BY rt.size_bucket, t.total_trades, t.total_volume
ORDER BY sort_order
