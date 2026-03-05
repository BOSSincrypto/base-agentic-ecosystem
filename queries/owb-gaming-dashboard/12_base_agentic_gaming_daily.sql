-- OWB Agentic Gaming Dashboard - Query 12: Base Agentic Gaming - Daily Activity
-- Section 3, Query 2 of 2: Daily transaction trends across gaming contracts
-- Save as: "Base Agentic Gaming - Daily Activity Trends"

WITH gaming_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0x88beBFeA498619D4eA891E707c47C43E2D43E62d, 'Last AI Standing'),
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'CoC Rewards'),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'OWB Staking')
    ) AS t(address, name)
),

daily_raw AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        gc.name AS project,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT t."from") AS daily_users
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1, 2
),

-- Total daily across all gaming
daily_total AS (
    SELECT
        day,
        SUM(daily_txs) AS total_gaming_txs,
        SUM(daily_users) AS total_gaming_users
    FROM daily_raw
    GROUP BY 1
)

SELECT
    dt.day,
    dt.total_gaming_txs AS "Total Gaming Txs",
    dt.total_gaming_users AS "Total Gaming Users",
    AVG(dt.total_gaming_txs) OVER (ORDER BY dt.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "Gaming Txs 7d MA",
    AVG(dt.total_gaming_users) OVER (ORDER BY dt.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "Gaming Users 7d MA",
    SUM(dt.total_gaming_txs) OVER (ORDER BY dt.day) AS "Cumulative Gaming Txs",
    -- Per-project breakdown
    COALESCE(MAX(CASE WHEN dr.project = 'OWB Token' THEN dr.daily_txs END), 0) AS "OWB Token Txs",
    COALESCE(MAX(CASE WHEN dr.project = 'CoC Rewards' THEN dr.daily_txs END), 0) AS "CoC Rewards Txs",
    COALESCE(MAX(CASE WHEN dr.project = 'OWB Staking' THEN dr.daily_txs END), 0) AS "OWB Staking Txs",
    COALESCE(MAX(CASE WHEN dr.project = 'Last AI Standing' THEN dr.daily_txs END), 0) AS "Last AI Standing Txs"
FROM daily_total dt
LEFT JOIN daily_raw dr ON dt.day = dr.day
WHERE dt.day < current_date
GROUP BY 1, 2, 3
ORDER BY 1 ASC
