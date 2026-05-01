-- Section 5: Tools & Infrastructure — Daily Activity Trend
-- Stacked bars by project + 7d MA overlay + cumulative metrics
-- Date range: 2026-01-01+
--
-- Save as: "Tools & Infra - Daily Activity Trend (V1)"

-- ============================================================
-- BlockRunAI — USDC transfers
-- ============================================================
WITH blockrun_daily AS (
    SELECT
        DATE_TRUNC('day', evt_block_time) AS day,
        'BlockRunAI' AS project,
        COUNT(DISTINCT evt_tx_hash) AS daily_txs,
        COUNT(DISTINCT CASE
            WHEN "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf THEN "to"
            ELSE "from"
        END) AS daily_users,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS daily_usdc
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND (
          "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
          OR "to" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
      )
      AND evt_block_time >= TIMESTAMP '2026-01-01'
      AND evt_block_time < CAST(CURRENT_DATE AS TIMESTAMP)
    GROUP BY 1
),

-- ============================================================
-- Floe Labs — base transactions + token transfers
-- ============================================================
floe_daily AS (
    SELECT day, 'Floe Labs' AS project, SUM(txs) AS daily_txs, SUM(users) AS daily_users, SUM(usdc) AS daily_usdc
    FROM (
        SELECT
            DATE_TRUNC('day', block_time) AS day,
            COUNT(DISTINCT hash) AS txs,
            COUNT(DISTINCT CASE
                WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
                ELSE "from"
            END) AS users,
            CAST(0 AS DOUBLE) AS usdc
        FROM base.transactions
        WHERE (
            "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
            OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        )
          AND success = true
          AND block_time >= TIMESTAMP '2026-01-01'
          AND block_time < CAST(CURRENT_DATE AS TIMESTAMP)
        GROUP BY 1

        UNION ALL

        SELECT
            DATE_TRUNC('day', evt_block_time) AS day,
            COUNT(DISTINCT evt_tx_hash) AS txs,
            COUNT(DISTINCT CASE
                WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
                ELSE "from"
            END) AS users,
            ROUND(SUM(CASE
                WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                THEN CAST(value AS DOUBLE) / 1e6
                ELSE 0
            END), 2) AS usdc
        FROM erc20_base.evt_Transfer
        WHERE (
            "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
            OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        )
          AND evt_block_time >= TIMESTAMP '2026-01-01'
          AND evt_block_time < CAST(CURRENT_DATE AS TIMESTAMP)
        GROUP BY 1
    ) combined
    GROUP BY 1
),

-- ============================================================
-- CoC x402 — dual-topic filter
-- ============================================================
coc_transfers_raw AS (
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
      AND block_time < CAST(CURRENT_DATE AS TIMESTAMP)
),

coc_auth_hashes AS (
    SELECT DISTINCT l.tx_hash
    FROM base.logs l
    INNER JOIN (SELECT DISTINCT tx_hash FROM coc_transfers_raw) t ON l.tx_hash = t.tx_hash
    WHERE l.contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND l.topic0 = 0x98de503528ee59b575ef0c0a2576a82497bfc029a5685b209e9ec333479b10a5
      AND l.block_time >= TIMESTAMP '2026-01-01'
),

coc_daily AS (
    SELECT
        DATE_TRUNC('day', ct.block_time) AS day,
        'CoC x402' AS project,
        COUNT(DISTINCT ct.tx_hash) AS daily_txs,
        COUNT(DISTINCT ct.from_address) AS daily_users,
        ROUND(SUM(ct.usdc_amount), 2) AS daily_usdc
    FROM coc_transfers_raw ct
    INNER JOIN coc_auth_hashes ca ON ct.tx_hash = ca.tx_hash
    GROUP BY 1
),

-- ============================================================
-- Combine per-project daily
-- ============================================================
all_daily AS (
    SELECT * FROM blockrun_daily
    UNION ALL
    SELECT * FROM floe_daily
    UNION ALL
    SELECT * FROM coc_daily
),

-- Total daily across all projects
daily_total AS (
    SELECT
        day,
        SUM(daily_txs) AS total_txs,
        SUM(daily_users) AS total_users,
        SUM(daily_usdc) AS total_usdc
    FROM all_daily
    GROUP BY 1
)

SELECT
    dt.day,
    dt.total_txs AS "Total Infra Txs",
    dt.total_users AS "Total Unique Addresses",
    ROUND(dt.total_usdc, 2) AS "USDC Volume",
    -- 7d Moving Averages
    ROUND(AVG(dt.total_txs) OVER (ORDER BY dt.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Infra Txs 7d MA",
    -- Cumulative
    SUM(dt.total_txs) OVER (ORDER BY dt.day) AS "Cumulative Txs",
    SUM(dt.total_usdc) OVER (ORDER BY dt.day) AS "Cumulative USDC Volume",
    -- Per-project breakdown
    COALESCE(MAX(CASE WHEN ad.project = 'BlockRunAI' THEN ad.daily_txs END), 0) AS "BlockRunAI Txs",
    COALESCE(MAX(CASE WHEN ad.project = 'Floe Labs' THEN ad.daily_txs END), 0) AS "Floe Labs Txs",
    COALESCE(MAX(CASE WHEN ad.project = 'CoC x402' THEN ad.daily_txs END), 0) AS "CoC x402 Txs",
    -- Per-project USDC
    COALESCE(MAX(CASE WHEN ad.project = 'BlockRunAI' THEN ad.daily_usdc END), 0) AS "BlockRunAI USDC",
    COALESCE(MAX(CASE WHEN ad.project = 'CoC x402' THEN ad.daily_usdc END), 0) AS "CoC x402 USDC"
FROM daily_total dt
LEFT JOIN all_daily ad ON dt.day = ad.day
GROUP BY 1, 2, 3, 4
ORDER BY 1 ASC
