-- TWT: Token Transfer Analysis (All Transfers)
-- Purpose: Full picture of TWT movements including CEX, OTC, staking, P2P
-- Visualization: Combined chart - bars (volume) + line (count) + dashed (7d MA)

WITH daily AS (
    SELECT
        block_date AS day,
        COUNT(*) AS transfer_count,
        SUM(amount_usd) AS transfer_volume_usd,
        COUNT(DISTINCT "from") AS unique_senders,
        COUNT(DISTINCT "to") AS unique_receivers,
        SUM(CASE WHEN amount_usd >= 50000 THEN amount_usd ELSE 0 END) AS whale_volume_usd,
        COUNT(CASE WHEN amount_usd >= 50000 THEN 1 END) AS whale_txs
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)
    GROUP BY 1
)
SELECT
    day,
    transfer_count,
    transfer_volume_usd,
    unique_senders,
    unique_receivers,
    whale_volume_usd,
    whale_txs,
    ROUND(100.0 * whale_volume_usd / NULLIF(transfer_volume_usd, 0), 1) AS whale_pct,
    AVG(transfer_volume_usd) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_volume,
    AVG(transfer_count) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_count
FROM daily
ORDER BY 1
