-- TWT: Unique DEX Traders (New vs Returning)
-- Purpose: Track daily unique traders with new/returning split + cumulative growth
-- Visualization: Stacked area (new blue / returning purple) + cumulative line on right Y

WITH daily_traders AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        tx_from AS trader
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_date >= CAST('2024-01-01' AS DATE)
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
    GROUP BY 1, 2
),
first_seen AS (
    SELECT
        trader,
        MIN(day) AS first_day
    FROM daily_traders
    GROUP BY 1
),
classified AS (
    SELECT
        dt.day,
        dt.trader,
        CASE WHEN dt.day = fs.first_day THEN 'new' ELSE 'returning' END AS trader_type
    FROM daily_traders dt
    JOIN first_seen fs ON dt.trader = fs.trader
)
SELECT
    day,
    COUNT(DISTINCT CASE WHEN trader_type = 'new' THEN trader END) AS new_traders,
    COUNT(DISTINCT CASE WHEN trader_type = 'returning' THEN trader END) AS returning_traders,
    COUNT(DISTINCT trader) AS total_traders,
    SUM(COUNT(DISTINCT CASE WHEN trader_type = 'new' THEN trader END)) OVER (ORDER BY day) AS cumulative_unique_traders
FROM classified
GROUP BY 1
ORDER BY 1
