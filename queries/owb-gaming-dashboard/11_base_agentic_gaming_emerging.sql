-- OWB Agentic Gaming Dashboard - Query 11: Base Agentic Gaming - Emerging Projects
-- Section 3: Tracks emerging agentic gaming projects on Base
-- Max 2 queries for this section (this is query 1 of 2)
-- Projects: Agent Arena, Last AI Standing, DX Terminal Pro, SpaceMolt-adjacent
-- Save as: "Base Agentic Gaming - Emerging Projects Tracker"

WITH gaming_contracts AS (
    SELECT address, name, category FROM (
        VALUES
        -- Agentic Gaming Infrastructure
        (0x88beBFeA498619D4eA891E707c47C43E2D43E62d, 'Last AI Standing', 'Survival Game'),
        -- OWB Ecosystem (for comparison)
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token', 'GameFi Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'CoC Rewards Claim', 'GameFi Rewards'),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'OWB Staking', 'GameFi Staking')
    ) AS t(address, name, category)
),

-- Aggregate activity per project
project_metrics AS (
    SELECT
        gc.name AS project,
        gc.category,
        COUNT(*) AS total_txs,
        COUNT(DISTINCT t."from") AS unique_users,
        MIN(t.block_time) AS first_activity,
        MAX(t.block_time) AS last_activity,
        COUNT(CASE WHEN t.block_time >= now() - interval '7' day THEN 1 END) AS txs_7d,
        COUNT(CASE WHEN t.block_time >= now() - interval '30' day THEN 1 END) AS txs_30d,
        COUNT(DISTINCT CASE WHEN t.block_time >= now() - interval '30' day THEN t."from" END) AS users_30d,
        COUNT(DISTINCT CASE WHEN t.block_time >= now() - interval '7' day THEN t."from" END) AS users_7d
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.success = true
    GROUP BY 1, 2
),

-- WoW growth for each project
wow AS (
    SELECT
        gc.name AS project,
        COUNT(CASE WHEN t.block_time >= now() - interval '7' day THEN 1 END) AS txs_current_week,
        COUNT(CASE WHEN t.block_time >= now() - interval '14' day
                    AND t.block_time < now() - interval '7' day THEN 1 END) AS txs_prev_week
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.success = true
      AND t.block_time >= now() - interval '14' day
    GROUP BY 1
)

SELECT
    pm.project AS "Project",
    pm.category AS "Category",
    pm.total_txs AS "Total Txs (All Time)",
    pm.unique_users AS "Unique Users (All Time)",
    pm.txs_30d AS "Txs (30d)",
    pm.users_30d AS "Users (30d)",
    pm.txs_7d AS "Txs (7d)",
    pm.users_7d AS "Users (7d)",
    CASE
        WHEN w.txs_prev_week > 0
        THEN ROUND(100.0 * (w.txs_current_week - w.txs_prev_week) / w.txs_prev_week, 1)
        ELSE NULL
    END AS "WoW Growth %",
    CAST(pm.first_activity AS DATE) AS "First Seen",
    CAST(pm.last_activity AS DATE) AS "Last Active",
    -- Activity Score (simplified: 55% txs + 45% users, normalized)
    ROUND(
        55.0 * pm.txs_30d / NULLIF(MAX(pm.txs_30d) OVER (), 0)
        + 45.0 * pm.users_30d / NULLIF(MAX(pm.users_30d) OVER (), 0),
        1
    ) AS "Activity Score"
FROM project_metrics pm
LEFT JOIN wow w ON pm.project = w.project
ORDER BY "Activity Score" DESC
