-- =====================================================================
-- OWB Token Analytics - Query 13: Buy vs Sell Pressure
-- Daily buy/sell volume, ratio, net buy pressure
-- "Buy" = trader acquires OWB (token_bought = OWB)
-- "Sell" = trader disposes OWB (token_sold = OWB)
-- =====================================================================

WITH daily_trades AS (
    SELECT
        date_trunc('day', block_time) AS day,
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
            THEN 'buy'
            ELSE 'sell'
        END AS direction,
        amount_usd,
        tx_from
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= DATE '2026-01-01'
),

daily_agg AS (
    SELECT
        day,
        COALESCE(SUM(CASE WHEN direction = 'buy' THEN amount_usd END), 0) AS buy_volume,
        COALESCE(SUM(CASE WHEN direction = 'sell' THEN amount_usd END), 0) AS sell_volume,
        COUNT(CASE WHEN direction = 'buy' THEN 1 END) AS buy_count,
        COUNT(CASE WHEN direction = 'sell' THEN 1 END) AS sell_count,
        COUNT(DISTINCT CASE WHEN direction = 'buy' THEN tx_from END) AS unique_buyers,
        COUNT(DISTINCT CASE WHEN direction = 'sell' THEN tx_from END) AS unique_sellers
    FROM daily_trades
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    ROUND(COALESCE(da.buy_volume, 0), 2) AS "Buy Volume (USD)",
    ROUND(COALESCE(da.sell_volume, 0), 2) AS "Sell Volume (USD)",
    ROUND(COALESCE(da.buy_volume, 0) - COALESCE(da.sell_volume, 0), 2) AS "Net Buy Pressure",
    -- Buy/Sell Ratio
    CASE
        WHEN COALESCE(da.sell_volume, 0) > 0
        THEN ROUND(da.buy_volume / da.sell_volume, 2)
        ELSE NULL
    END AS "Buy/Sell Ratio",
    COALESCE(da.buy_count, 0) AS "Buy Trades",
    COALESCE(da.sell_count, 0) AS "Sell Trades",
    COALESCE(da.unique_buyers, 0) AS "Unique Buyers",
    COALESCE(da.unique_sellers, 0) AS "Unique Sellers",
    -- 7d MA
    ROUND(AVG(COALESCE(da.buy_volume, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS "Buy Vol 7d MA",
    ROUND(AVG(COALESCE(da.sell_volume, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS "Sell Vol 7d MA",
    ROUND(AVG(COALESCE(da.buy_volume, 0) - COALESCE(da.sell_volume, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS "Net Pressure 7d MA"
FROM date_spine ds
LEFT JOIN daily_agg da ON ds.day = da.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
