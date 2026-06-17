-- =====================================================================
-- OWB Token Analytics - Query 11: Holder Growth Over Time
-- Daily new holders and cumulative holder count
-- Based on first transfer received (excluding zero address)
-- =====================================================================

WITH first_received AS (
    SELECT
        "to" AS wallet,
        MIN(date_trunc('day', evt_block_time)) AS first_day
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "to" != 0x0000000000000000000000000000000000000000
    GROUP BY 1
),

daily_new AS (
    SELECT
        first_day AS day,
        COUNT(*) AS new_holders
    FROM first_received
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(
        (SELECT MIN(first_day) FROM first_received),
        current_date,
        interval '1' day
    )) AS t(day)
)

SELECT
    ds.day,
    COALESCE(dn.new_holders, 0) AS "New Holders",
    SUM(COALESCE(dn.new_holders, 0)) OVER (ORDER BY ds.day) AS "Cumulative Holders (All-Time)",
    -- 7d MA
    ROUND(AVG(COALESCE(dn.new_holders, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "New Holders 7d MA",
    -- 30d MA
    ROUND(AVG(COALESCE(dn.new_holders, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW), 0) AS "New Holders 30d MA"
FROM date_spine ds
LEFT JOIN daily_new dn ON ds.day = dn.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
