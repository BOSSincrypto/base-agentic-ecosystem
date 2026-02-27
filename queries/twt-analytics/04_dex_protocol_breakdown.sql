-- TWT: DEX Protocol Breakdown
-- Purpose: Which DEXes handle TWT volume - liquidity fragmentation analysis
-- Visualization: Pie chart (volume by DEX) + sortable table

SELECT
    project,
    COUNT(*) AS trades_count,
    COUNT(DISTINCT tx_from) AS unique_traders,
    SUM(amount_usd) AS total_volume_usd,
    SUM(amount_usd) / COUNT(DISTINCT DATE_TRUNC('day', block_time)) AS avg_daily_volume,
    AVG(amount_usd) AS avg_trade_size_usd,
    MIN(block_time) AS first_trade,
    MAX(block_time) AS last_trade
FROM dex.trades
WHERE blockchain = 'bnb'
  AND block_date >= CURRENT_DATE - INTERVAL '30' day
  AND (
      token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
  )
  AND amount_usd > 0
GROUP BY 1
ORDER BY total_volume_usd DESC
