-- Section 7.4a+7.4b COMBINED: $CARDS — Daily DEX Volume + VWAP Price
-- ONE scan of dex_solana.trades replaces TWO queries (7.4a + 7.4b).
-- Chain: Solana | Engine: medium | Date: 2025-09-01+
--
-- Output columns serve two visualizations:
--   7.4a chart: day, dex_volume_usd, num_trades, unique_traders
--   7.4b chart: day, vwap_price
--
-- Save as: "CC Deep Dive — 7.4 $CARDS Token (Volume + Price)"

SELECT
    date_trunc('day', block_time) AS day,

    -- 7.4a: DEX Volume & Traders
    ROUND(SUM(amount_usd), 2)     AS dex_volume_usd,
    COUNT(*)                       AS num_trades,
    approx_distinct(trader_id)     AS unique_traders,

    -- 7.4b: VWAP Price
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
    ) AS vwap_price

FROM dex_solana.trades
WHERE block_date >= DATE '2025-09-01'
  AND (
      token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
      OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
  )
GROUP BY 1
HAVING SUM(amount_usd) > 0
ORDER BY day DESC
