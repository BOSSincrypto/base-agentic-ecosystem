-- Section 8.1: Card Type Composition — Overall Market by Category (Pie)
-- Thematic projects only: Courtyard (Polygon), Collector Crypt (Solana).
-- Beezie excluded (tier axis, not theme). Upshot excluded (prediction market).
-- Phygitals: stub CTE — metadata source TBD (open item #4).
-- Date: 2026-01-01+
--
-- Visualization: Donut chart
--   Series: category | Values: total_cards
--   Palette: Pokemon #FFCB05, Sport #1E40AF, Marvel/Disney #DC2626,
--            One Piece #F97316, TCG other #7C3AED, Figurine #14B8A6,
--            Unknown #6B7280 (muted, shown not hidden)
--
-- Save as: "Card Type Mix — 8.1 Overall by Category"

WITH courtyard_cat AS (
    -- Polygon mints on NFT contract 0x251be3a17af4892035c37ebf5890f4a4d889dcad
    -- Category from collection/trait metadata via nft tables.
    -- TODO @remmez: map collection name to {Pokemon, Sport, Marvel/Disney, One Piece, TCG other, Unknown}
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

-- Phygitals: stub — metadata source not yet available (open item #4)
-- TODO @Hempanda: expose category field from mint metadata (Pokemon/One Piece/Sport/Figurine)
-- Uncomment and substitute real table when available:
-- phygitals_cat AS (
--     SELECT category, COUNT(*) AS cards_count, 'Phygitals' AS project
--     FROM <phygitals_mint_metadata_source>
--     WHERE block_date >= DATE '2026-01-01'
--     GROUP BY 1
-- ),

cc_cat AS (
    -- Coarse split: Sport tier addresses vs Pokemon default
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
)

SELECT category, SUM(cards_count) AS total_cards
FROM (
    SELECT category, cards_count FROM courtyard_cat
    UNION ALL
    -- SELECT category, cards_count FROM phygitals_cat  -- enable when data source available
    SELECT category, cards_count FROM cc_cat
)
GROUP BY category
ORDER BY total_cards DESC
