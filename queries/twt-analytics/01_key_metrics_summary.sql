-- TWT: Key Metrics Summary
-- Purpose: Top-level KPI counters - Price, 24h Volume, Market Cap, Active Addresses, 24h Txs
-- Visualization: 5 Counter widgets (one per column)

WITH latest_price AS (
    SELECT
        price AS current_price
    FROM prices.usd_latest
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
),
volume_24h AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS volume_24h
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_time >= NOW() - INTERVAL '24' hour
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
),
holders_dedup AS (
    SELECT COUNT(DISTINCT addr) AS holders_approx
    FROM (
        SELECT "from" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND block_date >= CURRENT_DATE - INTERVAL '30' day
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
        UNION
        SELECT "to" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND block_date >= CURRENT_DATE - INTERVAL '30' day
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
    ) u
),
txs_24h AS (
    SELECT COUNT(*) AS txs_24h
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND block_date >= CURRENT_DATE - INTERVAL '1' day
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
)
SELECT
    lp.current_price,
    v.volume_24h,
    lp.current_price * 1e9 AS market_cap_approx,
    h.holders_approx,
    t.txs_24h
FROM latest_price lp
CROSS JOIN volume_24h v
CROSS JOIN holders_dedup h
CROSS JOIN txs_24h t
