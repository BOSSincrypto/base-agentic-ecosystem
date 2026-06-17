-- =====================================================================
-- OWB Token Analytics - Query 10: Holder Distribution & Growth
-- Current balance tiers: Dust (<1K), Retail (1K-10K), Dolphin (10K-100K),
--   Whale (100K-1M), Mega Whale (>1M)
-- Daily new holders growth
-- =====================================================================

WITH all_transfers AS (
    SELECT "to" AS wallet, CAST(value AS DOUBLE) / 1e18 AS amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
    UNION ALL
    SELECT "from" AS wallet, -CAST(value AS DOUBLE) / 1e18 AS amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
),

balances AS (
    SELECT
        wallet,
        SUM(amount) AS balance
    FROM all_transfers
    WHERE wallet != 0x0000000000000000000000000000000000000000
    GROUP BY 1
    HAVING SUM(amount) > 0
),

-- Tier distribution
tier_distribution AS (
    SELECT
        CASE
            WHEN balance >= 1000000 THEN 'Mega Whale (>1M)'
            WHEN balance >= 100000 THEN 'Whale (100K-1M)'
            WHEN balance >= 10000 THEN 'Dolphin (10K-100K)'
            WHEN balance >= 1000 THEN 'Retail (1K-10K)'
            ELSE 'Dust (<1K)'
        END AS tier,
        COUNT(*) AS holders,
        SUM(balance) AS total_supply
    FROM balances
    GROUP BY 1
),

-- Top 25 holders
top_holders AS (
    SELECT
        wallet,
        ROUND(balance, 0) AS balance,
        ROUND(100.0 * balance / (SELECT SUM(balance) FROM balances), 2) AS pct_supply,
        ROW_NUMBER() OVER (ORDER BY balance DESC) AS rank
    FROM balances
),

-- Total supply for concentration
supply_metrics AS (
    SELECT
        SUM(balance) AS total_supply,
        (SELECT SUM(balance) FROM top_holders WHERE rank <= 10) AS top10_supply,
        (SELECT SUM(balance) FROM top_holders WHERE rank <= 25) AS top25_supply,
        (SELECT SUM(balance) FROM top_holders WHERE rank <= 100) AS top100_supply
    FROM balances
)

SELECT
    td.tier AS "Holder Tier",
    td.holders AS "Number of Holders",
    ROUND(td.total_supply, 0) AS "Total Balance",
    ROUND(100.0 * td.total_supply / NULLIF(sm.total_supply, 0), 2) AS "% of Supply",
    ROUND(td.total_supply / NULLIF(td.holders, 0), 0) AS "Avg Balance per Holder",
    -- Concentration metrics (same for all rows)
    ROUND(100.0 * sm.top10_supply / NULLIF(sm.total_supply, 0), 2) AS "Top 10 % of Supply",
    ROUND(100.0 * sm.top25_supply / NULLIF(sm.total_supply, 0), 2) AS "Top 25 % of Supply",
    ROUND(100.0 * sm.top100_supply / NULLIF(sm.total_supply, 0), 2) AS "Top 100 % of Supply"
FROM tier_distribution td
CROSS JOIN supply_metrics sm
ORDER BY
    CASE td.tier
        WHEN 'Mega Whale (>1M)' THEN 1
        WHEN 'Whale (100K-1M)' THEN 2
        WHEN 'Dolphin (10K-100K)' THEN 3
        WHEN 'Retail (1K-10K)' THEN 4
        WHEN 'Dust (<1K)' THEN 5
    END
