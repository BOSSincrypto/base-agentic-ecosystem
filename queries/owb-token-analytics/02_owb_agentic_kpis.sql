-- =====================================================================
-- OWB Token Analytics - Query 2: Agentic Layer KPIs
-- Tracks agentic-specific metrics from presale date (March 25, 2026)
-- Agentic Claim 1: 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
-- Agentic Claim 2: 0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
-- NFT Passes (Agentic): 0x49046E2988A78222693c04AD049b68e5A4801034
-- =====================================================================

WITH agentic_contracts AS (
    SELECT address, label FROM (
        VALUES
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'Agentic Claim 1'),
        (0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203, 'Agentic Claim 2'),
        (0x49046E2988A78222693c04AD049b68e5A4801034, 'Agentic Passes')
    ) AS t(address, label)
),

-- Total agentic transactions since presale
agentic_txs AS (
    SELECT
        COUNT(*) AS total_agentic_txs,
        COUNT(DISTINCT t."from") AS unique_agentic_wallets
    FROM base.transactions t
    INNER JOIN agentic_contracts ac ON t."to" = ac.address
    WHERE t.block_time >= DATE '2026-03-25'
      AND t.success = true
),

-- Agentic Claim 1 transfers (1 OWB claims)
agentic_claim1_transfers AS (
    SELECT
        COUNT(*) AS claim1_transfers,
        COUNT(DISTINCT "to") AS claim1_unique_recipients,
        SUM(CAST(value AS DOUBLE) / 1e18) AS claim1_owb_distributed
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "from" = 0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb
      AND evt_block_time >= DATE '2026-03-25'
),

-- Agentic Claim 2 transfers
agentic_claim2_transfers AS (
    SELECT
        COUNT(*) AS claim2_transfers,
        COUNT(DISTINCT "to") AS claim2_unique_recipients,
        SUM(CAST(value AS DOUBLE) / 1e18) AS claim2_owb_distributed
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "from" = 0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203
      AND evt_block_time >= DATE '2026-03-25'
),

-- Agentic Passes NFT mints
agentic_passes AS (
    SELECT
        COUNT(*) AS passes_minted,
        COUNT(DISTINCT "to") AS unique_pass_holders
    FROM erc721_base.evt_Transfer
    WHERE contract_address = 0x49046E2988A78222693c04AD049b68e5A4801034
      AND "from" = 0x0000000000000000000000000000000000000000
),

-- 7d rolling comparison for agentic activity
agentic_7d AS (
    SELECT
        COUNT(*) AS txs_7d,
        COUNT(DISTINCT t."from") AS users_7d
    FROM base.transactions t
    INNER JOIN agentic_contracts ac ON t."to" = ac.address
    WHERE t.block_time >= now() - interval '7' day
      AND t.success = true
),

agentic_prev_7d AS (
    SELECT
        COUNT(*) AS txs_prev_7d,
        COUNT(DISTINCT t."from") AS users_prev_7d
    FROM base.transactions t
    INNER JOIN agentic_contracts ac ON t."to" = ac.address
    WHERE t.block_time >= now() - interval '14' day
      AND t.block_time < now() - interval '7' day
      AND t.success = true
),

-- Days since agentic launch
days_since AS (
    SELECT date_diff('day', DATE '2026-03-25', current_date) AS days_live
)

SELECT
    at.total_agentic_txs AS "Total Agentic Txs",
    at.unique_agentic_wallets AS "Unique Agentic Wallets",
    COALESCE(c1.claim1_transfers, 0) + COALESCE(c2.claim2_transfers, 0) AS "Total Agentic Claims",
    ROUND(COALESCE(c1.claim1_owb_distributed, 0) + COALESCE(c2.claim2_owb_distributed, 0), 0) AS "OWB Distributed (Agentic)",
    COALESCE(c1.claim1_unique_recipients, 0) AS "Claim 1 Unique Recipients",
    COALESCE(c2.claim2_unique_recipients, 0) AS "Claim 2 Unique Recipients",
    ap.passes_minted AS "Agentic Passes Minted",
    ap.unique_pass_holders AS "Unique Pass Holders",
    a7.txs_7d AS "Agentic Txs (7d)",
    CASE
        WHEN ap7.txs_prev_7d > 0
        THEN ROUND(100.0 * (a7.txs_7d - ap7.txs_prev_7d) / ap7.txs_prev_7d, 1)
        ELSE 0
    END AS "WoW Agentic Growth %",
    ds.days_live AS "Days Since Agentic Launch"
FROM agentic_txs at
CROSS JOIN agentic_claim1_transfers c1
CROSS JOIN agentic_claim2_transfers c2
CROSS JOIN agentic_passes ap
CROSS JOIN agentic_7d a7
CROSS JOIN agentic_prev_7d ap7
CROSS JOIN days_since ds
