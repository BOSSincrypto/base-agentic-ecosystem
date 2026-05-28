-- Section 7.4a: $CARDS — Daily DEX Volume & Traders
-- $CARDS is Collector Crypt's project token on Solana, separate from gacha.
-- Token volume reflects speculator activity, not card spend.
-- Chain: Solana | Engine: medium | Date: 2025-09-01+
--
-- Visualization: Line + Bar combo
--   Bar: dex_volume_usd | Line: num_trades or unique_traders
--   Disclaimer: "$CARDS DEX activity reflects speculation, not card spend."
--
-- Save as: "CC Deep Dive — 7.4a $CARDS DEX Volume"

SELECT
    date_trunc('day', block_time)     AS day,
    ROUND(SUM(amount_usd), 2)        AS dex_volume_usd,
    COUNT(*)                          AS num_trades,
    approx_distinct(trader_id)        AS unique_traders
FROM dex_solana.trades
WHERE block_date >= DATE '2025-09-01'
  AND (
      token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
      OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
  )
GROUP BY 1
ORDER BY day DESC
