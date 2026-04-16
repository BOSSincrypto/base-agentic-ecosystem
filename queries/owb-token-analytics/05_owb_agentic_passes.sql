-- =====================================================================
-- OWB Token Analytics - Query 5: Agentic Passes Analytics
-- Tracks NFT Passes (0x49046E2988A78222693c04AD049b68e5A4801034)
-- Mints, holders, daily activity, revenue estimation
-- Pass tiers: Hero ($10), Champion ($100), Legend ($1000)
-- =====================================================================

WITH pass_mints AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        "to" AS buyer,
        tokenId
    FROM erc721_base.evt_Transfer
    WHERE contract_address = 0x49046E2988A78222693c04AD049b68e5A4801034
      AND "from" = 0x0000000000000000000000000000000000000000
),

daily_mints AS (
    SELECT
        day,
        COUNT(*) AS passes_minted,
        COUNT(DISTINCT buyer) AS unique_buyers
    FROM pass_mints
    GROUP BY 1
),

-- USDC payments to NFT Sale contract for passes
pass_payments AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        CAST(value AS DOUBLE) / 1e6 AS usdc_amount,
        "from" AS buyer
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC
      AND "to" = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b          -- NFT Sale
      AND evt_block_time >= DATE '2026-03-01'
      AND CAST(value AS DOUBLE) / 1e6 >= 9  -- filter out dust, min pass ~$10
),

daily_revenue AS (
    SELECT
        day,
        SUM(usdc_amount) AS total_revenue,
        COUNT(*) AS payment_count,
        COUNT(DISTINCT buyer) AS paying_users,
        SUM(CASE WHEN usdc_amount >= 900 THEN 1 ELSE 0 END) AS legend_passes,
        SUM(CASE WHEN usdc_amount >= 90 AND usdc_amount < 900 THEN 1 ELSE 0 END) AS champion_passes,
        SUM(CASE WHEN usdc_amount >= 9 AND usdc_amount < 90 THEN 1 ELSE 0 END) AS hero_passes
    FROM pass_payments
    GROUP BY 1
),

-- Current pass holders (not transferred away)
current_holders AS (
    SELECT COUNT(DISTINCT owner) AS total_holders
    FROM (
        SELECT
            "to" AS owner,
            tokenId,
            ROW_NUMBER() OVER (PARTITION BY tokenId ORDER BY evt_block_number DESC, evt_index DESC) AS rn
        FROM erc721_base.evt_Transfer
        WHERE contract_address = 0x49046E2988A78222693c04AD049b68e5A4801034
    )
    WHERE rn = 1
      AND owner != 0x0000000000000000000000000000000000000000
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-03-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(dm.passes_minted, 0) AS "Passes Minted",
    COALESCE(dm.unique_buyers, 0) AS "Unique Buyers",
    COALESCE(dr.legend_passes, 0) AS "Legend Passes ($1000)",
    COALESCE(dr.champion_passes, 0) AS "Champion Passes ($100)",
    COALESCE(dr.hero_passes, 0) AS "Hero Passes ($10)",
    ROUND(COALESCE(dr.total_revenue, 0), 2) AS "Daily Revenue (USDC)",
    -- Cumulative
    SUM(COALESCE(dm.passes_minted, 0)) OVER (ORDER BY ds.day) AS "Cumulative Passes",
    SUM(COALESCE(dr.total_revenue, 0)) OVER (ORDER BY ds.day) AS "Cumulative Revenue (USDC)",
    -- 7d MA
    ROUND(AVG(COALESCE(dm.passes_minted, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Mints 7d MA",
    -- MRR estimation (annualized from cumulative)
    ROUND(
        SUM(COALESCE(dr.legend_passes, 0)) OVER (ORDER BY ds.day) * 1000.0 / 12
        + SUM(COALESCE(dr.champion_passes, 0)) OVER (ORDER BY ds.day) * 100.0 / 3
        + SUM(COALESCE(dr.hero_passes, 0)) OVER (ORDER BY ds.day) * 10.0
    , 2) AS "Est Monthly Recurring Revenue"
FROM date_spine ds
LEFT JOIN daily_mints dm ON ds.day = dm.day
LEFT JOIN daily_revenue dr ON ds.day = dr.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
