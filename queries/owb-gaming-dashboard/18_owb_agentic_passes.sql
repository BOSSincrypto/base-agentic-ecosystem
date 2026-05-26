-- OWB Agentic Gaming Dashboard - Query 18: Agentic Passes & Claims Deep Dive
-- Tracks activity on both Agentic Claim contracts separately
-- Agentic Claim 1: 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
-- Agentic Claim 2: 0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - Agentic Passes & Claims"

WITH agentic1_daily AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS claim1_txs,
        COUNT(DISTINCT t."from") AS claim1_users
    FROM base.transactions t
    WHERE t."to" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
      AND t.block_time >= DATE '2026-03-25'
      AND t.success = true
    GROUP BY 1
),

agentic2_daily AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS claim2_txs,
        COUNT(DISTINCT t."from") AS claim2_users
    FROM base.transactions t
    WHERE t."to" = 0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
      AND t.block_time >= DATE '2026-03-25'
      AND t.success = true
    GROUP BY 1
),

-- Unique agentic claim wallets (ever interacted with either contract)
agentic_wallets AS (
    SELECT
        t."from" AS wallet,
        MIN(t.block_time) AS first_claim,
        COUNT(*) AS total_claims,
        COUNT(CASE WHEN t."to" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb THEN 1 END) AS claims_v1,
        COUNT(CASE WHEN t."to" = 0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203 THEN 1 END) AS claims_v2
    FROM base.transactions t
    WHERE t."to" IN (
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb,
        0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
    )
    AND t.block_time >= DATE '2026-03-25'
    AND t.success = true
    GROUP BY 1
),

-- New agentic claimants per day
daily_new_claimants AS (
    SELECT
        CAST(first_claim AS DATE) AS day,
        COUNT(DISTINCT wallet) AS new_claimants
    FROM agentic_wallets
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-03-25', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(a1.claim1_txs, 0) AS "Agentic Claim 1 Txs",
    COALESCE(a2.claim2_txs, 0) AS "Agentic Claim 2 Txs",
    COALESCE(a1.claim1_txs, 0) + COALESCE(a2.claim2_txs, 0) AS "Total Agentic Claims",
    COALESCE(a1.claim1_users, 0) AS "Claim 1 Users",
    COALESCE(a2.claim2_users, 0) AS "Claim 2 Users",
    COALESCE(dnc.new_claimants, 0) AS "New Agentic Claimants",
    SUM(COALESCE(dnc.new_claimants, 0)) OVER (ORDER BY ds.day) AS "Cumulative Agentic Claimants",
    ROUND(AVG(CAST(COALESCE(a1.claim1_txs, 0) + COALESCE(a2.claim2_txs, 0) AS DOUBLE))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Agentic Claims 7d MA"
FROM date_spine ds
LEFT JOIN agentic1_daily a1 ON ds.day = a1.day
LEFT JOIN agentic2_daily a2 ON ds.day = a2.day
LEFT JOIN daily_new_claimants dnc ON ds.day = dnc.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
