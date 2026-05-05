-- Section 6: Collector Crypt — CARDS token trading on Solana
-- Token: CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp
-- Source: dex_solana.trades (NOT dex.trades with blockchain filter)
--
-- Save as: "Collector Crypt — CARDS Token Trading (V1)"

WITH weekly_trading AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        COUNT(*) AS trades,
        COUNT(DISTINCT trader_id) AS unique_traders,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        ROUND(AVG(COALESCE(amount_usd, 0)), 2) AS avg_trade_usd,
        COUNT(CASE WHEN token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp' THEN 1 END) AS buys,
        COUNT(CASE WHEN token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp' THEN 1 END) AS sells
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= TIMESTAMP '2025-08-01'
    GROUP BY 1
)

SELECT
    week AS "Week",
    trades AS "Total Trades",
    unique_traders AS "Unique Traders",
    volume_usd AS "Volume USD",
    avg_trade_usd AS "Avg Trade USD",
    buys AS "Buys",
    sells AS "Sells",
    ROUND(CAST(buys AS DOUBLE) / NULLIF(sells, 0), 2) AS "Buy/Sell Ratio",
    SUM(volume_usd) OVER (ORDER BY week) AS "Cumulative Volume USD",
    SUM(trades) OVER (ORDER BY week) AS "Cumulative Trades"
FROM weekly_trading
WHERE week < DATE_TRUNC('week', now())
ORDER BY 1
