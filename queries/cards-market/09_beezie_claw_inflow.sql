-- Section 9.1: Beezie — Weekly USDC Inflow to Claw Machines by Tier
-- All 20 claw machines: 15 old system (direct inflow) + 5 new system (via Hub).
-- Chain: Base | Engine: small | Date: 2026-01-01+
-- USDC Base: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
--
-- NOTE: new-system machines may receive USDC from Hub V2 (0xAa9C...)
--       rather than end user directly. Confirm routing with @Hempanda
--       before trusting per-tier unique_players on new-system machines.
--
-- Visualization: Stacked bar chart
--   X: week | Y: usdc_inflow | Series: tier
--   Palette: Wildcard #9CA3AF, Silver TCG #3B82F6,
--            Gold TCG #F59E0B, Platinum TCG #8B5CF6, No tier #374151
--
-- Save as: "Beezie Deep Dive — 9.1 Claw Inflow by Tier"

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
)

SELECT
    date_trunc('week', tr.evt_block_time)  AS week,
    m.tier,
    ROUND(SUM(CAST(tr.value AS DOUBLE) / 1e6), 2) AS usdc_inflow,
    approx_distinct(tr.evt_tx_hash)        AS plays,
    approx_distinct(tr."from")             AS unique_players
FROM erc20_base.evt_transfer tr
JOIN machines m ON tr."to" = m.addr
WHERE tr.contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
  AND tr.evt_block_time >= TIMESTAMP '2026-01-01'
GROUP BY 1, 2
ORDER BY week DESC
