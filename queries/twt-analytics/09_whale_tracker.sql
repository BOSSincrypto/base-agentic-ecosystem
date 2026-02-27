-- TWT: Whale Tracker (Large Transfers)
-- Purpose: Monitor large TWT movements (>$50K) for whale activity signals
-- Visualization: Table widget - sortable, tx_hash linked to BSCScan

SELECT
    block_time,
    "from" AS sender,
    "to" AS receiver,
    amount AS twt_amount,
    amount_usd,
    CASE
        WHEN amount_usd >= 500000 THEN 'MEGA'
        WHEN amount_usd >= 100000 THEN 'WHALE'
        ELSE 'LARGE'
    END AS category,
    tx_hash
FROM tokens.transfers
WHERE blockchain = 'bnb'
  AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
  AND block_date >= CURRENT_DATE - INTERVAL '30' day
  AND amount_usd >= 50000
ORDER BY amount_usd DESC
LIMIT 100
