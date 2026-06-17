-- =====================================================================
-- OWB Token Analytics - Query 9: Treasury & Revenue Flows
-- Treasury: 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d (x402 + shop)
-- Base Pay: 0xf46A1D3eAA84558887169CF2CEE343491364c8BA (player payments)
-- Tracks USDC and OWB inflows/outflows
-- =====================================================================

WITH treasury_usdc_in AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        COUNT(*) AS transfer_count,
        COUNT(DISTINCT "from") AS unique_senders,
        SUM(CAST(value AS DOUBLE) / 1e6) AS usdc_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC
      AND "to" = 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

treasury_usdc_out AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e6) AS usdc_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "from" = 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

treasury_owb_in AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e18) AS owb_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "to" = 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

treasury_owb_out AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e18) AS owb_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "from" = 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- Base Pay (player payments) USDC
basepay_usdc_in AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        COUNT(*) AS payment_count,
        COUNT(DISTINCT "from") AS unique_payers,
        SUM(CAST(value AS DOUBLE) / 1e6) AS usdc_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    -- Treasury USDC
    ROUND(COALESCE(tui.usdc_amount, 0), 2) AS "Treasury USDC In",
    ROUND(COALESCE(tuo.usdc_amount, 0), 2) AS "Treasury USDC Out",
    ROUND(COALESCE(tui.usdc_amount, 0) - COALESCE(tuo.usdc_amount, 0), 2) AS "Treasury USDC Net",
    COALESCE(tui.transfer_count, 0) AS "Treasury Inflow Txs",
    COALESCE(tui.unique_senders, 0) AS "Unique Revenue Sources",
    -- Treasury OWB
    ROUND(COALESCE(toi.owb_amount, 0), 0) AS "Treasury OWB In",
    ROUND(COALESCE(too.owb_amount, 0), 0) AS "Treasury OWB Out",
    -- Base Pay
    ROUND(COALESCE(bpi.usdc_amount, 0), 2) AS "Base Pay USDC In",
    COALESCE(bpi.payment_count, 0) AS "Base Pay Payments",
    COALESCE(bpi.unique_payers, 0) AS "Base Pay Unique Payers",
    -- Combined Revenue
    ROUND(COALESCE(tui.usdc_amount, 0) + COALESCE(bpi.usdc_amount, 0), 2) AS "Total Platform Revenue (USDC)",
    -- Cumulative
    ROUND(SUM(COALESCE(tui.usdc_amount, 0) + COALESCE(bpi.usdc_amount, 0))
        OVER (ORDER BY ds.day), 2) AS "Cumulative Revenue (USDC)",
    ROUND(SUM(COALESCE(tui.usdc_amount, 0) - COALESCE(tuo.usdc_amount, 0))
        OVER (ORDER BY ds.day), 2) AS "Treasury USDC Balance (Approx)",
    -- 7d MA
    ROUND(AVG(COALESCE(tui.usdc_amount, 0) + COALESCE(bpi.usdc_amount, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS "Revenue 7d MA"
FROM date_spine ds
LEFT JOIN treasury_usdc_in tui ON ds.day = tui.day
LEFT JOIN treasury_usdc_out tuo ON ds.day = tuo.day
LEFT JOIN treasury_owb_in toi ON ds.day = toi.day
LEFT JOIN treasury_owb_out too ON ds.day = too.day
LEFT JOIN basepay_usdc_in bpi ON ds.day = bpi.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
