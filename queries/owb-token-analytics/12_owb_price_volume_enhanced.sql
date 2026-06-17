-- =====================================================================
-- OWB Token Analytics - Query 12: Enhanced Price & Volume
-- Daily VWAP with 7d/30d MAs, High/Low range, volume by DEX
-- Uses dex.trades (Spellbook) for accurate volume
-- =====================================================================

WITH daily_dex AS (
    SELECT
        date_trunc('day', block_time) AS day,
        project AS dex_source,
        COUNT(*) AS trade_count,
        COUNT(DISTINCT tx_from) AS unique_traders,
        SUM(amount_usd) AS volume_usd,
        -- VWAP calculation
        SUM(amount_usd) / NULLIF(
            SUM(
                CASE
                    WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
                    THEN CAST(token_bought_amount AS DOUBLE) / 1e18
                    WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
                    THEN CAST(token_sold_amount AS DOUBLE) / 1e18
                    ELSE 0
                END
            ), 0
        ) AS vwap_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1, 2
),

daily_agg AS (
    SELECT
        day,
        SUM(trade_count) AS total_trades,
        SUM(unique_traders) AS total_traders,
        SUM(volume_usd) AS total_volume,
        -- Weighted VWAP across all DEXes
        SUM(volume_usd) / NULLIF(SUM(volume_usd / NULLIF(vwap_usd, 0)), 0) AS daily_vwap,
        MAX(vwap_usd) AS high_price,
        MIN(CASE WHEN vwap_usd > 0 THEN vwap_usd END) AS low_price,
        -- Per-DEX volume
        SUM(CASE WHEN dex_source = 'aerodrome' THEN volume_usd ELSE 0 END) AS aerodrome_vol,
        SUM(CASE WHEN dex_source = 'uniswap' THEN volume_usd ELSE 0 END) AS uniswap_vol,
        SUM(CASE WHEN dex_source NOT IN ('aerodrome', 'uniswap') THEN volume_usd ELSE 0 END) AS other_vol
    FROM daily_dex
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    ROUND(COALESCE(da.daily_vwap, 0), 6) AS "VWAP (USD)",
    ROUND(COALESCE(da.high_price, 0), 6) AS "High",
    ROUND(COALESCE(da.low_price, 0), 6) AS "Low",
    COALESCE(da.total_trades, 0) AS "Trades",
    COALESCE(da.total_traders, 0) AS "Unique Traders",
    ROUND(COALESCE(da.total_volume, 0), 2) AS "Volume (USD)",
    ROUND(COALESCE(da.aerodrome_vol, 0), 2) AS "Aerodrome Volume",
    ROUND(COALESCE(da.uniswap_vol, 0), 2) AS "Uniswap Volume",
    ROUND(COALESCE(da.other_vol, 0), 2) AS "Other DEX Volume",
    -- Moving Averages
    ROUND(AVG(da.daily_vwap) OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 6) AS "Price 7d MA",
    ROUND(AVG(da.daily_vwap) OVER (ORDER BY ds.day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW), 6) AS "Price 30d MA",
    ROUND(AVG(COALESCE(da.total_volume, 0)) OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS "Volume 7d MA",
    -- Cumulative volume
    SUM(COALESCE(da.total_volume, 0)) OVER (ORDER BY ds.day) AS "Cumulative Volume",
    -- Cumulative traders
    SUM(COALESCE(da.total_traders, 0)) OVER (ORDER BY ds.day) AS "Cumulative Traders (Approx)"
FROM date_spine ds
LEFT JOIN daily_agg da ON ds.day = da.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
