-- =====================================================================
-- OWB Token Analytics - Query 22: Liquidity Pool TVL & Reserves
-- Historical TVL across Aerodrome + Uniswap V3 pools
-- Aerodrome Pool: 0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
-- Uniswap V3 Pool: 0xf252f51919dfca2c9c0ea279f11183580edee4d6
-- Pair: OWB/USDC (0.01% fee, 100% locked LP)
-- =====================================================================

WITH pool_addresses AS (
    SELECT address, pool_name FROM (
        VALUES
        (0xf252f51919dfca2c9c0ea279f11183580edee4d6, 'Uniswap V3'),
        (0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD, 'Aerodrome')
    ) AS t(address, pool_name)
),

-- Daily OWB reserves in each pool
daily_owb_flow AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        CASE
            WHEN "to" IN (SELECT address FROM pool_addresses) THEN 'inflow'
            WHEN "from" IN (SELECT address FROM pool_addresses) THEN 'outflow'
        END AS direction,
        COALESCE(
            (SELECT pool_name FROM pool_addresses WHERE address = "to"),
            (SELECT pool_name FROM pool_addresses WHERE address = "from")
        ) AS pool,
        CASE
            WHEN "to" IN (SELECT address FROM pool_addresses)
            THEN CAST(value AS DOUBLE) / 1e18
            ELSE -CAST(value AS DOUBLE) / 1e18
        END AS owb_flow
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND (
          "to" IN (SELECT address FROM pool_addresses)
          OR "from" IN (SELECT address FROM pool_addresses)
      )
      AND evt_block_time >= DATE '2026-01-01'
),

-- Daily USDC reserves in each pool
daily_usdc_flow AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        COALESCE(
            (SELECT pool_name FROM pool_addresses WHERE address = "to"),
            (SELECT pool_name FROM pool_addresses WHERE address = "from")
        ) AS pool,
        CASE
            WHEN "to" IN (SELECT address FROM pool_addresses)
            THEN CAST(value AS DOUBLE) / 1e6
            ELSE -CAST(value AS DOUBLE) / 1e6
        END AS usdc_flow
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC
      AND (
          "to" IN (SELECT address FROM pool_addresses)
          OR "from" IN (SELECT address FROM pool_addresses)
      )
      AND evt_block_time >= DATE '2026-01-01'
),

daily_pool_agg AS (
    SELECT
        day,
        pool,
        SUM(owb_flow) AS daily_owb_net
    FROM daily_owb_flow
    GROUP BY 1, 2
),

daily_usdc_agg AS (
    SELECT
        day,
        pool,
        SUM(usdc_flow) AS daily_usdc_net
    FROM daily_usdc_flow
    GROUP BY 1, 2
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    -- Cumulative OWB reserves per pool
    ROUND(SUM(COALESCE(CASE WHEN op.pool = 'Uniswap V3' THEN op.daily_owb_net END, 0))
        OVER (ORDER BY ds.day), 0) AS "Uniswap V3 OWB Reserve",
    ROUND(SUM(COALESCE(CASE WHEN op.pool = 'Aerodrome' THEN op.daily_owb_net END, 0))
        OVER (ORDER BY ds.day), 0) AS "Aerodrome OWB Reserve",
    -- Cumulative USDC reserves per pool
    ROUND(SUM(COALESCE(CASE WHEN up.pool = 'Uniswap V3' THEN up.daily_usdc_net END, 0))
        OVER (ORDER BY ds.day), 2) AS "Uniswap V3 USDC Reserve",
    ROUND(SUM(COALESCE(CASE WHEN up.pool = 'Aerodrome' THEN up.daily_usdc_net END, 0))
        OVER (ORDER BY ds.day), 2) AS "Aerodrome USDC Reserve",
    -- Total TVL (USDC side * 2 as proxy)
    ROUND(
        (SUM(COALESCE(CASE WHEN up.pool = 'Uniswap V3' THEN up.daily_usdc_net END, 0)) OVER (ORDER BY ds.day)
        + SUM(COALESCE(CASE WHEN up.pool = 'Aerodrome' THEN up.daily_usdc_net END, 0)) OVER (ORDER BY ds.day))
        * 2
    , 2) AS "Total TVL (USD Proxy)"
FROM date_spine ds
LEFT JOIN daily_pool_agg op ON ds.day = op.day
LEFT JOIN daily_usdc_agg up ON ds.day = up.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
