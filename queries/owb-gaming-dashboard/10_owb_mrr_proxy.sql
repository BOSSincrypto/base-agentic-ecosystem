-- OWB Agentic Gaming Dashboard - Query 10: Revenue Proxy (Monthly Revenue Estimation)
-- Estimates monthly revenue from NFT sales + LP fees (rewritten per team feedback)
-- NFT Sale (Web): 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
-- NFT Sale (Base App): 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
-- Treasury: 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
-- Start date: 2026-03-25 (agentic presale launch)
-- Save as: "OWB Gaming - Revenue Proxy"

WITH monthly_nft_web AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        COUNT(*) AS nft_web_txs,
        COUNT(DISTINCT t."from") AS nft_web_buyers
    FROM base.transactions t
    WHERE t."to" = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND t.block_time >= DATE '2026-03-25'
      AND t.success = true
    GROUP BY 1
),

-- USDC transfers to NFT Sale Web contract (actual revenue)
monthly_nft_web_revenue AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        SUM(amount) AS nft_web_usdc_revenue
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND block_date >= DATE '2026-03-25'
    GROUP BY 1
),

-- USDC transfers to Base App NFT sales address
monthly_nft_baseapp_revenue AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        SUM(amount) AS nft_baseapp_usdc_revenue,
        COUNT(*) AS nft_baseapp_txs
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
      AND block_date >= DATE '2026-03-25'
    GROUP BY 1
),

-- USDC transfers to Treasury (x402 payments + shop)
monthly_treasury_revenue AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        SUM(amount) AS treasury_usdc_revenue,
        COUNT(*) AS treasury_txs
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
      AND block_date >= DATE '2026-03-25'
    GROUP BY 1
),

monthly_dex AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        SUM(amount_usd) AS total_volume_usd,
        COUNT(*) AS trade_count,
        COUNT(DISTINCT tx_from) AS unique_traders,
        -- LP fee revenue (weighted avg across fee tiers: ~0.2%)
        SUM(amount_usd) * 0.002 AS est_lp_fee_revenue
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= DATE '2026-03-25'
    GROUP BY 1
),

-- Month spine
month_spine AS (
    SELECT month
    FROM UNNEST(sequence(
        DATE '2026-03-01',
        DATE_TRUNC('month', current_date),
        interval '1' month
    )) AS t(month)
)

SELECT
    ms.month AS "Month",
    -- NFT Sales Revenue
    ROUND(COALESCE(nw.nft_web_usdc_revenue, 0), 2) AS "NFT Web Revenue (USDC)",
    COALESCE(nwt.nft_web_txs, 0) AS "NFT Web Txs",
    COALESCE(nwt.nft_web_buyers, 0) AS "NFT Web Buyers",
    ROUND(COALESCE(nb.nft_baseapp_usdc_revenue, 0), 2) AS "NFT Base App Revenue (USDC)",
    COALESCE(nb.nft_baseapp_txs, 0) AS "NFT Base App Txs",
    -- Treasury Revenue
    ROUND(COALESCE(tr.treasury_usdc_revenue, 0), 2) AS "Treasury Revenue (USDC)",
    COALESCE(tr.treasury_txs, 0) AS "Treasury Txs",
    -- DEX metrics
    ROUND(COALESCE(md.total_volume_usd, 0), 2) AS "DEX Volume (USD)",
    COALESCE(md.trade_count, 0) AS "DEX Trades",
    ROUND(COALESCE(md.est_lp_fee_revenue, 0), 2) AS "Est LP Fee Revenue (USD)",
    -- Total Revenue Proxy
    ROUND(
        COALESCE(nw.nft_web_usdc_revenue, 0)
        + COALESCE(nb.nft_baseapp_usdc_revenue, 0)
        + COALESCE(tr.treasury_usdc_revenue, 0)
        + COALESCE(md.est_lp_fee_revenue, 0),
        2
    ) AS "Est Total Monthly Revenue (USD)",
    -- MoM growth
    CASE
        WHEN LAG(
            COALESCE(nw.nft_web_usdc_revenue, 0)
            + COALESCE(nb.nft_baseapp_usdc_revenue, 0)
            + COALESCE(tr.treasury_usdc_revenue, 0)
            + COALESCE(md.est_lp_fee_revenue, 0)
        ) OVER (ORDER BY ms.month) > 0
        THEN ROUND(
            100.0 * (
                (COALESCE(nw.nft_web_usdc_revenue, 0) + COALESCE(nb.nft_baseapp_usdc_revenue, 0) + COALESCE(tr.treasury_usdc_revenue, 0) + COALESCE(md.est_lp_fee_revenue, 0))
                - LAG(COALESCE(nw.nft_web_usdc_revenue, 0) + COALESCE(nb.nft_baseapp_usdc_revenue, 0) + COALESCE(tr.treasury_usdc_revenue, 0) + COALESCE(md.est_lp_fee_revenue, 0)) OVER (ORDER BY ms.month)
            ) / NULLIF(LAG(COALESCE(nw.nft_web_usdc_revenue, 0) + COALESCE(nb.nft_baseapp_usdc_revenue, 0) + COALESCE(tr.treasury_usdc_revenue, 0) + COALESCE(md.est_lp_fee_revenue, 0)) OVER (ORDER BY ms.month), 0),
            1
        )
        ELSE NULL
    END AS "MoM Revenue Growth %"
FROM month_spine ms
LEFT JOIN monthly_nft_web_revenue nw ON ms.month = nw.month
LEFT JOIN monthly_nft_web nwt ON ms.month = nwt.month
LEFT JOIN monthly_nft_baseapp_revenue nb ON ms.month = nb.month
LEFT JOIN monthly_treasury_revenue tr ON ms.month = tr.month
LEFT JOIN monthly_dex md ON ms.month = md.month
ORDER BY ms.month
