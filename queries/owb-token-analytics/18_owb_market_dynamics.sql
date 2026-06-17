-- =====================================================================
-- OWB Token Analytics - Query 18: Market Dynamics
-- Price + MA 7d/30d + 14d Momentum Oscillator + Annualized Volatility
-- Provides technical analysis view of OWB price action
-- =====================================================================

WITH daily_price AS (
    SELECT
        date_trunc('day', block_time) AS day,
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
        ) AS vwap,
        SUM(amount_usd) AS volume
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
    HAVING SUM(amount_usd) > 0
),

with_ma AS (
    SELECT
        day,
        vwap,
        volume,
        AVG(vwap) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7d,
        AVG(vwap) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS ma_30d,
        LAG(vwap, 1) OVER (ORDER BY day) AS prev_price,
        LAG(vwap, 14) OVER (ORDER BY day) AS price_14d_ago
    FROM daily_price
),

with_momentum AS (
    SELECT
        day,
        vwap,
        volume,
        ma_7d,
        ma_30d,
        -- Daily return
        CASE
            WHEN prev_price > 0
            THEN (vwap - prev_price) / prev_price
            ELSE 0
        END AS daily_return,
        -- 14d Momentum Oscillator (Rate of Change)
        CASE
            WHEN price_14d_ago > 0
            THEN 100.0 * (vwap - price_14d_ago) / price_14d_ago
            ELSE 0
        END AS momentum_14d
    FROM with_ma
)

SELECT
    day,
    ROUND(vwap, 6) AS "Price (VWAP)",
    ROUND(ma_7d, 6) AS "7d MA",
    ROUND(ma_30d, 6) AS "30d MA",
    ROUND(volume, 2) AS "Volume (USD)",
    ROUND(daily_return * 100, 2) AS "Daily Return %",
    ROUND(momentum_14d, 2) AS "14d Momentum %",
    -- MA Signal
    CASE
        WHEN ma_7d > ma_30d THEN 'Bullish'
        WHEN ma_7d < ma_30d THEN 'Bearish'
        ELSE 'Neutral'
    END AS "MA Signal",
    -- Annualized Volatility (rolling 30d)
    ROUND(
        STDDEV(daily_return) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW)
        * SQRT(365) * 100
    , 2) AS "Ann. Volatility %",
    -- Price vs 30d MA deviation
    ROUND(100.0 * (vwap - ma_30d) / NULLIF(ma_30d, 0), 2) AS "Price vs 30d MA %"
FROM with_momentum
ORDER BY day ASC
