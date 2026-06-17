-- =====================================================================
-- OWB Token Analytics - Query 4: NFT Sales & Revenue
-- Tracks NFT purchases from web (vOWB + USDC) and Base App (USDC)
-- Web NFT Sale: 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
--   topic0 vOWB sale: 0xf10061092bbb1af405b21f944d5a3fc967534deaabe2a030b36dfdd9e565d1e6
--   topic0 USDC sale: 0x63283f7a7cc750062bcd0676724d5ad05f2fa23df7619d9bde3f8abc776575d1
-- Base App: 0xf46A1D3eAA84558887169CF2CEE343491364c8BA (USDC transfers)
-- =====================================================================

WITH web_sales_vowb AS (
    SELECT
        date_trunc('day', block_time) AS day,
        COUNT(*) AS sales_count,
        COUNT(DISTINCT tx_from) AS unique_buyers
    FROM base.logs
    WHERE contract_address = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND topic0 = 0xf10061092bbb1af405b21f944d5a3fc967534deaabe2a030b36dfdd9e565d1e6
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

web_sales_usdc AS (
    SELECT
        date_trunc('day', block_time) AS day,
        COUNT(*) AS sales_count,
        COUNT(DISTINCT tx_from) AS unique_buyers
    FROM base.logs
    WHERE contract_address = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND topic0 = 0x63283f7a7cc750062bcd0676724d5ad05f2fa23df7619d9bde3f8abc776575d1
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- Base App revenue: USDC transfers TO the Base Pay address
base_app_revenue AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        COUNT(*) AS transfers_count,
        COUNT(DISTINCT "from") AS unique_buyers,
        SUM(CAST(value AS DOUBLE) / 1e6) AS usdc_revenue
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC
      AND "to" = 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- Web shop USDC revenue
web_usdc_revenue AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e6) AS usdc_revenue
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC
      AND "to" = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- Web shop vOWB revenue
web_vowb_revenue AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e18) AS vowb_revenue
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xD5590F6CeCeF03b796fd904541727C2fe6346C06  -- vOWB
      AND "to" = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    -- Web Sales
    COALESCE(wv.sales_count, 0) AS "Web Sales (vOWB)",
    COALESCE(wu.sales_count, 0) AS "Web Sales (USDC)",
    COALESCE(wv.sales_count, 0) + COALESCE(wu.sales_count, 0) AS "Total Web Sales",
    COALESCE(wv.unique_buyers, 0) + COALESCE(wu.unique_buyers, 0) AS "Web Unique Buyers",
    -- Base App Sales
    COALESCE(ba.transfers_count, 0) AS "Base App Sales",
    COALESCE(ba.unique_buyers, 0) AS "Base App Unique Buyers",
    -- Revenue
    ROUND(COALESCE(wur.usdc_revenue, 0), 2) AS "Web USDC Revenue",
    ROUND(COALESCE(wvr.vowb_revenue, 0), 0) AS "Web vOWB Revenue (tokens)",
    ROUND(COALESCE(ba.usdc_revenue, 0), 2) AS "Base App USDC Revenue",
    ROUND(COALESCE(wur.usdc_revenue, 0) + COALESCE(ba.usdc_revenue, 0), 2) AS "Total USDC Revenue",
    -- Totals
    COALESCE(wv.sales_count, 0) + COALESCE(wu.sales_count, 0) + COALESCE(ba.transfers_count, 0) AS "Total Sales (All)",
    -- Cumulative
    SUM(COALESCE(wur.usdc_revenue, 0) + COALESCE(ba.usdc_revenue, 0))
        OVER (ORDER BY ds.day) AS "Cumulative USDC Revenue",
    -- 7d MA
    ROUND(AVG(COALESCE(wv.sales_count, 0) + COALESCE(wu.sales_count, 0) + COALESCE(ba.transfers_count, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Sales 7d MA"
FROM date_spine ds
LEFT JOIN web_sales_vowb wv ON ds.day = wv.day
LEFT JOIN web_sales_usdc wu ON ds.day = wu.day
LEFT JOIN base_app_revenue ba ON ds.day = ba.day
LEFT JOIN web_usdc_revenue wur ON ds.day = wur.day
LEFT JOIN web_vowb_revenue wvr ON ds.day = wvr.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
