-- OWB Agentic Gaming Dashboard - Query 8: DTU & Automated Activity Metrics
-- Identifies automated patterns in OWB ecosystem (high-frequency claimers, automated stakers)
-- DTU = Daily Transacting Users (preferred over "bot" terminology)
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - DTU Metrics"

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
    WHERE t."to" IN (
        0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40,
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb,
        0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
    )
    AND t.block_time >= DATE '2026-03-25'
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
            WHEN total_claims >= 50
                 AND avg_seconds_between_claims IS NOT NULL
                 AND avg_seconds_between_claims < 900
            THEN 'High-Frequency Automated'
            WHEN total_claims >= 20
                 AND avg_seconds_between_claims IS NOT NULL
                 AND avg_seconds_between_claims < 3600
            THEN 'Semi-Automated'
            WHEN total_claims >= 10
            THEN 'Active Player'
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
