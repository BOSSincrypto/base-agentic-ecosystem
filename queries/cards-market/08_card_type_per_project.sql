-- Section 8.2: Card Type Composition — Category Mix per Project (Stacked Bar)
-- 100%-normalized horizontal stacked bar showing IP theme distribution.
-- Same project CTEs as 8.1. Beezie and Upshot excluded.
-- Date: 2026-01-01+
--
-- Visualization: Horizontal stacked bar, 100%-normalized
--   Y: project (sorted by total desc) | X: pct_of_project
--   Series: category | Same palette as 8.1
--
-- Save as: "Card Type Mix — 8.2 per Project"

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

-- Phygitals: stub — enable when metadata source available
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
    SELECT category, cards_count, project FROM courtyard_cat
    UNION ALL
    -- SELECT category, cards_count, project FROM phygitals_cat
    SELECT category, cards_count, project FROM cc_cat
),

tot AS (
    SELECT project, SUM(cards_count) AS total
    FROM all_cat
    GROUP BY 1
)

SELECT
    a.project,
    a.category,
    SUM(a.cards_count) AS cards_count,
    ROUND(SUM(a.cards_count) * 100.0 / NULLIF(t.total, 0), 2) AS pct_of_project
FROM all_cat a
JOIN tot t ON a.project = t.project
GROUP BY a.project, a.category, t.total
ORDER BY a.project, cards_count DESC
