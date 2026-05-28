-- Section 9 COMBINED: Beezie — Claw Inflow by Tier + Buyback
-- ONE scan of erc20_base.evt_transfer replaces TWO queries (9.1 + 9.2).
-- Classifies each USDC transfer as either claw_inflow (to machine) or buyback (from swap pool).
-- Chain: Base | Engine: small | Date: 2026-01-01+
--
-- Output columns serve two visualizations:
--   9.1 chart: filter WHERE flow_type = 'claw_inflow' → week, tier, usdc_amount, plays, unique_players
--   9.2 chart: filter WHERE flow_type = 'buyback'     → week, usdc_amount, num_txs, unique_recipients
--
-- Save as: "Beezie Deep Dive — 9.1+9.2 Combined"

WITH machines AS (
    SELECT addr, tier FROM (VALUES
        -- OLD SYSTEM (direct inflow)
        (0x25acd3ccb939703a742187d6f504428c684ea50c, 'Wildcard'),
        (0x8ed22e2569e4a5b4a872299591f0ac016ce19f4e, 'Wildcard'),
        (0xfdf28b9b957baed8f3d9962effa9b0fe1e189d6a, 'Wildcard'),
        (0x92d79b4b48230d44f915d47fea6c5f63c4565a69, 'Wildcard'),
        (0xa34426b958bc792bf2640befa204df579d81b3bf, 'Wildcard'),
        (0x7b8958961517daa2a0bea01249a9ac17f27725d6, 'Silver TCG'),
        (0x7d71dfc365e6518d40cfdb3f10068be0974e9992, 'Silver TCG'),
        (0x686328b1a104819dda8e8fa5681694a7b93e4061, 'Silver TCG'),
        (0x310b050b945c7b9ee66704ca137ddac003371508, 'Silver TCG'),
        (0x406762fc03d59776e2ea3c6546588aaf1813f173, 'Silver TCG'),
        (0x044cec512d7a5d6852a1b1f1bf5bb9f746962073, 'Gold TCG'),
        (0x1334e20c249b2c7b45a6b4bafa2947163d74c8b6, 'Gold TCG'),
        (0x6f4aba86b9e441f77a51fa4d9fc47001e5bf1072, 'Gold TCG'),
        (0x08f49b9d64a807ec00b1ba986dc9392c26029fcb, 'Gold TCG'),
        (0x5dfb0592e11d63fdaa880020e69f81cc122d2c97, 'Platinum TCG'),
        -- NEW SYSTEM (via Hub)
        (0xe0fb034589817d5148464d1ba8a0ea4e6e43dc01, 'Wildcard'),
        (0x2b90c05c353adc0b3fd55da84628fdba2abb28ca, 'Silver TCG'),
        (0x0d31f8616e6319536c86d7b8930bc1ccde92a626, 'Gold TCG'),
        (0x2caafc357e95b90215949dc24a7e55a3c92ddacf, 'Platinum TCG'),
        (0x4e956faac498b665e27c88bcef900f7eafbd4db1, 'No tier')
    ) AS t(addr, tier)
),

classified AS (
    SELECT
        date_trunc('week', tr.evt_block_time) AS week,
        CASE
            WHEN m.addr IS NOT NULL THEN 'claw_inflow'
            WHEN tr."from" = 0x80d7c04b738ef379971a6b73f25b1a71ea1c820d THEN 'buyback'
        END AS flow_type,
        COALESCE(m.tier, 'Buyback') AS tier,
        CAST(tr.value AS DOUBLE) / 1e6 AS usdc_amount,
        tr.evt_tx_hash,
        tr."from" AS sender,
        tr."to" AS recipient
    FROM erc20_base.evt_transfer tr
    LEFT JOIN machines m ON tr."to" = m.addr
    WHERE tr.contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
      AND tr.evt_block_time >= TIMESTAMP '2026-01-01'
      AND (
          m.addr IS NOT NULL
          OR tr."from" = 0x80d7c04b738ef379971a6b73f25b1a71ea1c820d
      )
)

SELECT
    week,
    flow_type,
    tier,
    ROUND(SUM(usdc_amount), 2)        AS usdc_amount,
    approx_distinct(evt_tx_hash)       AS num_txs,
    approx_distinct(
        CASE WHEN flow_type = 'claw_inflow' THEN sender
             WHEN flow_type = 'buyback'      THEN recipient
        END
    ) AS unique_users
FROM classified
WHERE flow_type IS NOT NULL
GROUP BY 1, 2, 3
ORDER BY week DESC, flow_type, tier
