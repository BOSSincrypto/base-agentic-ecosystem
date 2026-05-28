-- Section 8 COMBINED: Card Type Composition — Overall + Per Project
-- ONE scan replaces TWO queries (8.1 + 8.2). Shared CTEs, single pass.
-- Outputs both project-level detail (for 8.2 stacked bar) and overall totals (for 8.1 donut).
-- Date: 2026-01-01+
--
-- Output columns serve two visualizations:
--   8.1 donut:  filter WHERE project = 'ALL' → category, total_cards
--   8.2 bar:    filter WHERE project != 'ALL' → project, category, cards_count, pct_of_project
--
-- Save as: "Card Type Mix — 8.1+8.2 Composition"

WITH courtyard_cat AS (
    SELECT
        COALESCE(
            CAST(JSON_EXTRACT_SCALAR(metadata, '$.category') AS VARCHAR),
            'Unknown'
        ) AS category,
        COUNT(*) AS cards_count,
        'Courtyard' AS project
    FROM nft.mints
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251be3a17af4892035c37ebf5890f4a4d889dcad
      AND block_date >= DATE '2026-01-01'
    GROUP BY 1
),

-- Phygitals: stub — metadata source TBD (open item #4)
-- phygitals_cat AS (
--     SELECT category, COUNT(*) AS cards_count, 'Phygitals' AS project
--     FROM <phygitals_mint_metadata_source>
--     WHERE block_date >= DATE '2026-01-01'
--     GROUP BY 1
-- ),

cc_cat AS (
    SELECT
        CASE
            WHEN from_owner IN (
                'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
                'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'
            ) THEN 'Sport'
            ELSE 'Pokemon'
        END AS category,
        COUNT(*) AS cards_count,
        'Collector Crypt' AS project
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND from_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
    GROUP BY 1
),

all_cat AS (
    SELECT project, category, cards_count FROM courtyard_cat
    UNION ALL
    -- SELECT project, category, cards_count FROM phygitals_cat
    SELECT project, category, cards_count FROM cc_cat
),

project_totals AS (
    SELECT project, SUM(cards_count) AS total FROM all_cat GROUP BY 1
),

grand_total AS (
    SELECT SUM(cards_count) AS total FROM all_cat
),

-- 8.2: Per-project rows with percentage
per_project AS (
    SELECT
        a.project,
        a.category,
        SUM(a.cards_count) AS cards_count,
        ROUND(SUM(a.cards_count) * 100.0 / NULLIF(pt.total, 0), 2) AS pct_of_project
    FROM all_cat a
    JOIN project_totals pt ON a.project = pt.project
    GROUP BY a.project, a.category, pt.total
),

-- 8.1: Overall rows (project = 'ALL')
overall AS (
    SELECT
        'ALL' AS project,
        category,
        SUM(cards_count) AS cards_count,
        ROUND(SUM(cards_count) * 100.0 / NULLIF((SELECT total FROM grand_total), 0), 2) AS pct_of_project
    FROM all_cat
    GROUP BY category
)

SELECT * FROM per_project
UNION ALL
SELECT * FROM overall
ORDER BY project, cards_count DESC
