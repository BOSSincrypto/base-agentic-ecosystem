-- OWB Agentic Gaming Dashboard - Query 8: Bot & Automated Activity Metrics
-- Identifies bot-like patterns in OWB ecosystem (high-frequency claimers, automated stakers)
-- Key metric for "Number of Bots" in Section 4
-- Save as: "OWB Gaming - Bot Metrics"

WITH claim_activity AS (
    SELECT
        t."from" AS wallet,
        COUNT(*) AS total_claims,
        COUNT(DISTINCT date_trunc('day', t.block_time)) AS active_days,
        MIN(t.block_time) AS first_claim,
        MAX(t.block_time) AS last_claim,
        -- Average time between claims (seconds)
        CASE
            WHEN COUNT(*) > 1
            THEN ROUND(
                CAST(
                    date_diff('second', MIN(t.block_time), MAX(t.block_time))
                    AS DOUBLE
                ) / (COUNT(*) - 1),
                0
            )
            ELSE NULL
        END AS avg_seconds_between_claims
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.block_time >= DATE '2025-06-01'
      AND t.success = true
    GROUP BY 1
),

-- Classify wallets by behavior pattern
classified AS (
    SELECT
        wallet,
        total_claims,
        active_days,
        avg_seconds_between_claims,
        first_claim,
        last_claim,
        CASE
            -- Bot pattern: claims every ~10 min (600s) with very regular intervals
            WHEN total_claims >= 50
                 AND avg_seconds_between_claims IS NOT NULL
                 AND avg_seconds_between_claims < 900  -- less than 15 min avg
            THEN 'High-Frequency Bot'
            -- Semi-automated: regular but less frequent
            WHEN total_claims >= 20
                 AND avg_seconds_between_claims IS NOT NULL
                 AND avg_seconds_between_claims < 3600  -- less than 1 hour avg
            THEN 'Semi-Automated'
            -- Active human: many claims but irregular
            WHEN total_claims >= 10
            THEN 'Active Player'
            -- Casual: few claims
            WHEN total_claims >= 3
            THEN 'Casual Player'
            ELSE 'One-Time User'
        END AS behavior_type
    FROM claim_activity
),

-- Summary metrics
summary AS (
    SELECT
        behavior_type AS "Behavior Type",
        COUNT(*) AS "Wallet Count",
        SUM(total_claims) AS "Total Claims",
        ROUND(AVG(total_claims), 1) AS "Avg Claims/Wallet",
        ROUND(AVG(active_days), 1) AS "Avg Active Days",
        ROUND(100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM classified), 0), 1) AS "% of All Wallets",
        ROUND(100.0 * SUM(total_claims) / NULLIF((SELECT SUM(total_claims) FROM classified), 0), 1) AS "% of All Claims"
    FROM classified
    GROUP BY 1
)

SELECT * FROM summary
ORDER BY "Total Claims" DESC
