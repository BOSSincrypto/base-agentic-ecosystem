-- =====================================================================
-- OWB Token Analytics - Query 21: Dead Capital Tracker
-- Dormant Token Analysis for OWB
-- Tracks wallets by last activity: Active (<90d), Dormant (90-180d),
-- Deep Dormant (180-365d), Dead (>365d)
-- =====================================================================

WITH last_activity AS (
    SELECT
        wallet,
        balance,
        MAX(last_tx) AS last_active
    FROM (
        SELECT
            "to" AS wallet,
            MAX(evt_block_time) AS last_tx,
            0 AS balance
        FROM erc20_base.evt_Transfer
        WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          AND "to" != 0x0000000000000000000000000000000000000000
        GROUP BY 1
        UNION ALL
        SELECT
            "from" AS wallet,
            MAX(evt_block_time) AS last_tx,
            0 AS balance
        FROM erc20_base.evt_Transfer
        WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          AND "from" != 0x0000000000000000000000000000000000000000
        GROUP BY 1
    )
    GROUP BY 1, 2
),

balances AS (
    SELECT
        wallet,
        SUM(amount) AS balance
    FROM (
        SELECT "to" AS wallet, CAST(value AS DOUBLE) / 1e18 AS amount
        FROM erc20_base.evt_Transfer
        WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
        UNION ALL
        SELECT "from" AS wallet, -CAST(value AS DOUBLE) / 1e18 AS amount
        FROM erc20_base.evt_Transfer
        WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
    )
    WHERE wallet != 0x0000000000000000000000000000000000000000
    GROUP BY 1
    HAVING SUM(amount) > 0
),

combined AS (
    SELECT
        b.wallet,
        b.balance,
        la.last_active,
        date_diff('day', la.last_active, now()) AS days_dormant,
        CASE
            WHEN date_diff('day', la.last_active, now()) < 90 THEN 'Active (< 90d)'
            WHEN date_diff('day', la.last_active, now()) < 180 THEN 'Dormant 90-180d'
            WHEN date_diff('day', la.last_active, now()) < 365 THEN 'Dormant 180-365d'
            ELSE 'Dormant 365-730d'
        END AS status
    FROM balances b
    INNER JOIN last_activity la ON b.wallet = la.wallet
),

total AS (
    SELECT SUM(balance) AS total_supply FROM combined
)

SELECT
    c.status AS "Status",
    COUNT(*) AS "Holders",
    ROUND(SUM(c.balance), 0) AS "Total Balance (OWB)",
    ROUND(100.0 * SUM(c.balance) / NULLIF(t.total_supply, 0), 1) AS "% of Supply",
    ROUND(AVG(c.balance), 0) AS "Avg Balance",
    ROUND(MEDIAN(c.balance), 0) AS "Median Balance"
FROM combined c
CROSS JOIN total t
GROUP BY c.status, t.total_supply
ORDER BY
    CASE c.status
        WHEN 'Active (< 90d)' THEN 1
        WHEN 'Dormant 90-180d' THEN 2
        WHEN 'Dormant 180-365d' THEN 3
        WHEN 'Dormant 365-730d' THEN 4
    END
