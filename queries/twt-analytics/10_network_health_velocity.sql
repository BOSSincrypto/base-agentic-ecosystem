-- TWT: Network Health & Token Velocity
-- Purpose: Active addresses + velocity index (daily transfer / total supply)
-- Visualization: Combined chart - area (active addresses) + line (velocity) dual Y-axis

WITH daily_transfers AS (
    SELECT
        block_date AS day,
        COUNT(*) AS transfer_count,
        SUM(amount) AS total_twt_transferred,
        SUM(amount_usd) AS total_usd_transferred
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)
    GROUP BY 1
),
daily_active AS (
    SELECT
        block_date AS day,
        COUNT(DISTINCT addr) AS active_addresses
    FROM (
        SELECT block_date, "from" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          AND block_date >= CAST('2024-01-01' AS DATE)
        UNION
        SELECT block_date, "to" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          AND block_date >= CAST('2024-01-01' AS DATE)
    ) u
    GROUP BY 1
),
daily_price AS (
    SELECT
        DATE_TRUNC('day', minute) AS day,
        AVG(price) AS price_usd
    FROM prices.usd
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND minute >= CAST('2024-01-01' AS TIMESTAMP)
    GROUP BY 1
)
SELECT
    COALESCE(t.day, a.day) AS day,
    a.active_addresses,
    t.transfer_count,
    t.total_twt_transferred,
    t.total_usd_transferred,
    p.price_usd,
    CASE
        WHEN p.price_usd > 0
        THEN t.total_twt_transferred / (1e9)
        ELSE NULL
    END AS velocity_index,
    AVG(
        CASE
            WHEN p.price_usd > 0
            THEN t.total_twt_transferred / (1e9)
            ELSE NULL
        END
    ) OVER (ORDER BY COALESCE(t.day, a.day) ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_velocity,
    AVG(CAST(a.active_addresses AS DOUBLE)) OVER (ORDER BY COALESCE(t.day, a.day) ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_active_addresses
FROM daily_transfers t
FULL OUTER JOIN daily_active a ON t.day = a.day
LEFT JOIN daily_price p ON COALESCE(t.day, a.day) = p.day
WHERE COALESCE(t.day, a.day) IS NOT NULL
ORDER BY 1
