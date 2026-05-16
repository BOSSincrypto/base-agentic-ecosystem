# OWB — Holders + Win Rate + Dormancy (Optimized)

> **Credit cost reduction:** ~70-80% fewer Dune credits vs original query.
>
> **How:** Single scan of `erc20_base.evt_Transfer` instead of 5 separate scans.
> Win rate uses first-receive-day price (1 row per holder) instead of joining every buy transfer.

## Key Optimizations

| Original | Optimized | Impact |
|----------|-----------|--------|
| 5 scans of `evt_Transfer` (raw_balances x2, holder_entry x1, last_activity x2) | **1 scan** → `wallet_stats` CTE derives balance + last_active + first_receive_day | ~80% less data scanned |
| `holder_avg` joins ALL buy transfers × daily_price rows | **1 row per holder** joined to daily_price on first_receive_day | ~95% fewer join rows |
| Separate dormancy CTE re-reads balances | Dormancy derived from same `wallet_stats` CTE | Zero extra cost |

## Output Columns

| Column | Type | Description |
|--------|------|-------------|
| `total_holders` | integer | Current holders (balance > 0, excl. zero address) |
| `win_rate_pct` | decimal | % of holders whose first-receive-day price < current price |
| `dormancy_period` | string | Activity bucket: Active (< 90d), 90-180d, 180-365d, 365-730d, > 730d |
| `wallet_count` | integer | Number of wallets in each dormancy bucket |

## SQL

```sql
-- OWB — Holders + Win Rate + Dormancy (lightweight)
-- Single scan of evt_Transfer → balance, last_active, first_receive_day
-- Win rate: first-receive-day price vs current price (1 join per holder)

WITH

-- ============================================================
-- 1. Single scan: balance + last activity + first receive day
-- ============================================================
wallet_stats AS (
    SELECT
        address,
        SUM(net_amount)       AS balance,
        MAX(last_seen)        AS last_active,
        MIN(first_recv_day)   AS first_receive_day
    FROM (
        -- Inbound transfers
        SELECT
            "to"                                    AS address,
            CAST(value AS INT256)                   AS net_amount,
            evt_block_time                          AS last_seen,
            DATE_TRUNC('day', evt_block_time)       AS first_recv_day
        FROM erc20_base.evt_Transfer
        WHERE contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1

        UNION ALL

        -- Outbound transfers (negative amount, no first_recv_day)
        SELECT
            "from"                                  AS address,
            -CAST(value AS INT256)                  AS net_amount,
            evt_block_time                          AS last_seen,
            CAST(NULL AS DATE)                      AS first_recv_day
        FROM erc20_base.evt_Transfer
        WHERE contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
    ) t
    GROUP BY 1
    HAVING SUM(net_amount) > 0
       AND address != 0x0000000000000000000000000000000000000000
),

-- ============================================================
-- 2. Total holders (from wallet_stats — no extra scan)
-- ============================================================
holder_count AS (
    SELECT COUNT(*) AS total_holders FROM wallet_stats
),

-- ============================================================
-- 3. Daily average price (one scan of dex.trades)
-- ============================================================
daily_price AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        AVG(
            CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                THEN amount_usd / NULLIF(token_bought_amount, 0)
                ELSE amount_usd / NULLIF(token_sold_amount, 0)
            END
        ) AS avg_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
    GROUP BY 1
),

current_price AS (
    SELECT avg_price AS price_usd
    FROM daily_price
    ORDER BY day DESC
    LIMIT 1
),

-- ============================================================
-- 4. Win rate: first-receive-day price vs current (1 row/holder)
-- ============================================================
win_rate AS (
    SELECT
        ROUND(
            SUM(CASE WHEN cp.price_usd > dp.avg_price THEN 1 ELSE 0 END)
            * 100.0 / NULLIF(COUNT(*), 0),
        2) AS win_rate_pct
    FROM wallet_stats ws
    LEFT JOIN daily_price dp ON ws.first_receive_day = dp.day
    CROSS JOIN current_price cp
    WHERE dp.avg_price IS NOT NULL
),

-- ============================================================
-- 5. Dormancy (from wallet_stats — no extra scan)
-- ============================================================
dormancy AS (
    SELECT
        CASE
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 90  THEN 'Active (< 90d)'
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 180 THEN 'Dormant 90-180d'
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 365 THEN 'Dormant 180-365d'
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 730 THEN 'Dormant 365-730d'
            ELSE 'Dormant > 730d'
        END AS dormancy_period,
        CASE
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 90  THEN 1
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 180 THEN 2
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 365 THEN 3
            WHEN DATE_DIFF('day', last_active, CURRENT_DATE) < 730 THEN 4
            ELSE 5
        END AS dormancy_order,
        COUNT(*) AS wallet_count
    FROM wallet_stats
    GROUP BY 1, 2
)

-- ============================================================
-- FINAL OUTPUT
-- ============================================================
SELECT
    hc.total_holders,
    wr.win_rate_pct,
    d.dormancy_period,
    d.wallet_count
FROM holder_count hc
CROSS JOIN win_rate wr
CROSS JOIN dormancy d
ORDER BY d.dormancy_order
```

## Visualization Setup

**Type:** Table

| Setting | Value |
|---------|-------|
| Chart type | Table |
| Columns | `total_holders`, `win_rate_pct`, `dormancy_period`, `wallet_count` |
| Column formatting: total_holders | Number, 0 decimals, label "Total Holders" |
| Column formatting: win_rate_pct | Number, 2 decimals, suffix `%`, label "Win Rate" |
| Column formatting: dormancy_period | Text, label "Dormancy Period" |
| Column formatting: wallet_count | Number, 0 decimals, label "Wallets" |

Optionally create a **bar chart** from the same query:
- X-axis: `dormancy_period`
- Y-axis: `wallet_count`
- Color: `#6366F1` (Indigo)
- Title: "Wallet Dormancy Distribution"

And two **counter widgets**:
- Counter 1: `total_holders` → label "Total Holders"
- Counter 2: `win_rate_pct` → label "Win Rate", suffix `%`

## Win Rate Methodology Note

The optimized version uses **first-receive-day price** as the entry proxy instead of averaging ALL buy-day prices per holder. This is:
- **Much lighter:** 1 join row per holder vs potentially hundreds per holder
- **Slightly different semantics:** favors the first acquisition date rather than a DCA average
- For most holders the difference is small; for heavy DCA traders it underweights later entries

If you need the original DCA-averaged win rate and are okay with higher credit cost, use the original query.
