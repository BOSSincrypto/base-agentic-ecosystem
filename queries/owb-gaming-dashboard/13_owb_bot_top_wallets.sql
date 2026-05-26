-- OWB Agentic Gaming Dashboard - Query 13: Top DTU Wallets & Power Users
-- Deep dive into most active automated wallets interacting with OWB contracts
-- DTU = Daily Transacting Users (preferred over "bot" terminology)
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - Top DTU Wallets"

WITH all_interactions AS (
    SELECT
        t."from" AS wallet,
        CASE
            WHEN t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40 THEN 'Reward Claim'
            WHEN t."to" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb THEN 'Agentic Claim 1'
            WHEN t."to" = 0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203 THEN 'Agentic Claim 2'
            WHEN t."to" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c THEN 'Staking'
            WHEN t."to" = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1 THEN 'Token'
        END AS contract_type,
        t.block_time,
        t.hash
    FROM base.transactions t
    WHERE t."to" IN (
        0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40,
        0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb,
        0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203,
        0x692d11c779d43BBC12Cb8565C7f71a54A47D117c,
        0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
    )
    AND t.block_time >= DATE '2026-03-25'
    AND t.success = true
),

wallet_stats AS (
    SELECT
        wallet,
        COUNT(*) AS total_txs,
        COUNT(DISTINCT date_trunc('day', block_time)) AS active_days,
        COUNT(DISTINCT contract_type) AS contracts_used,
        COUNT(CASE WHEN contract_type = 'Reward Claim' THEN 1 END) AS claim_txs,
        COUNT(CASE WHEN contract_type IN ('Agentic Claim 1', 'Agentic Claim 2') THEN 1 END) AS agentic_claim_txs,
        COUNT(CASE WHEN contract_type = 'Staking' THEN 1 END) AS staking_txs,
        COUNT(CASE WHEN contract_type = 'Token' THEN 1 END) AS token_txs,
        MIN(block_time) AS first_seen,
        MAX(block_time) AS last_seen,
        CASE
            WHEN COUNT(*) > 1
            THEN ROUND(
                CAST(date_diff('second', MIN(block_time), MAX(block_time)) AS DOUBLE)
                / (COUNT(*) - 1),
                0
            )
            ELSE NULL
        END AS avg_interval_sec,
        date_diff('day', MIN(block_time), MAX(block_time)) AS activity_span_days
    FROM all_interactions
    GROUP BY 1
),

classified AS (
    SELECT
        *,
        CASE
            WHEN total_txs >= 50 AND avg_interval_sec IS NOT NULL AND avg_interval_sec < 900
            THEN 'High-Frequency Automated'
            WHEN total_txs >= 20 AND avg_interval_sec IS NOT NULL AND avg_interval_sec < 3600
            THEN 'Semi-Automated'
            WHEN total_txs >= 10
            THEN 'Power User'
            ELSE 'Regular User'
        END AS classification,
        ROUND(CAST(total_txs AS DOUBLE) / NULLIF(active_days, 0), 1) AS txs_per_active_day
    FROM wallet_stats
)

SELECT
    CAST(wallet AS VARCHAR) AS "Wallet",
    classification AS "Classification",
    total_txs AS "Total Txs",
    active_days AS "Active Days",
    txs_per_active_day AS "Txs/Active Day",
    claim_txs AS "Reward Claims",
    agentic_claim_txs AS "Agentic Claims",
    staking_txs AS "Staking Txs",
    token_txs AS "Token Txs",
    contracts_used AS "Contracts Used",
    avg_interval_sec AS "Avg Interval (sec)",
    CAST(first_seen AS DATE) AS "First Seen",
    CAST(last_seen AS DATE) AS "Last Active",
    activity_span_days AS "Activity Span (days)"
FROM classified
WHERE total_txs >= 5
ORDER BY total_txs DESC
LIMIT 100
