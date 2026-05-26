-- OWB Agentic Gaming Dashboard - Query 5: Holder Dynamics
-- Tracks new holders and holder growth over time
-- Save as: "OWB Gaming - Holder Dynamics"

WITH all_receivers AS (
    SELECT
        "to" AS wallet,
        MIN(block_date) AS first_received
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
    GROUP BY 1
),

-- Daily new holders
daily_new AS (
    SELECT
        first_received AS day,
        COUNT(DISTINCT wallet) AS new_holders
    FROM all_receivers
    GROUP BY 1
),

date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2026-03-25', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(dn.new_holders, 0) AS "New Holders",
    SUM(COALESCE(dn.new_holders, 0)) OVER (ORDER BY ds.day) AS "Cumulative Holders",
    ROUND(AVG(COALESCE(dn.new_holders, 0)) OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "New Holders 7d MA"
FROM date_spine ds
LEFT JOIN daily_new dn ON ds.day = dn.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
