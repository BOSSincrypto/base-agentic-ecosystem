-- OWB Agentic Gaming Dashboard - Query 9: DTU Activity Daily Trend
-- Tracks automated vs manual claim activity over time
-- DTU = Daily Transacting Users (preferred over "bot" terminology)
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - DTU Daily Trend"

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
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb,
        0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
    )
    AND t.block_time >= DATE '2026-03-25'
    AND t.success = true
    GROUP BY 1
),

wallet_types AS (
    SELECT
        wallet,
        CASE
            WHEN total_claims >= 50 AND avg_interval_sec IS NOT NULL AND avg_interval_sec < 900 THEN 'Automated'
            WHEN total_claims >= 20 AND avg_interval_sec IS NOT NULL AND avg_interval_sec < 3600 THEN 'Semi-Auto'
            ELSE 'Manual'
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
    WHERE t."to" IN (
        0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40,
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb,
        0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
    )
    AND t.block_time >= DATE '2026-03-25'
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
