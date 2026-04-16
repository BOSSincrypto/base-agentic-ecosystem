-- =====================================================================
-- OWB Token Analytics - Query 15: Hourly Trading Heatmap
-- Volume by UTC hour x day of week
-- Reveals peak windows and activity patterns (30d)
-- =====================================================================

WITH hourly_data AS (
    SELECT
        CASE day_of_week(block_time)
            WHEN 1 THEN 'Mon'
            WHEN 2 THEN 'Tue'
            WHEN 3 THEN 'Wed'
            WHEN 4 THEN 'Thu'
            WHEN 5 THEN 'Fri'
            WHEN 6 THEN 'Sat'
            WHEN 7 THEN 'Sun'
        END AS day_name,
        day_of_week(block_time) AS day_num,
        hour(block_time) AS hour_utc,
        SUM(amount_usd) AS volume_usd,
        COUNT(*) AS trade_count,
        COUNT(DISTINCT tx_from) AS unique_traders
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= now() - interval '30' day
    GROUP BY 1, 2, 3
)

SELECT
    day_name AS "Day",
    hour_utc AS "Hour (UTC)",
    ROUND(volume_usd, 2) AS "Volume (USD)",
    trade_count AS "Trades",
    unique_traders AS "Unique Traders",
    day_num AS sort_order
FROM hourly_data
ORDER BY day_num, hour_utc
