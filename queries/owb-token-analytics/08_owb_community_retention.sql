-- =====================================================================
-- OWB Token Analytics - Query 8: Community & Retention
-- DAU proxy via Claim Rewards contract
-- New vs returning players, 7d retention, cohort analysis
-- Claim Rewards: 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
-- Start: March 25, 2026 (agentic presale)
-- =====================================================================

WITH daily_claimers AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        t."from" AS wallet
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.block_time >= DATE '2026-03-25'
      AND t.success = true
),

-- First seen date per wallet
first_seen AS (
    SELECT
        wallet,
        MIN(day) AS first_day
    FROM daily_claimers
    GROUP BY 1
),

-- Daily metrics with new/returning split
daily_metrics AS (
    SELECT
        dc.day,
        COUNT(DISTINCT dc.wallet) AS dtu,
        COUNT(DISTINCT CASE WHEN fs.first_day = dc.day THEN dc.wallet END) AS new_players,
        COUNT(DISTINCT CASE WHEN fs.first_day < dc.day THEN dc.wallet END) AS returning_players
    FROM daily_claimers dc
    INNER JOIN first_seen fs ON dc.wallet = fs.wallet
    GROUP BY 1
),

-- Cumulative unique players
cumulative_players AS (
    SELECT
        first_day AS day,
        COUNT(*) AS new_unique_players
    FROM first_seen
    GROUP BY 1
),

-- 7d retention: of users who first appeared on day X, how many returned within 7 days?
retention_7d AS (
    SELECT
        fs.first_day AS cohort_day,
        COUNT(DISTINCT fs.wallet) AS cohort_size,
        COUNT(DISTINCT CASE
            WHEN dc.day > fs.first_day
             AND dc.day <= fs.first_day + interval '7' day
            THEN fs.wallet
        END) AS retained_7d
    FROM first_seen fs
    LEFT JOIN daily_claimers dc ON fs.wallet = dc.wallet
    WHERE fs.first_day <= current_date - interval '7' day
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-03-25', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(dm.dtu, 0) AS "DTU (Daily Transacting Users)",
    COALESCE(dm.new_players, 0) AS "New Players",
    COALESCE(dm.returning_players, 0) AS "Returning Players",
    -- Returning ratio
    CASE
        WHEN COALESCE(dm.dtu, 0) > 0
        THEN ROUND(100.0 * COALESCE(dm.returning_players, 0) / dm.dtu, 1)
        ELSE 0
    END AS "Returning Player %",
    -- Cumulative unique
    SUM(COALESCE(cp.new_unique_players, 0)) OVER (ORDER BY ds.day) AS "Cumulative Unique Players",
    -- 7d retention for this cohort day
    COALESCE(r7.cohort_size, 0) AS "Cohort Size",
    COALESCE(r7.retained_7d, 0) AS "Retained (7d)",
    CASE
        WHEN COALESCE(r7.cohort_size, 0) > 0
        THEN ROUND(100.0 * r7.retained_7d / r7.cohort_size, 1)
        ELSE NULL
    END AS "7d Retention %",
    -- 7d MA of DTU
    ROUND(AVG(COALESCE(dm.dtu, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "DTU 7d MA",
    -- 7d MA of new players
    ROUND(AVG(COALESCE(dm.new_players, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "New Players 7d MA"
FROM date_spine ds
LEFT JOIN daily_metrics dm ON ds.day = dm.day
LEFT JOIN cumulative_players cp ON ds.day = cp.day
LEFT JOIN retention_7d r7 ON ds.day = r7.cohort_day
WHERE ds.day < current_date
ORDER BY ds.day ASC
