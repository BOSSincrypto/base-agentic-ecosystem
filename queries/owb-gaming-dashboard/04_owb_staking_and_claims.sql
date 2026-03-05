-- OWB Agentic Gaming Dashboard - Query 4: Staking & Rewards Claims Deep Dive
-- Tracks staking contract and rewards claim contract activity
-- Staking: 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
-- Claims: 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
-- Save as: "OWB Gaming - Staking & Claims"

WITH staking_daily AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS staking_txs,
        COUNT(DISTINCT t."from") AS staking_users
    FROM base.transactions t
    WHERE t."to" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
      AND t.block_time >= DATE '2025-06-01'
      AND t.success = true
    GROUP BY 1
),

claims_daily AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS claim_txs,
        COUNT(DISTINCT t."from") AS claim_users
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.block_time >= DATE '2025-06-01'
      AND t.success = true
    GROUP BY 1
),

-- OWB transfers TO staking contract (deposits)
staking_deposits AS (
    SELECT
        block_date AS day,
        SUM(amount) AS owb_staked_amount,
        COUNT(*) AS deposit_count
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "to" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
      AND block_date >= DATE '2025-06-01'
    GROUP BY 1
),

-- OWB transfers FROM staking contract (withdrawals)
staking_withdrawals AS (
    SELECT
        block_date AS day,
        SUM(amount) AS owb_unstaked_amount,
        COUNT(*) AS withdrawal_count
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "from" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
      AND block_date >= DATE '2025-06-01'
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2025-06-01', current_date, interval '1' day)) AS t(day)
),

combined AS (
    SELECT
        ds.day,
        COALESCE(sd.staking_txs, 0) AS "Staking Transactions",
        COALESCE(sd.staking_users, 0) AS "Staking Users",
        COALESCE(cd.claim_txs, 0) AS "Claim Transactions",
        COALESCE(cd.claim_users, 0) AS "Claim Users",
        COALESCE(dep.owb_staked_amount, 0) AS "OWB Staked (Daily)",
        COALESCE(dep.deposit_count, 0) AS "Deposit Count",
        COALESCE(wth.owb_unstaked_amount, 0) AS "OWB Unstaked (Daily)",
        COALESCE(wth.withdrawal_count, 0) AS "Withdrawal Count",
        COALESCE(dep.owb_staked_amount, 0) - COALESCE(wth.owb_unstaked_amount, 0) AS "Net Staking Flow"
    FROM date_spine ds
    LEFT JOIN staking_daily sd ON ds.day = sd.day
    LEFT JOIN claims_daily cd ON ds.day = cd.day
    LEFT JOIN staking_deposits dep ON ds.day = dep.day
    LEFT JOIN staking_withdrawals wth ON ds.day = wth.day
)

SELECT
    day,
    "Staking Transactions",
    "Staking Users",
    "Claim Transactions",
    "Claim Users",
    ROUND("OWB Staked (Daily)", 2) AS "OWB Staked (Daily)",
    ROUND("OWB Unstaked (Daily)", 2) AS "OWB Unstaked (Daily)",
    ROUND("Net Staking Flow", 2) AS "Net Staking Flow",
    SUM("Net Staking Flow") OVER (ORDER BY day) AS "Cumulative Net Staking",
    SUM("Claim Transactions") OVER (ORDER BY day) AS "Cumulative Claims",
    AVG("Staking Transactions" + "Claim Transactions") OVER (
        ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS "Gaming Activity 7d MA"
FROM combined
WHERE day < current_date
ORDER BY day ASC
