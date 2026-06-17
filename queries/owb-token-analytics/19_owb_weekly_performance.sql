-- =====================================================================
-- OWB Token Analytics - Query 19: Weekly Performance Table
-- WoW table: Swaps, Unique Traders, Volume, Avg Price,
-- Avg Trade Size, Buy/Sell Ratio with % change
-- Uses rolling 7-day windows (not calendar weeks)
-- =====================================================================

WITH weekly_raw AS (
    SELECT
        date_trunc('week', block_time) AS week_start,
        COUNT(*) AS swaps,
        COUNT(DISTINCT tx_from) AS unique_traders,
        SUM(amount_usd) AS total_volume,
        AVG(amount_usd) AS avg_trade_size,
        SUM(CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
            THEN amount_usd ELSE 0
        END) AS buy_volume,
        SUM(CASE
            WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
            THEN amount_usd ELSE 0
        END) AS sell_volume,
        -- VWAP
        SUM(amount_usd) / NULLIF(
            SUM(
                CASE
                    WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
                    THEN CAST(token_bought_amount AS DOUBLE) / 1e18
                    WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
                    THEN CAST(token_sold_amount AS DOUBLE) / 1e18
                    ELSE 0
                END
            ), 0
        ) AS avg_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

with_lag AS (
    SELECT
        week_start,
        swaps,
        unique_traders,
        total_volume,
        avg_trade_size,
        avg_price,
        CASE
            WHEN sell_volume > 0 THEN ROUND(buy_volume / sell_volume, 2)
            ELSE NULL
        END AS buy_sell_ratio,
        LAG(swaps) OVER (ORDER BY week_start) AS prev_swaps,
        LAG(unique_traders) OVER (ORDER BY week_start) AS prev_traders,
        LAG(total_volume) OVER (ORDER BY week_start) AS prev_volume,
        LAG(avg_price) OVER (ORDER BY week_start) AS prev_price,
        LAG(avg_trade_size) OVER (ORDER BY week_start) AS prev_avg_trade
    FROM weekly_raw
)

SELECT
    week_start AS "Week",
    swaps AS "Swaps",
    CASE
        WHEN prev_swaps > 0
        THEN ROUND(100.0 * (swaps - prev_swaps) / prev_swaps, 1)
        ELSE NULL
    END AS "Swaps WoW %",
    unique_traders AS "Unique Traders",
    CASE
        WHEN prev_traders > 0
        THEN ROUND(100.0 * (unique_traders - prev_traders) / prev_traders, 1)
        ELSE NULL
    END AS "Traders WoW %",
    ROUND(total_volume, 2) AS "Volume (USD)",
    CASE
        WHEN prev_volume > 0
        THEN ROUND(100.0 * (total_volume - prev_volume) / prev_volume, 1)
        ELSE NULL
    END AS "Volume WoW %",
    ROUND(avg_price, 6) AS "Avg Price",
    CASE
        WHEN prev_price > 0
        THEN ROUND(100.0 * (avg_price - prev_price) / prev_price, 1)
        ELSE NULL
    END AS "Price WoW %",
    ROUND(avg_trade_size, 2) AS "Avg Trade Size",
    buy_sell_ratio AS "Buy/Sell Ratio"
FROM with_lag
ORDER BY week_start DESC
