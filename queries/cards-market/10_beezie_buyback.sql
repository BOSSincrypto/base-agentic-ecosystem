-- Section 9.2: Beezie — Buyback via Swap Pool
-- USDC out of swap/buyback pool 0x80d7C04B738eF379971a6b73f25B1A71ea1c820D
-- Chain: Base | Engine: small | Date: 2026-01-01+
--
-- Visualization: Bar chart
--   X: week | Y: buyback_usdc
--   KPI: total buyback 4wk, num_buybacks, unique_recipients
--
-- Save as: "Beezie Deep Dive — 9.2 Buyback"

SELECT
    date_trunc('week', evt_block_time)  AS week,
    ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS buyback_usdc,
    approx_distinct(evt_tx_hash)        AS num_buybacks,
    approx_distinct("to")               AS unique_recipients
FROM erc20_base.evt_transfer
WHERE contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
  AND "from" = 0x80d7c04b738ef379971a6b73f25b1a71ea1c820d
  AND evt_block_time >= TIMESTAMP '2026-01-01'
GROUP BY 1
ORDER BY week DESC
