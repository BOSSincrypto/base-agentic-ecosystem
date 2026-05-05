-- Section 6: Beezie Deep Dive — NFT Activity on Base
-- Tracks mints, burns, transfers + secondary market volume
-- NFT Contract: 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f (ERC-721)
--
-- Save as: "Beezie — NFT Activity & Volume (V1)"

-- ============================================================
-- NFT Transfer events (mints/burns/transfers)
-- ============================================================
WITH nft_events AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        tx_hash,
        CASE
            WHEN topic1 = 0x0000000000000000000000000000000000000000000000000000000000000000
            THEN 'mint'
            WHEN topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000
            THEN 'burn'
            ELSE 'transfer'
        END AS event_type,
        VARBINARY_SUBSTRING(topic1, 13, 20) AS from_addr,
        VARBINARY_SUBSTRING(topic2, 13, 20) AS to_addr
    FROM base.logs
    WHERE contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND block_time >= TIMESTAMP '2026-01-01'
),

weekly_events AS (
    SELECT
        week,
        COUNT(*) AS total_events,
        COUNT(CASE WHEN event_type = 'mint' THEN 1 END) AS mints,
        COUNT(CASE WHEN event_type = 'burn' THEN 1 END) AS burns,
        COUNT(CASE WHEN event_type = 'transfer' THEN 1 END) AS transfers,
        COUNT(DISTINCT to_addr) AS unique_receivers
    FROM nft_events
    GROUP BY 1
),

-- ============================================================
-- Secondary market volume from nft.trades
-- ============================================================
weekly_trades AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        COUNT(*) AS secondary_trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS secondary_volume_usd,
        COUNT(DISTINCT buyer) AS unique_buyers,
        COUNT(DISTINCT seller) AS unique_sellers,
        ROUND(AVG(COALESCE(amount_usd, 0)), 2) AS avg_trade_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= TIMESTAMP '2026-01-01'
    GROUP BY 1
)

SELECT
    COALESCE(e.week, t.week) AS "Week",
    COALESCE(e.mints, 0) AS "Mints",
    COALESCE(e.burns, 0) AS "Burns",
    COALESCE(e.transfers, 0) AS "Transfers",
    COALESCE(e.unique_receivers, 0) AS "Unique Receivers",
    COALESCE(t.secondary_trades, 0) AS "Secondary Trades",
    COALESCE(t.secondary_volume_usd, 0) AS "Secondary Volume USD",
    COALESCE(t.unique_buyers, 0) AS "Unique Buyers",
    COALESCE(t.unique_sellers, 0) AS "Unique Sellers",
    COALESCE(t.avg_trade_usd, 0) AS "Avg Trade USD",
    SUM(COALESCE(e.mints, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Mints",
    SUM(COALESCE(t.secondary_volume_usd, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Volume USD"
FROM weekly_events e
FULL OUTER JOIN weekly_trades t ON e.week = t.week
WHERE COALESCE(e.week, t.week) < DATE_TRUNC('week', now())
ORDER BY 1
