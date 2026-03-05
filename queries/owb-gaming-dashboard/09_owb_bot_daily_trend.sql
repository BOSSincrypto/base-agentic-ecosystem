-- OWB Agentic Gaming Dashboard - Query 9: Bot Activity Daily Trend
-- Tracks bot vs human claim activity over time
-- Additional indicator for "Number of Bots" metric
-- Save as: "OWB Gaming - Bot Daily Trend"

WITH claim_wallets AS (
    SELECT
        t."from" AS wallet,
        COUNT(*) AS total_claims,
        CASE
            WHEN COUNT(*) > 1
            THEN CAST(
                date_diff('second', MIN(t.block_time), MAX(t.block_time))
                AS DOUBLE
            ) / (COUNT(*) - 1)
            ELSE NULL
        END AS avg_interval_sec
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1
),

wallet_types AS (
    SELECT
        wallet,
        CASE
            WHEN total_claims >= 50 AND avg_interval_sec < 900 THEN 'Bot'
            WHEN total_claims >= 20 AND avg_interval_sec < 3600 THEN 'Semi-Auto'
            ELSE 'Human'
        END AS wallet_type
    FROM claim_wallets
),

daily_claims AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        wt.wallet_type,
        COUNT(*) AS claims,
        COUNT(DISTINCT t."from") AS unique_wallets
    FROM base.transactions t
    JOIN wallet_types wt ON t."from" = wt.wallet
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1, 2
)

SELECT
    day,
    wallet_type AS "Wallet Type",
    claims AS "Claims",
    unique_wallets AS "Active Wallets",
    SUM(claims) OVER (PARTITION BY wallet_type ORDER BY day) AS "Cumulative Claims"
FROM daily_claims
WHERE day < current_date
ORDER BY day ASC, wallet_type
