-- OWB Agentic Gaming Dashboard - Query 4: Staking & Agentic Claims Deep Dive
-- Tracks real staking contract + agentic claim contracts activity
-- Staking: 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c (correct address)
-- Agentic Claim 1: 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
-- Agentic Claim 2: 0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
-- Claims: 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - Staking & Claims"

WITH staking_daily AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS staking_txs,
        COUNT(DISTINCT t."from") AS staking_users
    FROM base.transactions t
    WHERE t."to" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      AND t.block_time >= DATE '2026-03-25'
      AND t.success = true
    GROUP BY 1
),

agentic_claims_daily AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS agentic_claim_txs,
        COUNT(DISTINCT t."from") AS agentic_claim_users
    FROM base.transactions t
    WHERE t."to" IN (
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb,
        0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
    )
    AND t.block_time >= DATE '2026-03-25'
    AND t.success = true
    GROUP BY 1
),

rewards_claims_daily AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS claim_txs,
        COUNT(DISTINCT t."from") AS claim_users
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.block_time >= DATE '2026-03-25'
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
      AND "to" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      AND block_date >= DATE '2026-03-25'
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
      AND "from" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      AND block_date >= DATE '2026-03-25'
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-03-25', current_date, interval '1' day)) AS t(day)
),

combined AS (
    SELECT
        ds.day,
        COALESCE(sd.staking_txs, 0) AS "Staking Transactions",
        COALESCE(sd.staking_users, 0) AS "Staking Users",
        COALESCE(ac.agentic_claim_txs, 0) AS "Agentic Claim Transactions",
        COALESCE(ac.agentic_claim_users, 0) AS "Agentic Claim Users",
        COALESCE(cd.claim_txs, 0) AS "Reward Claim Transactions",
        COALESCE(cd.claim_users, 0) AS "Reward Claim Users",
        COALESCE(dep.owb_staked_amount, 0) AS "OWB Staked (Daily)",
        COALESCE(dep.deposit_count, 0) AS "Deposit Count",
        COALESCE(wth.owb_unstaked_amount, 0) AS "OWB Unstaked (Daily)",
        COALESCE(wth.withdrawal_count, 0) AS "Withdrawal Count",
        COALESCE(dep.owb_staked_amount, 0) - COALESCE(wth.owb_unstaked_amount, 0) AS "Net Staking Flow"
    FROM date_spine ds
    LEFT JOIN staking_daily sd ON ds.day = sd.day
    LEFT JOIN agentic_claims_daily ac ON ds.day = ac.day
    LEFT JOIN rewards_claims_daily cd ON ds.day = cd.day
    LEFT JOIN staking_deposits dep ON ds.day = dep.day
    LEFT JOIN staking_withdrawals wth ON ds.day = wth.day
)

SELECT
    day,
    "Staking Transactions",
    "Staking Users",
    "Agentic Claim Transactions",
    "Agentic Claim Users",
    "Reward Claim Transactions",
    "Reward Claim Users",
    ROUND("OWB Staked (Daily)", 2) AS "OWB Staked (Daily)",
    ROUND("OWB Unstaked (Daily)", 2) AS "OWB Unstaked (Daily)",
    ROUND("Net Staking Flow", 2) AS "Net Staking Flow",
    ROUND(SUM("Net Staking Flow") OVER (ORDER BY day), 2) AS "Cumulative Net Staking",
    SUM("Reward Claim Transactions") OVER (ORDER BY day) AS "Cumulative Reward Claims",
    SUM("Agentic Claim Transactions") OVER (ORDER BY day) AS "Cumulative Agentic Claims",
    ROUND(AVG("Staking Transactions" + "Agentic Claim Transactions" + "Reward Claim Transactions") OVER (
        ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 0) AS "Gaming Activity 7d MA"
FROM combined
WHERE day < current_date
ORDER BY day ASC
