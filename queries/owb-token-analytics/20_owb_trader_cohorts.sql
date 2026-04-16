-- =====================================================================
-- OWB Token Analytics - Query 20: Trader Cohorts & Intelligence
-- Segmentation by activity: One-time, Power User (50+), Regular
-- New vs returning traders (daily), stickiness %, cumulative growth
-- =====================================================================

WITH all_trades AS (
    SELECT
        tx_from AS trader,
        date_trunc('day', block_time) AS day,
        amount_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= DATE '2026-01-01'
),

-- Trader first seen
first_trade AS (
    SELECT
        trader,
        MIN(day) AS first_day
    FROM all_trades
    GROUP BY 1
),

-- Daily new vs returning traders
daily_traders AS (
    SELECT
        at.day,
        COUNT(DISTINCT at.trader) AS total_traders,
        COUNT(DISTINCT CASE WHEN ft.first_day = at.day THEN at.trader END) AS new_traders,
        COUNT(DISTINCT CASE WHEN ft.first_day < at.day THEN at.trader END) AS returning_traders
    FROM all_trades at
    INNER JOIN first_trade ft ON at.trader = ft.trader
    GROUP BY 1
),

-- New unique traders per day for cumulative
new_per_day AS (
    SELECT first_day AS day, COUNT(*) AS new_unique
    FROM first_trade
    GROUP BY 1
),

-- Trader classification (all time)
trader_class AS (
    SELECT
        trader,
        COUNT(DISTINCT day) AS active_days,
        COUNT(*) AS total_trades,
        SUM(amount_usd) AS total_volume,
        CASE
            WHEN COUNT(DISTINCT day) = 1 THEN 'One-Time'
            WHEN COUNT(DISTINCT day) >= 20 AND COUNT(*) >= 50 THEN 'Power User (50+ trades)'
            WHEN COUNT(DISTINCT day) >= 5 THEN 'Regular'
            ELSE 'Casual'
        END AS classification
    FROM all_trades
    GROUP BY 1
),

-- Cohort summary
cohort_summary AS (
    SELECT
        classification,
        COUNT(*) AS trader_count,
        SUM(total_volume) AS cohort_volume,
        AVG(total_trades) AS avg_trades,
        AVG(active_days) AS avg_active_days
    FROM trader_class
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(dt.total_traders, 0) AS "Daily Traders",
    COALESCE(dt.new_traders, 0) AS "New Traders",
    COALESCE(dt.returning_traders, 0) AS "Returning Traders",
    CASE
        WHEN COALESCE(dt.total_traders, 0) > 0
        THEN ROUND(100.0 * dt.returning_traders / dt.total_traders, 1)
        ELSE 0
    END AS "Returning %",
    -- Cumulative unique
    SUM(COALESCE(npd.new_unique, 0)) OVER (ORDER BY ds.day) AS "Cumulative Unique Traders",
    -- 7d MA
    ROUND(AVG(COALESCE(dt.total_traders, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "Traders 7d MA"
FROM date_spine ds
LEFT JOIN daily_traders dt ON ds.day = dt.day
LEFT JOIN new_per_day npd ON ds.day = npd.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
