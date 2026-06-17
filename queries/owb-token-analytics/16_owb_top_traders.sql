-- =====================================================================
-- OWB Token Analytics - Query 16: Top 50 Traders (30d)
-- Top 50 by 30d volume: trade count, avg size, buy/sell split,
-- net position, classification
-- =====================================================================

WITH trader_stats AS (
    SELECT
        tx_from AS trader,
        COUNT(*) AS trade_count,
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
        MIN(block_time) AS first_trade,
        MAX(block_time) AS last_trade,
        COUNT(DISTINCT date_trunc('day', block_time)) AS active_days
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= now() - interval '30' day
    GROUP BY 1
)

SELECT
    ROW_NUMBER() OVER (ORDER BY total_volume DESC) AS "Rank",
    trader AS "Trader",
    trade_count AS "Trades",
    ROUND(total_volume, 2) AS "Volume (USD)",
    ROUND(avg_trade_size, 2) AS "Avg Trade Size",
    ROUND(buy_volume, 2) AS "Buy Volume",
    ROUND(sell_volume, 2) AS "Sell Volume",
    ROUND(buy_volume - sell_volume, 2) AS "Net Position",
    CASE
        WHEN buy_volume > sell_volume * 1.5 THEN 'Net Buyer'
        WHEN sell_volume > buy_volume * 1.5 THEN 'Net Seller'
        ELSE 'Balanced'
    END AS "Position",
    active_days AS "Active Days",
    CASE
        WHEN trade_count > 100 AND active_days > 20 THEN 'Market Maker'
        WHEN total_volume > 50000 THEN 'Whale'
        WHEN active_days > 10 THEN 'Regular'
        ELSE 'Casual'
    END AS "Classification"
FROM trader_stats
ORDER BY total_volume DESC
LIMIT 50
