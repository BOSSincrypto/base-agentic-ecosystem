-- Section 5: Tools & Infrastructure — Combined KPIs
-- Tracks verified agentic infrastructure projects on Base (Batches 3.0)
-- Date range: 2026-01-01+ to save Dune credits
--
-- Data sources:
--   BlockRunAI:  erc20_base.evt_Transfer (USDC through address)
--   Floe Labs:   base.transactions (to/from facilitator) + erc20_base.evt_Transfer
--   CoC x402:    base.logs dual-topic (AuthorizationUsed + Transfer)
--
-- Save as: "Tools & Infra - Combined KPIs (V1)"

-- ============================================================
-- 1) BlockRunAI — USDC transfers through the address
-- ============================================================
WITH blockrun_txs AS (
    SELECT
        'BlockRunAI' AS project,
        evt_block_time AS block_time,
        evt_tx_hash AS tx_hash,
        CASE
            WHEN "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf THEN "to"
            ELSE "from"
        END AS counterparty,
        CAST(value AS DOUBLE) / 1e6 AS usdc_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND (
          "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
          OR "to" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
      )
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

-- ============================================================
-- 2) Floe Labs — transactions to/from facilitator
-- ============================================================
floe_base_txs AS (
    SELECT
        'Floe Labs' AS project,
        block_time,
        hash AS tx_hash,
        CASE
            WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
            ELSE "from"
        END AS counterparty,
        CAST(0 AS DOUBLE) AS usdc_amount
    FROM base.transactions
    WHERE (
        "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
    )
      AND success = true
      AND block_time >= TIMESTAMP '2026-01-01'
),

floe_token_txs AS (
    SELECT
        'Floe Labs' AS project,
        evt_block_time AS block_time,
        evt_tx_hash AS tx_hash,
        CASE
            WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
            ELSE "from"
        END AS counterparty,
        CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
            THEN CAST(value AS DOUBLE) / 1e6
            ELSE CAST(0 AS DOUBLE)
        END AS usdc_amount
    FROM erc20_base.evt_Transfer
    WHERE (
        "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
    )
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

-- ============================================================
-- 3) CoC x402 — USDC transfers with AuthorizationUsed filter
-- ============================================================
coc_target_transfers AS (
    SELECT
        block_time,
        tx_hash,
        VARBINARY_SUBSTRING(topic1, 13, 20) AS from_address,
        CAST(VARBINARY_TO_UINT256(data) AS DOUBLE) / 1e6 AS usdc_amount
    FROM base.logs
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND topic2 = 0x0000000000000000000000008b29dabd6fbb5a09dacbc7978eaed66a8540721d
      AND block_time >= TIMESTAMP '2026-01-01'
),

coc_authorized_hashes AS (
    SELECT DISTINCT l.tx_hash
    FROM base.logs l
    INNER JOIN (
        SELECT DISTINCT tx_hash FROM coc_target_transfers
    ) t ON l.tx_hash = t.tx_hash
    WHERE l.contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND l.topic0 = 0x98de503528ee59b575ef0c0a2576a82497bfc029a5685b209e9ec333479b10a5
      AND l.block_time >= TIMESTAMP '2026-01-01'
),

coc_x402_txs AS (
    SELECT
        'CoC x402' AS project,
        ct.block_time,
        ct.tx_hash,
        ct.from_address AS counterparty,
        ct.usdc_amount
    FROM coc_target_transfers ct
    INNER JOIN coc_authorized_hashes ca ON ct.tx_hash = ca.tx_hash
),

-- ============================================================
-- Combine all projects
-- ============================================================
all_txs AS (
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM blockrun_txs
    UNION ALL
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM floe_base_txs
    UNION ALL
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM floe_token_txs
    UNION ALL
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM coc_x402_txs
),

-- ============================================================
-- KPIs
-- ============================================================
total_kpi AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS total_txs,
        COUNT(DISTINCT counterparty) AS unique_counterparties,
        ROUND(SUM(usdc_amount), 2) AS total_usdc_volume,
        COUNT(DISTINCT project) AS active_projects
    FROM all_txs
),

-- WoW: last 7 full days vs previous 7 full days (excluding today)
wow_current AS (
    SELECT COUNT(DISTINCT tx_hash) AS txs_7d
    FROM all_txs
    WHERE block_time >= DATE_ADD('day', -7, CAST(CURRENT_DATE AS TIMESTAMP))
      AND block_time < CAST(CURRENT_DATE AS TIMESTAMP)
),

wow_prev AS (
    SELECT COUNT(DISTINCT tx_hash) AS txs_prev_7d
    FROM all_txs
    WHERE block_time >= DATE_ADD('day', -14, CAST(CURRENT_DATE AS TIMESTAMP))
      AND block_time < DATE_ADD('day', -7, CAST(CURRENT_DATE AS TIMESTAMP))
)

SELECT
    tk.total_txs             AS "Total Transactions",
    tk.unique_counterparties AS "Unique Counterparties",
    tk.total_usdc_volume     AS "Total USDC Volume",
    tk.active_projects       AS "Active Projects",
    CASE
        WHEN wp.txs_prev_7d > 0
        THEN ROUND(100.0 * (wc.txs_7d - wp.txs_prev_7d) / CAST(wp.txs_prev_7d AS DOUBLE), 1)
        ELSE 0
    END AS "WoW Growth %"
FROM total_kpi tk
CROSS JOIN wow_current wc
CROSS JOIN wow_prev wp
