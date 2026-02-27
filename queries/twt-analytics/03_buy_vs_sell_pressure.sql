-- TWT: Buy vs Sell Pressure
-- Purpose: Directional DEX pressure analysis - buy/sell volume split
-- Visualization: Stacked bar chart (buy green / sell red) + net flow overlay line

WITH trades AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        CASE
            WHEN token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
            THEN 'buy'
            ELSE 'sell'
        END AS side,
        amount_usd,
        tx_from
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_date >= CURRENT_DATE - INTERVAL '180' day
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
      AND amount_usd > 0
)
SELECT
    day,
    SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END) AS buy_volume_usd,
    SUM(CASE WHEN side = 'sell' THEN amount_usd ELSE 0 END) AS sell_volume_usd,
    SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END)
      - SUM(CASE WHEN side = 'sell' THEN amount_usd ELSE 0 END) AS net_flow_usd,
    COUNT(DISTINCT CASE WHEN side = 'buy' THEN tx_from END) AS unique_buyers,
    COUNT(DISTINCT CASE WHEN side = 'sell' THEN tx_from END) AS unique_sellers,
    ROUND(
        100.0 * SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END)
        / NULLIF(SUM(amount_usd), 0),
        1
    ) AS buy_ratio_pct
FROM trades
GROUP BY 1
ORDER BY 1
