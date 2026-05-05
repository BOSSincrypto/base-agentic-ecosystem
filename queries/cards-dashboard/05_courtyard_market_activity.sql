-- Section 6: Courtyard — NFT Activity on Polygon
-- Tracks mints, burns, secondary trades, holder growth
-- NFT Contract: 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD (ERC-721)
--
-- Save as: "Courtyard — Market Activity (V1)"

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
        VARBINARY_SUBSTRING(topic2, 13, 20) AS to_addr
    FROM polygon.logs
    WHERE contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND block_time >= TIMESTAMP '2025-01-01'
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
-- Secondary market from nft.trades (OpenSea + others)
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
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= TIMESTAMP '2025-01-01'
    GROUP BY 1
),

-- ============================================================
-- Holder growth (new holders per week)
-- ============================================================
first_receive AS (
    SELECT
        VARBINARY_SUBSTRING(topic2, 13, 20) AS holder,
        MIN(DATE_TRUNC('week', block_time)) AS first_week
    FROM polygon.logs
    WHERE contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND topic2 != 0x0000000000000000000000000000000000000000000000000000000000000000
    GROUP BY 1
),

new_holders AS (
    SELECT
        first_week AS week,
        COUNT(*) AS new_holders
    FROM first_receive
    GROUP BY 1
)

SELECT
    COALESCE(e.week, t.week) AS "Week",
    COALESCE(e.mints, 0) AS "Mints",
    COALESCE(e.burns, 0) AS "Burns",
    COALESCE(e.transfers, 0) AS "Transfers",
    COALESCE(t.secondary_trades, 0) AS "Secondary Trades",
    COALESCE(t.secondary_volume_usd, 0) AS "Secondary Volume USD",
    COALESCE(t.unique_buyers, 0) AS "Unique Buyers",
    COALESCE(t.avg_trade_usd, 0) AS "Avg Trade USD",
    COALESCE(h.new_holders, 0) AS "New Holders",
    SUM(COALESCE(h.new_holders, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Holders",
    SUM(COALESCE(t.secondary_volume_usd, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Volume USD"
FROM weekly_events e
FULL OUTER JOIN weekly_trades t ON e.week = t.week
LEFT JOIN new_holders h ON COALESCE(e.week, t.week) = h.week
WHERE COALESCE(e.week, t.week) < DATE_TRUNC('week', now())
ORDER BY 1
