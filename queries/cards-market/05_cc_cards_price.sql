-- Section 7.4b: $CARDS — Price Series (Daily)
-- Preferred: prices.usd_daily if $CARDS is indexed by Dune.
-- Fallback: derive VWAP from dex_solana.trades.
-- Chain: Solana | Engine: small | Date: 2025-09-01+
--
-- Visualization: Line chart
--   X: day | Y: price
--
-- Save as: "CC Deep Dive — 7.4b $CARDS Price"

-- Primary: Dune price feed (if indexed)
-- SELECT day, price
-- FROM prices.usd_daily
-- WHERE contract_address = from_base58('CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp')
--   AND day >= DATE '2025-09-01'
-- ORDER BY day DESC

-- Fallback: VWAP derived from DEX trades
SELECT
    date_trunc('day', block_time) AS day,
    ROUND(
        SUM(amount_usd) / NULLIF(SUM(
            CASE
                WHEN token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
                    THEN token_bought_amount
                WHEN token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
                    THEN token_sold_amount
            END
        ), 0),
        6
    ) AS price
FROM dex_solana.trades
WHERE block_date >= DATE '2025-09-01'
  AND (
      token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
      OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
  )
GROUP BY 1
HAVING SUM(amount_usd) > 0
ORDER BY day DESC
