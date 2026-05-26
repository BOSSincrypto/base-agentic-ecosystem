-- OWB Agentic Gaming Dashboard - Query 17: NFT Sales & Passes Revenue
-- Tracks USDC payments to NFT Sale contracts (Web + Base App)
-- NFT Sale (Web): 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
-- NFT Sale (Base App): 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
-- USDC (Base): 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - NFT Sales & Passes"

WITH nft_web_daily AS (
    SELECT
        block_date AS day,
        COUNT(*) AS web_purchases,
        COUNT(DISTINCT "from") AS web_buyers,
        SUM(amount) AS web_usdc_revenue
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND block_date >= DATE '2026-03-25'
    GROUP BY 1
),

nft_baseapp_daily AS (
    SELECT
        block_date AS day,
        COUNT(*) AS app_purchases,
        COUNT(DISTINCT "from") AS app_buyers,
        SUM(amount) AS app_usdc_revenue
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
      AND block_date >= DATE '2026-03-25'
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-03-25', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(nw.web_purchases, 0) AS "Web NFT Purchases",
    COALESCE(na.app_purchases, 0) AS "Base App NFT Purchases",
    COALESCE(nw.web_purchases, 0) + COALESCE(na.app_purchases, 0) AS "Total NFT Purchases",
    COALESCE(nw.web_buyers, 0) AS "Web Unique Buyers",
    COALESCE(na.app_buyers, 0) AS "App Unique Buyers",
    ROUND(COALESCE(nw.web_usdc_revenue, 0), 2) AS "Web USDC Revenue",
    ROUND(COALESCE(na.app_usdc_revenue, 0), 2) AS "App USDC Revenue",
    ROUND(COALESCE(nw.web_usdc_revenue, 0) + COALESCE(na.app_usdc_revenue, 0), 2) AS "Total USDC Revenue",
    SUM(COALESCE(nw.web_usdc_revenue, 0) + COALESCE(na.app_usdc_revenue, 0))
        OVER (ORDER BY ds.day) AS "Cumulative USDC Revenue",
    ROUND(AVG(COALESCE(nw.web_usdc_revenue, 0) + COALESCE(na.app_usdc_revenue, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS "Revenue 7d MA"
FROM date_spine ds
LEFT JOIN nft_web_daily nw ON ds.day = nw.day
LEFT JOIN nft_baseapp_daily na ON ds.day = na.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
