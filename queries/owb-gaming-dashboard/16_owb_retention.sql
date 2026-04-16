-- OWB Agentic Gaming Dashboard - Query 16: Community Growth & Retention
-- Tracks user retention cohorts based on first interaction date
-- Uses claim rewards event as primary engagement signal
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - Community Growth & Retention"

WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb),
        (0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203),
        (0x692d11c779d43BBC12Cb8565C7f71a54A47D117c),
        (0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b)
    ) AS t(address)
),

-- First interaction date per wallet
wallet_cohorts AS (
    SELECT
        t."from" AS wallet,
        date_trunc('week', MIN(t.block_time)) AS cohort_week,
        MIN(t.block_time) AS first_interaction
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= DATE '2026-03-25'
      AND t.success = true
    GROUP BY 1
),

-- Weekly activity per wallet
wallet_weekly_activity AS (
    SELECT
        t."from" AS wallet,
        date_trunc('week', t.block_time) AS activity_week,
        COUNT(*) AS weekly_txs
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= DATE '2026-03-25'
      AND t.success = true
    GROUP BY 1, 2
),

-- Retention: cohort x week-number
retention AS (
    SELECT
        wc.cohort_week,
        COUNT(DISTINCT wc.wallet) AS cohort_size,
        COUNT(DISTINCT CASE WHEN wa.activity_week = wc.cohort_week THEN wa.wallet END) AS week_0,
        COUNT(DISTINCT CASE WHEN wa.activity_week = wc.cohort_week + interval '7' day THEN wa.wallet END) AS week_1,
        COUNT(DISTINCT CASE WHEN wa.activity_week = wc.cohort_week + interval '14' day THEN wa.wallet END) AS week_2,
        COUNT(DISTINCT CASE WHEN wa.activity_week = wc.cohort_week + interval '21' day THEN wa.wallet END) AS week_3
    FROM wallet_cohorts wc
    LEFT JOIN wallet_weekly_activity wa ON wc.wallet = wa.wallet
    GROUP BY 1
),

-- Daily new users and cumulative
daily_new_users AS (
    SELECT
        CAST(first_interaction AS DATE) AS day,
        COUNT(DISTINCT wallet) AS new_users
    FROM wallet_cohorts
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-03-25', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(dnu.new_users, 0) AS "New Users",
    SUM(COALESCE(dnu.new_users, 0)) OVER (ORDER BY ds.day) AS "Cumulative Users",
    ROUND(AVG(COALESCE(dnu.new_users, 0)) OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "New Users 7d MA",
    -- Returning users (active today but first seen before today)
    (
        SELECT COUNT(DISTINCT wa.wallet)
        FROM wallet_weekly_activity wa
        JOIN wallet_cohorts wc ON wa.wallet = wc.wallet
        WHERE CAST(wa.activity_week AS DATE) = ds.day
          AND CAST(wc.first_interaction AS DATE) < ds.day
    ) AS "Returning Users"
FROM date_spine ds
LEFT JOIN daily_new_users dnu ON ds.day = dnu.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
