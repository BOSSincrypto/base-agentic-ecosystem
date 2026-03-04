-- OWB Agentic Gaming Dashboard - Query 7: Liquidity Pool TVL & Reserve Tracking
-- Tracks reserves and TVL across main OWB/USDC pools
-- Uniswap V3: 0xf252f51919dfca2c9c0ea279f11183580edee4d6
-- Aerodrome: 0x995985c9027e8a90c823a5e0a9112fea72d1f4dd
-- Save as: "OWB Gaming - Liquidity & TVL"

WITH pool_flows AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        CASE
            WHEN "to" = 0xf252f51919dfca2c9c0ea279f11183580edee4d6
                 OR "from" = 0xf252f51919dfca2c9c0ea279f11183580edee4d6
            THEN 'Uniswap V3'
            ELSE 'Aerodrome'
        END AS pool,
        -- USDC into pool
        SUM(CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                 AND "to" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS usdc_in,
        -- USDC out of pool
        SUM(CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                 AND "from" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS usdc_out,
        -- OWB into pool
        SUM(CASE
            WHEN contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND "to" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS owb_in,
        -- OWB out of pool
        SUM(CASE
            WHEN contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND "from" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS owb_out
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address IN (
          0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913,
          0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND (
          "to" IN (0xf252f51919dfca2c9c0ea279f11183580edee4d6, 0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD)
          OR "from" IN (0xf252f51919dfca2c9c0ea279f11183580edee4d6, 0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD)
      )
    GROUP BY 1, 2
),

reserves AS (
    SELECT
        day,
        pool,
        SUM(usdc_in - usdc_out) OVER (PARTITION BY pool ORDER BY day) AS usdc_reserves,
        SUM(owb_in - owb_out) OVER (PARTITION BY pool ORDER BY day) AS owb_reserves
    FROM pool_flows
),

daily_price AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        SUM(amount_usd) / NULLIF(
            SUM(CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                THEN token_bought_amount
                WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                THEN token_sold_amount
                ELSE 0
            END), 0
        ) AS owb_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
    GROUP BY 1
),

combined AS (
    SELECT
        r.day,
        r.pool AS "Pool",
        ROUND(r.usdc_reserves, 2) AS "USDC Reserves",
        ROUND(r.owb_reserves, 0) AS "OWB Reserves",
        ROUND(p.owb_price, 6) AS "OWB Price",
        ROUND(r.usdc_reserves + (r.owb_reserves * COALESCE(p.owb_price, 0)), 2) AS "TVL (USD)"
    FROM reserves r
    LEFT JOIN daily_price p ON r.day = p.day
    WHERE r.day >= DATE '2025-06-01'
)

SELECT * FROM combined

UNION ALL

SELECT
    day,
    'TOTAL (All Pools)' AS "Pool",
    ROUND(SUM("USDC Reserves"), 2) AS "USDC Reserves",
    ROUND(SUM("OWB Reserves"), 0) AS "OWB Reserves",
    MAX("OWB Price") AS "OWB Price",
    ROUND(SUM("TVL (USD)"), 2) AS "TVL (USD)"
FROM combined
GROUP BY day

ORDER BY day, "Pool"
