-- =====================================================================
-- OWB Token Analytics - Query 6: vOWB Tokenomics
-- Tracks vOWB token distribution (in-game claims) and swaps to OWB
-- vOWB Token: 0xD5590F6CeCeF03b796fd904541727C2fe6346C06
-- vOWB Swap: 0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088
-- =====================================================================

WITH vowb_claims AS (
    -- vOWB distributed to players (minted or transferred from game)
    SELECT
        date_trunc('day', evt_block_time) AS day,
        COUNT(*) AS claim_count,
        COUNT(DISTINCT "to") AS unique_claimers,
        SUM(CAST(value AS DOUBLE) / 1e18) AS vowb_distributed
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xD5590F6CeCeF03b796fd904541727C2fe6346C06
      AND "from" = 0x0000000000000000000000000000000000000000  -- mints
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

vowb_swaps AS (
    -- vOWB swapped to OWB via swap contract
    SELECT
        date_trunc('day', t.block_time) AS day,
        COUNT(*) AS swap_count,
        COUNT(DISTINCT t."from") AS unique_swappers
    FROM base.transactions t
    WHERE t."to" = 0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088
      AND t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1
),

-- vOWB burned in swap (sent to swap contract)
vowb_burned AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e18) AS vowb_swapped_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xD5590F6CeCeF03b796fd904541727C2fe6346C06
      AND "to" = 0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- OWB received from swap contract
owb_from_swap AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e18) AS owb_received
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "from" = 0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- Total vOWB supply tracking
vowb_total_supply AS (
    SELECT
        SUM(CAST(value AS DOUBLE) / 1e18) AS total_minted
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xD5590F6CeCeF03b796fd904541727C2fe6346C06
      AND "from" = 0x0000000000000000000000000000000000000000
),

vowb_total_swapped AS (
    SELECT
        SUM(CAST(value AS DOUBLE) / 1e18) AS total_swapped
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xD5590F6CeCeF03b796fd904541727C2fe6346C06
      AND "to" = 0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    -- Daily claims
    COALESCE(vc.claim_count, 0) AS "vOWB Claims",
    COALESCE(vc.unique_claimers, 0) AS "Unique Claimers",
    ROUND(COALESCE(vc.vowb_distributed, 0), 0) AS "vOWB Distributed",
    -- Daily swaps
    COALESCE(vs.swap_count, 0) AS "vOWB Swaps",
    COALESCE(vs.unique_swappers, 0) AS "Unique Swappers",
    ROUND(COALESCE(vb.vowb_swapped_amount, 0), 0) AS "vOWB Swapped",
    ROUND(COALESCE(ofs.owb_received, 0), 0) AS "OWB Received from Swap",
    -- Swap ratio (if both present)
    CASE
        WHEN COALESCE(vb.vowb_swapped_amount, 0) > 0
        THEN ROUND(COALESCE(ofs.owb_received, 0) / vb.vowb_swapped_amount, 4)
        ELSE NULL
    END AS "Swap Ratio (OWB/vOWB)",
    -- Cumulative
    SUM(COALESCE(vc.vowb_distributed, 0)) OVER (ORDER BY ds.day) AS "Cumulative vOWB Distributed",
    SUM(COALESCE(vb.vowb_swapped_amount, 0)) OVER (ORDER BY ds.day) AS "Cumulative vOWB Swapped",
    -- Outstanding vOWB (not yet swapped)
    SUM(COALESCE(vc.vowb_distributed, 0)) OVER (ORDER BY ds.day)
    - SUM(COALESCE(vb.vowb_swapped_amount, 0)) OVER (ORDER BY ds.day) AS "Outstanding vOWB",
    -- 7d MA
    ROUND(AVG(COALESCE(vs.swap_count, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Swaps 7d MA"
FROM date_spine ds
LEFT JOIN vowb_claims vc ON ds.day = vc.day
LEFT JOIN vowb_swaps vs ON ds.day = vs.day
LEFT JOIN vowb_burned vb ON ds.day = vb.day
LEFT JOIN owb_from_swap ofs ON ds.day = ofs.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
