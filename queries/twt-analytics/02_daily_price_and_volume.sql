-- TWT: Daily Price & DEX Volume
-- Purpose: Price trend with 7d/30d MAs overlaid on DEX volume
-- Visualization: Combined chart - line (price) + bars (volume), dual Y-axis

WITH daily_price AS (
    SELECT
        DATE_TRUNC('day', minute) AS day,
        AVG(price) AS price_usd
    FROM prices.usd
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND minute >= CAST('2024-01-01' AS TIMESTAMP)
    GROUP BY 1
),
daily_volume AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        SUM(amount_usd) AS dex_volume_usd,
        COUNT(*) AS trades_count
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_date >= CAST('2024-01-01' AS DATE)
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
    GROUP BY 1
)
SELECT
    COALESCE(p.day, v.day) AS day,
    p.price_usd,
    v.dex_volume_usd,
    v.trades_count,
    AVG(p.price_usd) OVER (ORDER BY p.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_price,
    AVG(p.price_usd) OVER (ORDER BY p.day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS ma30_price,
    AVG(v.dex_volume_usd) OVER (ORDER BY COALESCE(p.day, v.day) ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_volume
FROM daily_price p
FULL OUTER JOIN daily_volume v ON p.day = v.day
WHERE COALESCE(p.day, v.day) IS NOT NULL
ORDER BY 1
