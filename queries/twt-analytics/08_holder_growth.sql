-- TWT: Holder Growth (Net Change & Cumulative)
-- Purpose: Track net holder growth - new wallets acquiring vs wallets emptying
-- Visualization: Combined chart - bars (net change) + line (cumulative) on right Y
-- NOTE: This is computationally heavy. Use medium engine if timeout on small.

WITH transfers AS (
    SELECT
        block_date AS day,
        "to" AS address,
        amount AS inflow
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)

    UNION ALL

    SELECT
        block_date AS day,
        "from" AS address,
        -amount AS inflow
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)
),
daily_balances AS (
    SELECT
        day,
        address,
        SUM(inflow) AS net_change
    FROM transfers
    WHERE address != 0x0000000000000000000000000000000000000000
    GROUP BY 1, 2
),
running AS (
    SELECT
        day,
        address,
        SUM(net_change) OVER (PARTITION BY address ORDER BY day) AS running_balance,
        LAG(SUM(net_change) OVER (PARTITION BY address ORDER BY day)) OVER (PARTITION BY address ORDER BY day) AS prev_balance
    FROM daily_balances
),
classified AS (
    SELECT
        day,
        SUM(CASE WHEN running_balance > 0 AND (prev_balance IS NULL OR prev_balance <= 0) THEN 1 ELSE 0 END) AS new_holders,
        SUM(CASE WHEN running_balance <= 0 AND prev_balance > 0 THEN 1 ELSE 0 END) AS lost_holders
    FROM running
    GROUP BY 1
)
SELECT
    day,
    new_holders,
    lost_holders,
    new_holders - lost_holders AS net_new_holders,
    SUM(new_holders - lost_holders) OVER (ORDER BY day) AS cumulative_holders_estimate,
    AVG(CAST(new_holders - lost_holders AS DOUBLE)) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_net_holders
FROM classified
ORDER BY 1
