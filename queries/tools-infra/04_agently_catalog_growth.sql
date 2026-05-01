-- Section 5: Agently Catalog — Agent Onboarding & Ecosystem Composition
-- Offchain data from https://use-agently.com/ (Hempanda research, query #7401373)
-- Shows daily agent registrations, cumulative growth, chain & protocol distribution
--
-- Save as: "Agently Catalog - Agent Growth & Composition (V1)"
-- Description: The agent registry in motion — daily onboarding velocity,
--   cumulative growth, and ecosystem composition by chain and protocol

WITH daily AS (
    SELECT * FROM (
        VALUES
            (DATE '2026-04-23', 2),
            (DATE '2026-04-22', 6),
            (DATE '2026-04-21', 1),
            (DATE '2026-04-20', 2),
            (DATE '2026-04-19', 1),
            (DATE '2026-04-17', 1),
            (DATE '2026-04-16', 2),
            (DATE '2026-04-13', 1),
            (DATE '2026-04-12', 2),
            (DATE '2026-04-11', 16),
            (DATE '2026-04-10', 5),
            (DATE '2026-04-09', 7),
            (DATE '2026-04-08', 6),
            (DATE '2026-04-07', 2),
            (DATE '2026-04-06', 5),
            (DATE '2026-04-05', 2),
            (DATE '2026-04-04', 6),
            (DATE '2026-04-03', 3),
            (DATE '2026-04-02', 1),
            (DATE '2026-04-01', 7),
            (DATE '2026-03-31', 18),
            (DATE '2026-03-30', 1),
            (DATE '2026-03-29', 1),
            (DATE '2026-03-28', 5),
            (DATE '2026-03-27', 11),
            (DATE '2026-03-26', 8),
            (DATE '2026-03-25', 11),
            (DATE '2026-03-24', 46),
            (DATE '2026-03-23', 75),
            (DATE '2026-03-22', 110),
            (DATE '2026-03-21', 35),
            (DATE '2026-03-20', 9),
            (DATE '2026-03-19', 4),
            (DATE '2026-03-18', 51),
            (DATE '2026-03-17', 11),
            (DATE '2026-03-16', 15),
            (DATE '2026-03-15', 14),
            (DATE '2026-03-14', 5),
            (DATE '2026-03-13', 22),
            (DATE '2026-03-12', 3),
            (DATE '2026-03-11', 20),
            (DATE '2026-03-10', 11),
            (DATE '2026-03-09', 5),
            (DATE '2026-03-08', 77),
            (DATE '2026-03-07', 102),
            (DATE '2026-03-06', 123),
            (DATE '2026-03-05', 32),
            (DATE '2026-03-04', 9),
            (DATE '2026-03-03', 273),
            (DATE '2026-03-02', 12),
            (DATE '2026-03-01', 101),
            (DATE '2026-02-28', 9),
            (DATE '2026-02-27', 8),
            (DATE '2026-02-26', 154),
            (DATE '2026-02-25', 116),
            (DATE '2026-02-24', 45),
            (DATE '2026-02-23', 4),
            (DATE '2026-02-22', 11),
            (DATE '2026-02-21', 13),
            (DATE '2026-02-20', 10),
            (DATE '2026-02-19', 27),
            (DATE '2026-02-18', 9),
            (DATE '2026-02-17', 5),
            (DATE '2026-02-16', 3),
            (DATE '2026-02-15', 4),
            (DATE '2026-02-14', 10),
            (DATE '2026-02-13', 7),
            (DATE '2026-02-12', 4),
            (DATE '2026-02-11', 11),
            (DATE '2026-02-10', 30),
            (DATE '2026-02-09', 45),
            (DATE '2026-02-08', 33),
            (DATE '2026-02-07', 10),
            (DATE '2026-02-06', 8),
            (DATE '2026-02-05', 13),
            (DATE '2026-02-04', 9),
            (DATE '2026-02-03', 17),
            (DATE '2026-02-02', 24),
            (DATE '2026-02-01', 23),
            (DATE '2026-01-31', 7),
            (DATE '2026-01-30', 13),
            (DATE '2026-01-29', 8)
    ) AS t(day, agents_added)
)

SELECT
    day,
    agents_added AS "New Agents",
    SUM(agents_added) OVER (ORDER BY day) AS "Cumulative Agents",
    ROUND(AVG(agents_added) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "7d MA",

    -- chain constants (latest snapshot)
    1583 AS "Base Agents",
    275 AS "BNB Agents",
    128 AS "Ethereum Agents",
    7 AS "Arbitrum Agents",
    4 AS "Polygon Agents",
    3 AS "Optimism Agents",

    -- protocol constants (latest snapshot)
    1496 AS "MCP Agents",
    1117 AS "A2A Agents",
    513 AS "Web Agents",
    369 AS "OASF Agents",
    2 AS "Email Agents"

FROM daily
ORDER BY day ASC
