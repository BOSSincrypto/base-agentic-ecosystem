-- OWB Agentic Gaming Dashboard - Query 3: OWB DEX Trading Analytics
-- Buy vs sell pressure, DEX breakdown, price dynamics
-- Save as: "OWB Gaming - DEX Analytics"

WITH trades AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN 'buy'
            ELSE 'sell'
        END AS side,
        amount_usd,
        tx_from,
        project,
        -- Calculate execution price
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND token_bought_amount > 0
            THEN amount_usd / token_bought_amount
            WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND token_sold_amount > 0
            THEN amount_usd / token_sold_amount
            ELSE NULL
        END AS exec_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND block_date >= CURRENT_DATE - INTERVAL '90' day
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
)

SELECT
    day,
    -- Volume breakdown
    SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END) AS "Buy Volume (USD)",
    SUM(CASE WHEN side = 'sell' THEN amount_usd ELSE 0 END) AS "Sell Volume (USD)",
    SUM(amount_usd) AS "Total Volume (USD)",
    SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END)
      - SUM(CASE WHEN side = 'sell' THEN amount_usd ELSE 0 END) AS "Net Flow (USD)",
    -- Trader breakdown
    COUNT(DISTINCT CASE WHEN side = 'buy' THEN tx_from END) AS "Unique Buyers",
    COUNT(DISTINCT CASE WHEN side = 'sell' THEN tx_from END) AS "Unique Sellers",
    COUNT(DISTINCT tx_from) AS "Total Unique Traders",
    -- Buy ratio
    ROUND(
        100.0 * SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END)
        / NULLIF(SUM(amount_usd), 0),
        1
    ) AS "Buy Ratio %",
    -- Price
    ROUND(AVG(exec_price), 6) AS "Avg Price (USD)",
    ROUND(MIN(exec_price), 6) AS "Low Price (USD)",
    ROUND(MAX(exec_price), 6) AS "High Price (USD)",
    -- Trade count
    COUNT(*) AS "Total Trades",
    ROUND(AVG(amount_usd), 2) AS "Avg Trade Size (USD)",
    -- 7d MA
    AVG(SUM(amount_usd)) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "Volume 7d MA"
FROM trades
GROUP BY 1
ORDER BY 1
