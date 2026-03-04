-- OWB Agentic Gaming Dashboard - Query 14: Bot Activity Hourly Heatmap
-- Shows when bots vs humans are most active (hour of day × day of week)
-- Additional indicator #3 for "Number of Bots" metric
-- Save as: "OWB Gaming - Activity Heatmap"

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
    WHERE t."to" IN (
        0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40,
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
    )
    AND t.block_time >= DATE '2025-06-01'
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

hourly_activity AS (
    SELECT
        HOUR(t.block_time) AS hour_utc,
        day_of_week(t.block_time) AS dow,
        wt.wallet_type,
        COUNT(*) AS txs
    FROM base.transactions t
    JOIN wallet_types wt ON t."from" = wt.wallet
    WHERE t."to" IN (
        0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40,
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
    )
    AND t.block_time >= now() - interval '30' day
    AND t.success = true
    GROUP BY 1, 2, 3
)

SELECT
    CASE dow
        WHEN 1 THEN 'Mon'
        WHEN 2 THEN 'Tue'
        WHEN 3 THEN 'Wed'
        WHEN 4 THEN 'Thu'
        WHEN 5 THEN 'Fri'
        WHEN 6 THEN 'Sat'
        WHEN 7 THEN 'Sun'
    END AS "Day",
    dow AS day_order,
    hour_utc AS "Hour (UTC)",
    wallet_type AS "Wallet Type",
    txs AS "Transactions",
    -- Bot share of activity at this hour/day
    ROUND(
        100.0 * SUM(CASE WHEN wallet_type = 'Bot' THEN txs ELSE 0 END)
        OVER (PARTITION BY dow, hour_utc)
        / NULLIF(SUM(txs) OVER (PARTITION BY dow, hour_utc), 0),
        1
    ) AS "Bot Share %"
FROM hourly_activity
ORDER BY dow, hour_utc, wallet_type
