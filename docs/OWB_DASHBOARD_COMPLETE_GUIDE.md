# OWB Token Analytics Dashboard - Complete Guide

> **Dashboard name:** `OWB Token Analytics - Base | OneWayBlock`
> **URL:** https://dune.com/bossincrypto/owb-token-analytics-base-onewayblock
> **Chain:** Base mainnet
> **Engine:** DuneSQL (Trino)

---

## KEY ADDRESSES

| Entity | Address | Notes |
|--------|---------|-------|
| **OWB Token** | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | ERC-20 on Base |
| **USDC (Base)** | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` | Quote token |
| **Aerodrome Pool** | `0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD` | OWB/USDC |
| **Uniswap V3 Pool (0.01%)** | `0xf252f51919dfca2c9c0ea279f11183580edee4d6` | OWB/USDC, 100% locked LP |
| **vOWB Token** | `0xd5590f6cecef03b796fd904541727c2fe6346c06` | In-game reward token (verify) |
| **NFT Contract** | `0x94b3a7eb32685e79b4566600fe92ecd14e430970` | Clash of Coins NFTs (verify) |

**Token parameters:**
- Total Supply: 1,000,000,000 OWB
- Circulating Supply: ~142,500,272 OWB (~14.25%)

---

## COLOR PALETTE

| Element | Color | HEX |
|---------|-------|-----|
| Primary / OWB Brand | Indigo | `#6366F1` |
| Volume / Money | Amber | `#F59E0B` |
| Growth / Positive | Green | `#10B981` |
| Decline / Negative | Red | `#EF4444` |
| Buy Side | Emerald | `#22C55E` |
| Sell Side | Rose | `#F43F5E` |
| Uniswap | Pink | `#FF007A` |
| Aerodrome | Blue | `#0052FF` |
| Cumulative Lines | Dark Indigo | `#4338CA` |
| Secondary / Neutral | Gray | `#6B7280` |
| New Traders | Cyan | `#06B6D4` |
| Returning Traders | Violet | `#8B5CF6` |

---

## DASHBOARD LAYOUT MAP

```
ROW 1:   [TEXT WIDGET - HEADER] (full width, 12 cols)
         Title + description + links

ROW 2:   [6 KPI COUNTERS from Query 1] (2 cols each)
         | Price | Market Cap | 24h Volume | 7d Volume | Total Swaps | Unique Traders |

ROW 3:   [TEXT - "Price & Volume Dynamics"] (full width)

ROW 4:   [CHART - Price + MAs from Query 2] (8 cols)      [CHART - Daily Volume Bars from Query 2] (4 cols)

ROW 5:   [CHART - Price + Volume Combined from Query 2] (full width, dual Y-axis)

ROW 6:   [TEXT - "DEX Trading Activity"] (full width)

ROW 7:   [CHART - Volume by DEX from Query 3] (6 cols)    [CHART - Buy vs Sell from Query 4] (6 cols)

ROW 8:   [CHART - Trade Size Dist. from Query 5] (6 cols) [TABLE - Hourly Heatmap from Query 6] (6 cols)

ROW 9:   [TEXT - "Trader Intelligence"] (full width)

ROW 10:  [CHART - New vs Returning from Query 7] (8 cols) [CHART - Trader Cohorts Pie from Query 9] (4 cols)

ROW 11:  [CHART - Cumul. Unique Traders from Q7] (full width)

ROW 12:  [TABLE - Top 50 Traders from Query 8] (full width)

ROW 13:  [TEXT - "Liquidity & Pool Health"] (full width)

ROW 14:  [CHART - TVL Trends from Query 10] (6 cols)      [CHART - Pool Reserves from Query 10] (6 cols)

ROW 15:  [TEXT - "Holder Analytics"] (full width)

ROW 16:  [CHART - Holder Growth from Query 11] (8 cols)   [CHART - Holder Tiers Pie from Q12] (4 cols)

ROW 17:  [TABLE - Top 25 Holders from Query 13] (full width)

ROW 18:  [TEXT - "Token Flows & Whale Tracking"] (full width)

ROW 19:  [CHART - Net Flow from Query 15] (6 cols)        [CHART - Accum/Distrib from Q15] (6 cols)

ROW 20:  [TABLE - Large Transfers from Query 14] (full width)

ROW 21:  [TEXT - "Market Dynamics & Technical Signals"] (full width)

ROW 22:  [CHART - MAs + Price from Query 16] (8 cols)     [CHART - Volatility from Query 16] (4 cols)

ROW 23:  [TABLE - Weekly Performance from Query 17] (full width)

ROW 24:  [TEXT WIDGET - FOOTER] (full width)
         Methodology + data sources + disclaimers
```

---

## TEXT WIDGETS (Markdown)

---

### Widget 1: Dashboard Header (ROW 1)

**How:** Edit dashboard -> Add text widget -> paste below -> stretch to 12 columns.

```markdown
# OWB Token Analytics - Deep Dive | Base Chain

**A comprehensive on-chain analytics dashboard for the OWB token (Clash of Coins / OneWayBlock) on Base.** Every metric is derived from verifiable on-chain data via Dune Analytics. No off-chain assumptions, no trust required.

**What this dashboard answers:**
- What is the real trading activity and liquidity health of OWB?
- Who is trading? How concentrated? Are traders sticky or one-time?
- Where does the liquidity sit and how efficiently is it used?
- Is OWB accumulating or distributing? What do whale flows signal?
- What is the market momentum and volatility regime?

**Tracked pools:** Aerodrome OWB/USDC + Uniswap V3 OWB/USDC (0.01% fee, 100% locked LP)

> OWB contract: [0xEF5997c2cf2f6c138196f8a6203afc335206b3c1](https://basescan.org/token/0xef5997c2cf2f6c138196f8a6203afc335206b3c1) | Total Supply: 1B | Circulating: ~142.5M (~14.25%)
>
> Data: Base mainnet on-chain | Source: dex.trades + tokens.transfers (Dune Spellbook)
```

---

### Widget 2: Section - Price & Volume Dynamics (ROW 3)

```markdown
---

## Price & Volume Dynamics

Daily VWAP (volume-weighted average price) with 7-day and 30-day moving averages. Volume breakdown by DEX source. All prices derived from actual on-chain trade executions across all OWB liquidity pools on Base.
```

---

### Widget 3: Section - DEX Trading Activity (ROW 6)

```markdown
---

## DEX Trading Activity

How is OWB traded? Volume split across DEXes, buy vs sell pressure, trade size distribution, and time-of-day patterns. Direction is defined from the trader's perspective: "Buy" = trader acquires OWB, "Sell" = trader disposes of OWB.
```

---

### Widget 4: Section - Trader Intelligence (ROW 9)

```markdown
---

## Trader Intelligence

Who trades OWB? New vs returning traders, activity cohorts, and the top 50 traders by volume. "New" = first-ever OWB trade on that day. "Returning" = has traded OWB before. `tx_from` is used for accurate unique user counts (excludes router contracts).
```

---

### Widget 5: Section - Liquidity & Pool Health (ROW 13)

```markdown
---

## Liquidity & Pool Health

Total Value Locked across both primary pools (Aerodrome + Uniswap V3). Reserves are reconstructed from all ERC-20 transfers to/from pool contracts since creation. TVL = USDC reserves + (OWB reserves x VWAP price).
```

---

### Widget 6: Section - Holder Analytics (ROW 15)

```markdown
---

## Holder Analytics

Holder growth, distribution by balance tiers, and concentration analysis. Current holders are computed from net token flows (all inbound transfers minus all outbound). Addresses with balance > 0 OWB are counted as holders.
```

---

### Widget 7: Section - Token Flows & Whale Tracking (ROW 18)

```markdown
---

## Token Flows & Whale Tracking

Net flow = DEX outflow (buying) minus DEX inflow (selling). Positive net flow = accumulation (more OWB leaving DEX to wallets). Negative = distribution (more OWB being sold into DEX). Large transfers = 100K+ OWB movements.
```

---

### Widget 8: Section - Market Dynamics (ROW 21)

```markdown
---

## Market Dynamics & Technical Signals

Moving averages, annualized volatility, daily range, and a simplified momentum oscillator (% of up-days in a 14-day window). These are purely descriptive on-chain-derived signals, not trading recommendations.
```

---

### Widget 9: Footer (ROW 24)

```markdown
---

### Methodology & Data Sources

**Data source:** All metrics use Base mainnet on-chain data via Dune Analytics (DuneSQL / Trino). DEX trades from `dex.trades` (Dune Spellbook - pre-decoded, human-readable amounts). Token transfers from `tokens.transfers`. No off-chain data, no API estimates.

**Price methodology:** Volume-Weighted Average Price (VWAP) derived from all OWB trades across all Base DEX pools. High/Low are the max/min execution prices per day.

**Holder calculation:** Net balance from all ERC-20 transfers (inbound minus outbound). Addresses with balance > 0 counted as current holders. Includes DEX pools, contracts, and EOAs.

**Trader identification:** Uses `tx_from` (transaction signer) rather than `taker` to avoid counting router contracts as users.

**Tracked pools:**
| Pool | DEX | Address |
|------|-----|---------|
| OWB/USDC | Aerodrome | `0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD` |
| OWB/USDC (0.01%) | Uniswap V3 | `0xf252f51919dfca2c9c0ea279f11183580edee4d6` |

**Known limitations:**
- Circulating supply is approximate (~142.5M as of Feb 2026). Market Cap and FDV use this estimate.
- "Holders" includes smart contracts, pools, and potentially dead addresses.
- Volume may include MEV/sandwich bot activity which inflates swap counts.
- Off-chain card payments and in-game transactions are not captured.

> Built with on-chain data, not narratives. OWB: [BaseScan](https://basescan.org/token/0xef5997c2cf2f6c138196f8a6203afc335206b3c1) | Game: [OneWayBlock](https://onewayblock.com)
```

---

---

# QUERIES

---

## Query 1: OWB - Overview KPIs

### Purpose
Single row with all key metrics for counter widgets: current price, FDV, market cap, volume (24h/7d/30d), total swaps, unique traders, 24h traders.

### Save as
`OWB - Overview KPIs`

### SQL

```sql
-- OWB Overview KPI Counters
-- Powers 6-8 counter widgets at the top of the dashboard
-- Uses tx_from for accurate unique user count (not taker/router)

WITH all_trades AS (
    SELECT
        block_time,
        amount_usd,
        tx_from,
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND token_bought_amount > 0
            THEN amount_usd / token_bought_amount
            WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND token_sold_amount > 0
            THEN amount_usd / token_sold_amount
            ELSE NULL
        END AS price_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
),

latest_price AS (
    SELECT price_usd
    FROM all_trades
    WHERE price_usd IS NOT NULL
    ORDER BY block_time DESC
    LIMIT 1
),

volume_metrics AS (
    SELECT
        ROUND(SUM(amount_usd), 2) AS total_volume_all_time,
        ROUND(SUM(CASE WHEN block_time >= NOW() - INTERVAL '24' HOUR THEN amount_usd ELSE 0 END), 2) AS volume_24h,
        ROUND(SUM(CASE WHEN block_time >= NOW() - INTERVAL '7' DAY THEN amount_usd ELSE 0 END), 2) AS volume_7d,
        ROUND(SUM(CASE WHEN block_time >= NOW() - INTERVAL '30' DAY THEN amount_usd ELSE 0 END), 2) AS volume_30d,
        COUNT(*) AS total_swaps,
        COUNT(DISTINCT tx_from) AS total_unique_traders,
        COUNT(DISTINCT CASE WHEN block_time >= NOW() - INTERVAL '24' HOUR THEN tx_from END) AS traders_24h,
        COUNT(DISTINCT CASE WHEN block_time >= NOW() - INTERVAL '7' DAY THEN tx_from END) AS traders_7d
    FROM all_trades
),

price_change AS (
    SELECT
        -- Price 24h ago
        (SELECT price_usd FROM all_trades WHERE price_usd IS NOT NULL ORDER BY block_time DESC LIMIT 1)
        /
        NULLIF((SELECT price_usd FROM all_trades
                WHERE price_usd IS NOT NULL
                  AND block_time <= NOW() - INTERVAL '24' HOUR
                ORDER BY block_time DESC LIMIT 1), 0)
        - 1 AS price_change_24h,
        -- Price 7d ago
        (SELECT price_usd FROM all_trades WHERE price_usd IS NOT NULL ORDER BY block_time DESC LIMIT 1)
        /
        NULLIF((SELECT price_usd FROM all_trades
                WHERE price_usd IS NOT NULL
                  AND block_time <= NOW() - INTERVAL '7' DAY
                ORDER BY block_time DESC LIMIT 1), 0)
        - 1 AS price_change_7d
)

SELECT
    ROUND(p.price_usd, 6) AS current_price,
    ROUND(p.price_usd * 1e9, 0) AS fdv,
    ROUND(p.price_usd * 142500272, 0) AS market_cap,
    v.volume_24h,
    v.volume_7d,
    v.volume_30d,
    v.total_volume_all_time,
    v.total_swaps,
    v.total_unique_traders,
    v.traders_24h,
    v.traders_7d,
    ROUND(COALESCE(pc.price_change_24h, 0) * 100, 2) AS price_change_24h_pct,
    ROUND(COALESCE(pc.price_change_7d, 0) * 100, 2) AS price_change_7d_pct
FROM latest_price p
CROSS JOIN volume_metrics v
CROSS JOIN price_change pc
```

### Visualization Setup

Create **8 counter widgets** from this single query:

| Counter | Column | Prefix | Suffix | Label | Decimals |
|---------|--------|--------|--------|-------|----------|
| 1 | `current_price` | `$` | | Current Price | 6 |
| 2 | `market_cap` | `$` | | Market Cap | 0 |
| 3 | `volume_24h` | `$` | | 24h Volume | 0 |
| 4 | `volume_7d` | `$` | | 7d Volume | 0 |
| 5 | `total_swaps` | | | Total Swaps (All Time) | 0 |
| 6 | `total_unique_traders` | | | Unique Traders (All Time) | 0 |
| 7 | `price_change_24h_pct` | | `%` | 24h Price Change | 2 |
| 8 | `price_change_7d_pct` | | `%` | 7d Price Change | 2 |

**Layout:** ROW 2, each counter 1.5 columns wide (or 2 cols for 6 counters).

---

## Query 2: OWB - Daily Price & Volume

### Purpose
Time series: daily VWAP, high/low, volume, swaps, unique traders, 7d/30d moving averages, cumulative volume.

### Save as
`OWB - Daily Price & Volume`

### SQL

```sql
-- OWB Daily Price & Volume Time Series
-- VWAP + High/Low + Volume + Moving Averages
-- 180-day lookback

WITH daily_data AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        COUNT(*) AS swaps,
        COUNT(DISTINCT tx_from) AS unique_traders,
        ROUND(SUM(amount_usd), 2) AS volume_usd,
        -- VWAP: total USD / total OWB transacted
        SUM(amount_usd) / NULLIF(
            SUM(
                CASE
                    WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_bought_amount
                    WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_sold_amount
                    ELSE 0
                END
            ), 0
        ) AS vwap_price,
        -- Daily High
        MAX(
            CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_bought_amount > 0
                THEN amount_usd / token_bought_amount
                WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_sold_amount > 0
                THEN amount_usd / token_sold_amount
            END
        ) AS high_price,
        -- Daily Low
        MIN(
            CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_bought_amount > 0
                THEN amount_usd / token_bought_amount
                WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_sold_amount > 0
                THEN amount_usd / token_sold_amount
            END
        ) AS low_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
      AND block_time >= NOW() - INTERVAL '180' DAY
    GROUP BY 1
)

SELECT
    day,
    swaps,
    unique_traders,
    volume_usd,
    ROUND(vwap_price, 6) AS vwap_price,
    ROUND(high_price, 6) AS high_price,
    ROUND(low_price, 6) AS low_price,
    -- Cumulative volume
    ROUND(SUM(volume_usd) OVER (ORDER BY day), 2) AS cumulative_volume,
    -- 7-day moving averages
    ROUND(AVG(volume_usd) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS volume_7d_ma,
    ROUND(AVG(vwap_price) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 6) AS price_7d_ma,
    -- 30-day moving averages
    ROUND(AVG(volume_usd) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW), 2) AS volume_30d_ma,
    ROUND(AVG(vwap_price) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW), 6) AS price_30d_ma,
    -- 7-day moving average of traders
    ROUND(AVG(unique_traders) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS traders_7d_ma
FROM daily_data
ORDER BY day
```

### Visualization Setup

**Chart A: Price + Moving Averages** (ROW 4, left 8 cols)
- Type: **Line Chart**
- X-axis: `day`
- Y-axis: `vwap_price` (line, color `#6366F1`), `price_7d_ma` (line, dashed, `#F59E0B`), `price_30d_ma` (line, dashed, `#EF4444`)
- Title: `OWB Price (VWAP) with 7d & 30d Moving Averages`
- Y-axis label format: `$0.0000`

**Chart B: Daily Volume Bars** (ROW 4, right 4 cols)
- Type: **Bar Chart**
- X-axis: `day`
- Y-axis: `volume_usd` (bar, color `#F59E0B`), `volume_7d_ma` (line overlay, color `#6366F1`)
- Title: `Daily Trading Volume (USD)`
- Y-axis label format: `$0.0a`

**Chart C: Price + Volume Combined** (ROW 5, full width)
- Type: **Mixed** (Line + Bar)
- X-axis: `day`
- Left Y-axis: `vwap_price` (line, `#6366F1`)
- Right Y-axis: `volume_usd` (bar, `#F59E0B`, opacity 0.5)
- Enable right Y-axis: YES
- Title: `OWB Price vs Volume`

---

## Query 3: OWB - Volume by DEX

### Purpose
Daily volume split by DEX source (Aerodrome, Uniswap, others). Shows which venue captures most flow.

### Save as
`OWB - Volume by DEX`

### SQL

```sql
-- OWB Volume Breakdown by DEX
-- Stacked by DEX source, 90-day lookback

SELECT
    DATE_TRUNC('day', block_time) AS day,
    CASE
        WHEN project = 'aerodrome' THEN 'Aerodrome'
        WHEN project = 'uniswap' AND version = '3' THEN 'Uniswap V3'
        WHEN project = 'uniswap' AND version = '4' THEN 'Uniswap V4'
        WHEN project = 'kyberswap' THEN 'KyberSwap'
        ELSE COALESCE(project, 'Other')
    END AS dex_name,
    COUNT(*) AS swaps,
    ROUND(SUM(amount_usd), 2) AS volume_usd,
    COUNT(DISTINCT tx_from) AS unique_traders
FROM dex.trades
WHERE blockchain = 'base'
  AND (
      token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
  )
  AND amount_usd > 0
  AND block_time >= NOW() - INTERVAL '90' DAY
GROUP BY 1, 2
ORDER BY 1, 4 DESC
```

### Visualization Setup

**Chart: Stacked Area - Volume by DEX** (ROW 7, left 6 cols)
- Type: **Area Chart** (stacked)
- X-axis: `day`
- Y-axis: `volume_usd`, grouped by `dex_name`
- Enable stacking: YES
- Colors: Aerodrome `#0052FF`, Uniswap V3 `#FF007A`, Uniswap V4 `#7C3AED`, KyberSwap `#F59E0B`, Other `#6B7280`
- Title: `Daily Volume by DEX`
- Y-axis format: `$0.0a`

**Also create Pie Chart** (optional, add below or as toggle):
- Type: **Pie Chart**
- Values: `volume_usd` (summed), labels: `dex_name`
- Title: `Volume Share by DEX (90d)`

---

## Query 4: OWB - Buy vs Sell Pressure

### Purpose
Daily buy volume vs sell volume, buy/sell ratio, net buy pressure. "Buy" = trader acquires OWB (token_bought = OWB).

### Save as
`OWB - Buy vs Sell Pressure`

### SQL

```sql
-- OWB Buy vs Sell Pressure Analysis
-- Direction from trader's perspective
-- 90-day lookback

WITH trades AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        amount_usd,
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN 'Buy'
            ELSE 'Sell'
        END AS direction,
        tx_from
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
      AND block_time >= NOW() - INTERVAL '90' DAY
)

SELECT
    day,
    ROUND(SUM(CASE WHEN direction = 'Buy' THEN amount_usd ELSE 0 END), 2) AS buy_volume,
    ROUND(SUM(CASE WHEN direction = 'Sell' THEN amount_usd ELSE 0 END), 2) AS sell_volume,
    COUNT(CASE WHEN direction = 'Buy' THEN 1 END) AS buy_count,
    COUNT(CASE WHEN direction = 'Sell' THEN 1 END) AS sell_count,
    ROUND(
        SUM(CASE WHEN direction = 'Buy' THEN amount_usd ELSE 0 END) /
        NULLIF(SUM(CASE WHEN direction = 'Sell' THEN amount_usd ELSE 0 END), 0),
    2) AS buy_sell_ratio,
    ROUND(
        SUM(CASE WHEN direction = 'Buy' THEN amount_usd ELSE 0 END) -
        SUM(CASE WHEN direction = 'Sell' THEN amount_usd ELSE 0 END),
    2) AS net_buy_pressure,
    COUNT(DISTINCT CASE WHEN direction = 'Buy' THEN tx_from END) AS unique_buyers,
    COUNT(DISTINCT CASE WHEN direction = 'Sell' THEN tx_from END) AS unique_sellers,
    -- 7d rolling net pressure
    ROUND(
        AVG(
            SUM(CASE WHEN direction = 'Buy' THEN amount_usd ELSE 0 END) -
            SUM(CASE WHEN direction = 'Sell' THEN amount_usd ELSE 0 END)
        ) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),
    2) AS net_pressure_7d_ma
FROM trades
GROUP BY 1
ORDER BY 1
```

### Visualization Setup

**Chart: Buy vs Sell Stacked Bars** (ROW 7, right 6 cols)
- Type: **Bar Chart** (stacked)
- X-axis: `day`
- Y-axis: `buy_volume` (bar, `#22C55E`), `sell_volume` (bar, `#F43F5E`)
- Overlay line: `net_buy_pressure` (line, `#6366F1`, right Y-axis)
- Enable right Y-axis: YES
- Title: `Buy vs Sell Volume (USD)`
- Y-axis format: `$0.0a`

---

## Query 5: OWB - Trade Size Distribution

### Purpose
Histogram of trade sizes over the last 30 days. Shows what % of trades and volume comes from each size bucket.

### Save as
`OWB - Trade Size Distribution`

### SQL

```sql
-- OWB Trade Size Distribution (30d)
-- Buckets: <$10, $10-100, $100-500, $500-1K, $1K-5K, $5K-10K, >$10K

WITH trades AS (
    SELECT
        amount_usd,
        CASE
            WHEN amount_usd < 10 THEN '< $10'
            WHEN amount_usd < 100 THEN '$10 - $100'
            WHEN amount_usd < 500 THEN '$100 - $500'
            WHEN amount_usd < 1000 THEN '$500 - $1K'
            WHEN amount_usd < 5000 THEN '$1K - $5K'
            WHEN amount_usd < 10000 THEN '$5K - $10K'
            ELSE '> $10K'
        END AS size_bucket,
        CASE
            WHEN amount_usd < 10 THEN 1
            WHEN amount_usd < 100 THEN 2
            WHEN amount_usd < 500 THEN 3
            WHEN amount_usd < 1000 THEN 4
            WHEN amount_usd < 5000 THEN 5
            WHEN amount_usd < 10000 THEN 6
            ELSE 7
        END AS bucket_order
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
      AND block_time >= NOW() - INTERVAL '30' DAY
)

SELECT
    size_bucket,
    bucket_order,
    COUNT(*) AS trade_count,
    ROUND(SUM(amount_usd), 2) AS total_volume,
    ROUND(AVG(amount_usd), 2) AS avg_trade_size,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_trades,
    ROUND(100.0 * SUM(amount_usd) / SUM(SUM(amount_usd)) OVER (), 2) AS pct_of_volume
FROM trades
GROUP BY 1, 2
ORDER BY bucket_order
```

### Visualization Setup

**Chart: Horizontal Bar - Trade Size Distribution** (ROW 8, left 6 cols)
- Type: **Bar Chart** (horizontal)
- X-axis: `size_bucket` (sorted by `bucket_order`)
- Y-axis 1: `pct_of_trades` (bar, `#6366F1`, label "% of Trades")
- Y-axis 2: `pct_of_volume` (bar, `#F59E0B`, label "% of Volume")
- Title: `Trade Size Distribution (30d)`
- Data labels: ON

---

## Query 6: OWB - Hourly Trading Heatmap

### Purpose
Trading activity by hour of day and day of week. Reveals when OWB is most actively traded (timezone patterns, bot activity windows).

### Save as
`OWB - Hourly Trading Heatmap`

### SQL

```sql
-- OWB Hourly Activity Heatmap (30d)
-- Rows: day of week, Columns: hour (UTC)

SELECT
    CASE EXTRACT(DOW FROM block_time)
        WHEN 0 THEN '7_Sun'
        WHEN 1 THEN '1_Mon'
        WHEN 2 THEN '2_Tue'
        WHEN 3 THEN '3_Wed'
        WHEN 4 THEN '4_Thu'
        WHEN 5 THEN '5_Fri'
        WHEN 6 THEN '6_Sat'
    END AS day_of_week,
    LPAD(CAST(EXTRACT(HOUR FROM block_time) AS VARCHAR), 2, '0') || ':00' AS hour_utc,
    COUNT(*) AS swaps,
    ROUND(SUM(amount_usd), 2) AS volume_usd,
    COUNT(DISTINCT tx_from) AS unique_traders
FROM dex.trades
WHERE blockchain = 'base'
  AND (
      token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
  )
  AND amount_usd > 0
  AND block_time >= NOW() - INTERVAL '30' DAY
GROUP BY 1, 2
ORDER BY 1, 2
```

### Visualization Setup

**Table: Heatmap-style** (ROW 8, right 6 cols)
- Type: **Table** with conditional formatting
- Display: pivot by `day_of_week` (rows) x `hour_utc` (columns) with `volume_usd` as values
- Title: `Trading Activity Heatmap (Volume USD, 30d)`
- NOTE: Dune's native table can show this. For heatmap effect, use conditional formatting on `volume_usd` (green = high, white = low). Alternatively, display as a **Scatter Chart** with `hour_utc` on X, `day_of_week` on Y, bubble size = `volume_usd`.

---

## Query 7: OWB - Trader Intelligence (New vs Returning)

### Purpose
Daily breakdown of new traders (first-ever OWB trade) vs returning traders. Shows trader stickiness and organic growth.

### Save as
`OWB - Trader Intelligence`

### SQL

```sql
-- OWB New vs Returning Traders (90d)
-- "New" = first-ever OWB trade that day
-- "Returning" = has traded OWB before

WITH first_trade AS (
    SELECT
        tx_from AS trader,
        MIN(DATE_TRUNC('day', block_time)) AS first_trade_day
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
    GROUP BY 1
),

daily_traders AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        t.tx_from AS trader,
        f.first_trade_day,
        t.amount_usd
    FROM dex.trades t
    JOIN first_trade f ON t.tx_from = f.trader
    WHERE t.blockchain = 'base'
      AND (
          t.token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR t.token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND t.amount_usd > 0
      AND t.block_time >= NOW() - INTERVAL '90' DAY
)

SELECT
    day,
    COUNT(DISTINCT trader) AS total_traders,
    COUNT(DISTINCT CASE WHEN day = first_trade_day THEN trader END) AS new_traders,
    COUNT(DISTINCT CASE WHEN day != first_trade_day THEN trader END) AS returning_traders,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN day != first_trade_day THEN trader END) /
        NULLIF(COUNT(DISTINCT trader), 0),
    1) AS returning_pct,
    ROUND(SUM(amount_usd), 2) AS total_volume,
    ROUND(SUM(CASE WHEN day = first_trade_day THEN amount_usd ELSE 0 END), 2) AS new_trader_volume,
    ROUND(SUM(CASE WHEN day != first_trade_day THEN amount_usd ELSE 0 END), 2) AS returning_trader_volume,
    SUM(COUNT(DISTINCT CASE WHEN day = first_trade_day THEN trader END)) OVER (ORDER BY day) AS cumulative_unique_traders
FROM daily_traders
GROUP BY 1
ORDER BY 1
```

### Visualization Setup

**Chart A: Stacked Bar - New vs Returning** (ROW 10, left 8 cols)
- Type: **Bar Chart** (stacked)
- X-axis: `day`
- Y-axis: `new_traders` (bar, `#06B6D4`), `returning_traders` (bar, `#8B5CF6`)
- Overlay: `returning_pct` as line on right Y-axis (`#F59E0B`)
- Enable right Y-axis: YES
- Title: `Daily Traders: New vs Returning`

**Chart B: Cumulative Unique Traders** (ROW 11, full width)
- Type: **Area Chart**
- X-axis: `day`
- Y-axis: `cumulative_unique_traders` (area, `#6366F1`, fill opacity 0.3)
- Title: `Cumulative Unique OWB Traders`

---

## Query 8: OWB - Top Traders Leaderboard

### Purpose
Top 50 traders by 30-day volume with their trading direction, frequency, and net position.

### Save as
`OWB - Top Traders`

### SQL

```sql
-- OWB Top 50 Traders by Volume (30d)
-- Shows buy/sell breakdown and net position direction

WITH trader_stats AS (
    SELECT
        tx_from AS trader,
        COUNT(*) AS total_trades,
        ROUND(SUM(amount_usd), 2) AS total_volume,
        ROUND(AVG(amount_usd), 2) AS avg_trade_size,
        MIN(block_time) AS first_trade,
        MAX(block_time) AS last_trade,
        COUNT(DISTINCT DATE_TRUNC('day', block_time)) AS active_days,
        ROUND(SUM(CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN amount_usd ELSE 0
        END), 2) AS buy_volume,
        ROUND(SUM(CASE
            WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN amount_usd ELSE 0
        END), 2) AS sell_volume
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
      AND block_time >= NOW() - INTERVAL '30' DAY
    GROUP BY 1
)

SELECT
    ROW_NUMBER() OVER (ORDER BY total_volume DESC) AS rank,
    trader,
    total_trades,
    total_volume,
    avg_trade_size,
    active_days,
    buy_volume,
    sell_volume,
    ROUND(buy_volume - sell_volume, 2) AS net_position_usd,
    CASE
        WHEN buy_volume > sell_volume * 1.1 THEN 'Net Buyer'
        WHEN sell_volume > buy_volume * 1.1 THEN 'Net Seller'
        ELSE 'Balanced'
    END AS position_type,
    ROUND(100.0 * total_volume / SUM(total_volume) OVER (), 2) AS pct_of_total_volume
FROM trader_stats
ORDER BY total_volume DESC
LIMIT 50
```

### Visualization Setup

**Table** (ROW 12, full width)
- Type: **Table**
- Columns to display: rank, trader (link to basescan), total_trades, total_volume ($), avg_trade_size ($), active_days, buy_volume ($), sell_volume ($), net_position_usd ($), position_type, pct_of_total_volume (%)
- Title: `Top 50 OWB Traders (30d)`
- Format `total_volume`, `buy_volume`, `sell_volume` with `$0,0`
- Conditional formatting: `position_type` green for "Net Buyer", red for "Net Seller"

---

## Query 9: OWB - Trader Cohort Analysis

### Purpose
Segments traders into activity cohorts. Shows what % of traders are one-time vs power users, and how volume concentrates.

### Save as
`OWB - Trader Cohorts`

### SQL

```sql
-- OWB Trader Cohort Distribution (90d)
-- Segments: One-time, Casual, Regular, Active, Power User

WITH trader_activity AS (
    SELECT
        tx_from AS trader,
        COUNT(*) AS trade_count,
        ROUND(SUM(amount_usd), 2) AS total_volume,
        COUNT(DISTINCT DATE_TRUNC('day', block_time)) AS active_days,
        MIN(block_time) AS first_trade,
        MAX(block_time) AS last_trade
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
      AND block_time >= NOW() - INTERVAL '90' DAY
    GROUP BY 1
),

cohorts AS (
    SELECT
        trader,
        trade_count,
        total_volume,
        active_days,
        CASE
            WHEN trade_count = 1 THEN 'One-time (1 trade)'
            WHEN trade_count <= 5 THEN 'Casual (2-5 trades)'
            WHEN trade_count <= 20 THEN 'Regular (6-20 trades)'
            WHEN trade_count <= 50 THEN 'Active (21-50 trades)'
            ELSE 'Power User (50+ trades)'
        END AS trader_cohort,
        CASE
            WHEN trade_count = 1 THEN 1
            WHEN trade_count <= 5 THEN 2
            WHEN trade_count <= 20 THEN 3
            WHEN trade_count <= 50 THEN 4
            ELSE 5
        END AS cohort_order
    FROM trader_activity
)

SELECT
    trader_cohort,
    cohort_order,
    COUNT(*) AS trader_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct_of_traders,
    ROUND(SUM(total_volume), 2) AS cohort_volume,
    ROUND(100.0 * SUM(total_volume) / SUM(SUM(total_volume)) OVER (), 1) AS pct_of_volume,
    ROUND(AVG(total_volume), 2) AS avg_volume_per_trader,
    ROUND(AVG(trade_count), 1) AS avg_trades_per_trader,
    ROUND(AVG(active_days), 1) AS avg_active_days
FROM cohorts
GROUP BY 1, 2
ORDER BY cohort_order
```

### Visualization Setup

**Chart: Pie - Traders by Cohort** (ROW 10, right 4 cols)
- Type: **Pie Chart**
- Values: `trader_count`, Labels: `trader_cohort`
- Colors: One-time `#EF4444`, Casual `#F59E0B`, Regular `#10B981`, Active `#6366F1`, Power User `#8B5CF6`
- Title: `Trader Distribution by Activity (90d)`

**Also create second Pie Chart below:**
- Values: `cohort_volume`, Labels: `trader_cohort`
- Same colors
- Title: `Volume Distribution by Trader Cohort (90d)`

---

## Query 10: OWB - Pool TVL & Reserves

### Purpose
Exact historical reserves for both pools (Aerodrome + Uniswap V3), reconstructed from all ERC-20 transfers. TVL = USDC + (OWB x price).

### Save as
`OWB - Pool TVL & Reserves`

### SQL

```sql
-- OWB Pool TVL & Reserves (both pools)
-- Reconstructed from all ERC-20 transfers to/from pools
-- Pools: Uniswap V3 (0xf252f5...) + Aerodrome (0x995985...)

WITH pool_flows AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        CASE
            WHEN "to" = 0xf252f51919dfca2c9c0ea279f11183580edee4d6
                 OR "from" = 0xf252f51919dfca2c9c0ea279f11183580edee4d6
            THEN 'Uniswap V3'
            ELSE 'Aerodrome'
        END AS pool,
        -- USDC in
        SUM(CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                 AND "to" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS usdc_in,
        -- USDC out
        SUM(CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                 AND "from" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS usdc_out,
        -- OWB in
        SUM(CASE
            WHEN contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND "to" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS owb_in,
        -- OWB out
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
            SUM(
                CASE
                    WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_bought_amount
                    WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_sold_amount
                    ELSE 0
                END
            ), 0
        ) AS owb_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
    GROUP BY 1
)

SELECT
    r.day,
    r.pool,
    ROUND(r.usdc_reserves, 2) AS usdc_in_pool,
    ROUND(r.owb_reserves, 0) AS owb_in_pool,
    ROUND(p.owb_price, 6) AS owb_price,
    ROUND(r.usdc_reserves + r.owb_reserves * COALESCE(p.owb_price, 0), 2) AS tvl_usd
FROM reserves r
LEFT JOIN daily_price p ON r.day = p.day
WHERE r.day >= NOW() - INTERVAL '180' DAY
ORDER BY r.day, r.pool
```

### Visualization Setup

**Chart A: TVL Trends** (ROW 14, left 6 cols)
- Type: **Area Chart** (stacked)
- X-axis: `day`
- Y-axis: `tvl_usd`, grouped by `pool`
- Enable stacking: YES
- Colors: Uniswap V3 `#FF007A`, Aerodrome `#0052FF`
- Title: `OWB Pool TVL (USD)`
- Y-axis format: `$0.0a`

**Chart B: Reserves Comparison** (ROW 14, right 6 cols)
- Create **two separate line charts** or a mixed chart:
- Line 1: `usdc_in_pool` by pool (USDC reserves)
- Line 2: `owb_in_pool` by pool (OWB reserves, right Y-axis)
- Title: `Pool Reserves: USDC + OWB`

---

## Query 11: OWB - Holder Growth

### Purpose
Daily new unique addresses receiving OWB for the first time + cumulative unique holders. Shows organic adoption curve.

### Save as
`OWB - Holder Growth`

### SQL

```sql
-- OWB Holder Growth (New + Cumulative)
-- "New holder" = first-ever OWB receipt on that day
-- 180-day display window

WITH first_received AS (
    SELECT
        "to" AS address,
        MIN(DATE_TRUNC('day', block_time)) AS first_day
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "to" != 0x0000000000000000000000000000000000000000
      AND amount > 0
    GROUP BY 1
),

daily_new AS (
    SELECT
        first_day AS day,
        COUNT(*) AS new_holders
    FROM first_received
    GROUP BY 1
)

SELECT
    day,
    new_holders,
    SUM(new_holders) OVER (ORDER BY day) AS cumulative_holders,
    ROUND(AVG(new_holders) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS new_holders_7d_ma
FROM daily_new
WHERE day >= NOW() - INTERVAL '180' DAY
ORDER BY day
```

### Visualization Setup

**Chart: Mixed - Holder Growth** (ROW 16, left 8 cols)
- Type: **Mixed** (Bar + Line)
- X-axis: `day`
- Left Y-axis: `new_holders` (bar, `#10B981`)
- Right Y-axis: `cumulative_holders` (line, `#4338CA`)
- Overlay: `new_holders_7d_ma` (dashed line, `#F59E0B`)
- Enable right Y-axis: YES
- Title: `OWB Holder Growth: New Addresses + Cumulative`

---

## Query 12: OWB - Holder Distribution by Balance Tiers

### Purpose
Current holder count and % of supply by balance tier. Shows concentration risk and whale dominance.

### Save as
`OWB - Holder Distribution`

### SQL

```sql
-- OWB Holder Distribution by Balance Tiers
-- Computes net balance from ALL transfers, counts holders with balance > 0
-- WARNING: This query may take 30-60 seconds due to full transfer history scan

WITH flows AS (
    SELECT "to" AS address, amount
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "to" != 0x0000000000000000000000000000000000000000

    UNION ALL

    SELECT "from" AS address, -amount
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "from" != 0x0000000000000000000000000000000000000000
),

balances AS (
    SELECT
        address,
        SUM(amount) AS balance
    FROM flows
    GROUP BY 1
    HAVING SUM(amount) > 0
),

total_supply_held AS (
    SELECT SUM(balance) AS total FROM balances
),

tiers AS (
    SELECT
        address,
        balance,
        CASE
            WHEN balance < 1000 THEN 'Dust (< 1K)'
            WHEN balance < 10000 THEN 'Small (1K - 10K)'
            WHEN balance < 100000 THEN 'Medium (10K - 100K)'
            WHEN balance < 1000000 THEN 'Large (100K - 1M)'
            WHEN balance < 10000000 THEN 'Whale (1M - 10M)'
            ELSE 'Mega Whale (> 10M)'
        END AS tier,
        CASE
            WHEN balance < 1000 THEN 1
            WHEN balance < 10000 THEN 2
            WHEN balance < 100000 THEN 3
            WHEN balance < 1000000 THEN 4
            WHEN balance < 10000000 THEN 5
            ELSE 6
        END AS tier_order
    FROM balances
)

SELECT
    t.tier,
    t.tier_order,
    COUNT(*) AS holder_count,
    ROUND(SUM(t.balance), 0) AS total_balance,
    ROUND(100.0 * SUM(t.balance) / ts.total, 2) AS pct_of_supply,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_holders,
    ROUND(AVG(t.balance), 0) AS avg_balance,
    ROUND(MEDIAN(t.balance), 0) AS median_balance
FROM tiers t
CROSS JOIN total_supply_held ts
GROUP BY t.tier, t.tier_order, ts.total
ORDER BY t.tier_order
```

### Visualization Setup

**Chart: Pie - Holders by Tier** (ROW 16, right 4 cols)
- Type: **Pie Chart**
- Values: `holder_count`, Labels: `tier`
- Title: `Holder Distribution (by count)`
- Colors: Dust `#D1D5DB`, Small `#93C5FD`, Medium `#6366F1`, Large `#F59E0B`, Whale `#EF4444`, Mega Whale `#7F1D1D`

**Also create a second pie below for supply concentration:**
- Values: `total_balance`, Labels: `tier`
- Title: `Supply Distribution by Tier (%)`

---

## Query 13: OWB - Top Holders

### Purpose
Top 25 holders by current balance with cumulative % of total supply. Essential for concentration risk assessment.

### Save as
`OWB - Top Holders`

### SQL

```sql
-- OWB Top 25 Holders by Current Balance
-- Net balance from all transfers, ranked

WITH flows AS (
    SELECT "to" AS address, amount
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "to" != 0x0000000000000000000000000000000000000000

    UNION ALL

    SELECT "from" AS address, -amount
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "from" != 0x0000000000000000000000000000000000000000
),

balances AS (
    SELECT
        address,
        SUM(amount) AS balance
    FROM flows
    GROUP BY 1
    HAVING SUM(amount) > 0
),

ranked AS (
    SELECT
        address,
        ROUND(balance, 0) AS balance,
        ROUND(100.0 * balance / 1e9, 4) AS pct_of_total_supply,
        ROUND(100.0 * balance / (SELECT SUM(balance) FROM balances), 4) AS pct_of_circulating,
        ROW_NUMBER() OVER (ORDER BY balance DESC) AS rank
    FROM balances
)

SELECT
    rank,
    address,
    balance,
    pct_of_total_supply,
    pct_of_circulating,
    SUM(pct_of_total_supply) OVER (ORDER BY rank) AS cumulative_pct_total,
    SUM(pct_of_circulating) OVER (ORDER BY rank) AS cumulative_pct_circulating,
    CASE
        WHEN address IN (
            0xf252f51919dfca2c9c0ea279f11183580edee4d6,
            0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
        ) THEN 'DEX Pool'
        WHEN address = 0x0000000000000000000000000000000000000000 THEN 'Burn'
        ELSE 'Wallet'
    END AS address_type
FROM ranked
WHERE rank <= 25
ORDER BY rank
```

### Visualization Setup

**Table** (ROW 17, full width)
- Type: **Table**
- Columns: rank, address (link), balance (formatted `0,0`), pct_of_total_supply (%), pct_of_circulating (%), cumulative_pct_total (%), address_type
- Title: `Top 25 OWB Holders`
- Conditional formatting: address_type "DEX Pool" in blue, "Wallet" default

---

## Query 14: OWB - Large Transfers (Whale Tracking)

### Purpose
All OWB transfers > 100K tokens in the last 30 days. Classifies as DEX flow, mint, burn, or wallet-to-wallet.

### Save as
`OWB - Large Transfers`

### SQL

```sql
-- OWB Large Transfers (> 100K OWB, 30d)
-- Whale tracking: who is moving big amounts and where

SELECT
    block_time,
    "from" AS sender,
    "to" AS receiver,
    ROUND(amount, 0) AS amount_owb,
    CASE
        WHEN "from" IN (
            0xf252f51919dfca2c9c0ea279f11183580edee4d6,
            0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
        ) THEN 'DEX Outflow (Buy)'
        WHEN "to" IN (
            0xf252f51919dfca2c9c0ea279f11183580edee4d6,
            0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
        ) THEN 'DEX Inflow (Sell)'
        WHEN "from" = 0x0000000000000000000000000000000000000000
        THEN 'Mint'
        WHEN "to" = 0x0000000000000000000000000000000000000000
        THEN 'Burn'
        ELSE 'Wallet Transfer'
    END AS transfer_type,
    tx_hash
FROM tokens.transfers
WHERE blockchain = 'base'
  AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
  AND amount > 100000
  AND block_time >= NOW() - INTERVAL '30' DAY
ORDER BY block_time DESC
LIMIT 200
```

### Visualization Setup

**Table** (ROW 20, full width)
- Type: **Table**
- Columns: block_time, sender (link), receiver (link), amount_owb (formatted `0,0`), transfer_type, tx_hash (link)
- Title: `Large OWB Transfers (> 100K, 30d)`
- Conditional formatting: "DEX Outflow (Buy)" green, "DEX Inflow (Sell)" red, "Mint" blue, "Burn" gray

---

## Query 15: OWB - Net Flow Analysis

### Purpose
Daily net OWB flow direction: accumulation (more leaving DEX) vs distribution (more entering DEX). The key demand signal.

### Save as
`OWB - Net Flow Analysis`

### SQL

```sql
-- OWB Net Flow Analysis (90d)
-- Positive net flow = accumulation (buyers removing OWB from DEX)
-- Negative net flow = distribution (sellers adding OWB to DEX)

WITH daily_flows AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        -- OWB flowing INTO DEX pools (selling pressure)
        SUM(CASE
            WHEN "to" IN (
                0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
            )
            THEN amount ELSE 0
        END) AS dex_inflow,
        -- OWB flowing OUT of DEX pools (buying pressure)
        SUM(CASE
            WHEN "from" IN (
                0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
            )
            THEN amount ELSE 0
        END) AS dex_outflow,
        -- Total transfer volume
        SUM(amount) AS total_transfer_volume,
        COUNT(*) AS transfer_count,
        COUNT(DISTINCT "from") AS unique_senders,
        COUNT(DISTINCT "to") AS unique_receivers
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND block_time >= NOW() - INTERVAL '90' DAY
      AND "from" != 0x0000000000000000000000000000000000000000
      AND "to" != 0x0000000000000000000000000000000000000000
    GROUP BY 1
)

SELECT
    day,
    ROUND(dex_inflow, 0) AS dex_inflow_owb,
    ROUND(dex_outflow, 0) AS dex_outflow_owb,
    ROUND(dex_outflow - dex_inflow, 0) AS net_flow_owb,
    CASE
        WHEN dex_outflow > dex_inflow THEN 'Accumulation'
        ELSE 'Distribution'
    END AS flow_direction,
    ROUND(total_transfer_volume, 0) AS total_transfer_volume,
    transfer_count,
    unique_senders,
    unique_receivers,
    -- Cumulative net flow
    SUM(ROUND(dex_outflow - dex_inflow, 0)) OVER (ORDER BY day) AS cumulative_net_flow,
    -- 7d rolling net flow
    ROUND(AVG(dex_outflow - dex_inflow) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS net_flow_7d_ma
FROM daily_flows
ORDER BY day
```

### Visualization Setup

**Chart A: Net Flow Bars** (ROW 19, left 6 cols)
- Type: **Bar Chart**
- X-axis: `day`
- Y-axis: `net_flow_owb` (bar)
- Colors: Conditional - positive values `#22C55E`, negative values `#F43F5E`
- Overlay: `net_flow_7d_ma` (line, `#6366F1`)
- Title: `OWB DEX Net Flow (Accumulation/Distribution)`
- NOTE: In Dune, to color bars conditionally, you may need to split into two series or use the default coloring.

**Alternative approach (two series):**
- Y-axis 1: Create `accumulation = CASE WHEN net_flow_owb > 0 THEN net_flow_owb ELSE 0 END` (bar, green)
- Y-axis 2: Create `distribution = CASE WHEN net_flow_owb < 0 THEN net_flow_owb ELSE 0 END` (bar, red)

**Chart B: Cumulative Net Flow** (ROW 19, right 6 cols)
- Type: **Area Chart**
- X-axis: `day`
- Y-axis: `cumulative_net_flow` (area, `#6366F1`, fill 0.3)
- Title: `Cumulative OWB Net Flow`
- Interpretation: Rising = sustained accumulation, Falling = sustained distribution

---

## Query 16: OWB - Market Dynamics & Volatility

### Purpose
Technical signals: moving averages, annualized volatility, daily return, momentum oscillator. Helps identify regime changes.

### Save as
`OWB - Market Dynamics`

### SQL

```sql
-- OWB Market Dynamics: Volatility, MAs, Momentum (180d)
-- Annualized volatility from daily returns
-- Simplified momentum: % of up-days in 14-day window

WITH daily_data AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        SUM(amount_usd) / NULLIF(
            SUM(
                CASE
                    WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_bought_amount
                    WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_sold_amount
                    ELSE 0
                END
            ), 0
        ) AS price,
        ROUND(SUM(amount_usd), 2) AS volume,
        MAX(
            CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_bought_amount > 0
                THEN amount_usd / token_bought_amount
                WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_sold_amount > 0
                THEN amount_usd / token_sold_amount
            END
        ) AS high_price,
        MIN(
            CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_bought_amount > 0
                THEN amount_usd / token_bought_amount
                WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                     AND token_sold_amount > 0
                THEN amount_usd / token_sold_amount
            END
        ) AS low_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
      AND block_time >= NOW() - INTERVAL '180' DAY
    GROUP BY 1
),

with_returns AS (
    SELECT
        day,
        price,
        volume,
        high_price,
        low_price,
        (price - LAG(price) OVER (ORDER BY day))
            / NULLIF(LAG(price) OVER (ORDER BY day), 0) AS daily_return,
        (high_price - low_price) / NULLIF(low_price, 0) AS daily_range
    FROM daily_data
)

SELECT
    day,
    ROUND(price, 6) AS price,
    ROUND(volume, 2) AS volume,
    ROUND(daily_return * 100, 2) AS daily_return_pct,
    ROUND(daily_range * 100, 2) AS daily_range_pct,
    -- 7-day annualized volatility
    ROUND(
        STDDEV(daily_return) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
        * SQRT(365) * 100,
    2) AS volatility_7d_ann,
    -- 30-day annualized volatility
    ROUND(
        STDDEV(daily_return) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW)
        * SQRT(365) * 100,
    2) AS volatility_30d_ann,
    -- Moving Averages
    ROUND(AVG(price) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 6) AS ma_7d,
    ROUND(AVG(price) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW), 6) AS ma_30d,
    -- Price position vs MAs
    CASE
        WHEN price > AVG(price) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
        THEN 'Above'
        ELSE 'Below'
    END AS vs_7d_ma,
    CASE
        WHEN price > AVG(price) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW)
        THEN 'Above'
        ELSE 'Below'
    END AS vs_30d_ma,
    -- Momentum: % of up-days in 14-day window (0-100, >50 = bullish)
    ROUND(
        100.0 * SUM(CASE WHEN daily_return > 0 THEN 1 ELSE 0 END)
            OVER (ORDER BY day ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) / 14,
    1) AS momentum_14d,
    -- Volume momentum
    ROUND(
        volume / NULLIF(AVG(volume) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW), 0),
    2) AS volume_ratio_vs_30d_avg
FROM with_returns
WHERE daily_return IS NOT NULL
ORDER BY day
```

### Visualization Setup

**Chart A: Price + MAs + Momentum** (ROW 22, left 8 cols)
- Type: **Mixed** (Line + Area)
- X-axis: `day`
- Left Y-axis: `price` (line, `#6366F1`), `ma_7d` (dashed line, `#F59E0B`), `ma_30d` (dashed line, `#EF4444`)
- Right Y-axis: `momentum_14d` (area, `#10B981`, fill 0.2)
- Reference line at 50 on right Y-axis (neutral momentum)
- Title: `OWB Price, Moving Averages & Momentum`

**Chart B: Volatility** (ROW 22, right 4 cols)
- Type: **Area Chart**
- X-axis: `day`
- Y-axis: `volatility_7d_ann` (area, `#EF4444`, fill 0.3), `volatility_30d_ann` (area, `#F59E0B`, fill 0.2)
- Title: `Annualized Volatility (7d & 30d)`
- Y-axis format: `0.0%`

---

## Query 17: OWB - Weekly Performance Summary

### Purpose
Week-over-week comparison table. Price, volume, swaps, traders with WoW % changes. The executive summary table.

### Save as
`OWB - Weekly Performance`

### SQL

```sql
-- OWB Weekly Performance Summary (12 weeks)
-- WoW changes for all key metrics

WITH weekly_data AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        COUNT(*) AS swaps,
        COUNT(DISTINCT tx_from) AS unique_traders,
        ROUND(SUM(amount_usd), 2) AS volume_usd,
        -- VWAP
        SUM(amount_usd) / NULLIF(
            SUM(
                CASE
                    WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_bought_amount
                    WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                    THEN token_sold_amount
                    ELSE 0
                END
            ), 0
        ) AS avg_price,
        -- Buy vs Sell
        ROUND(SUM(CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN amount_usd ELSE 0
        END), 2) AS buy_volume,
        ROUND(SUM(CASE
            WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN amount_usd ELSE 0
        END), 2) AS sell_volume
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND amount_usd > 0
      AND block_time >= NOW() - INTERVAL '90' DAY
    GROUP BY 1
)

SELECT
    week,
    swaps,
    unique_traders,
    volume_usd,
    ROUND(avg_price, 6) AS avg_price,
    ROUND(volume_usd / NULLIF(swaps, 0), 2) AS avg_trade_size,
    buy_volume,
    sell_volume,
    ROUND(buy_volume / NULLIF(sell_volume, 0), 2) AS buy_sell_ratio,
    -- WoW changes
    ROUND(100.0 * (swaps - LAG(swaps) OVER (ORDER BY week))
        / NULLIF(LAG(swaps) OVER (ORDER BY week), 0), 1) AS swaps_wow_pct,
    ROUND(100.0 * (volume_usd - LAG(volume_usd) OVER (ORDER BY week))
        / NULLIF(LAG(volume_usd) OVER (ORDER BY week), 0), 1) AS volume_wow_pct,
    ROUND(100.0 * (unique_traders - LAG(unique_traders) OVER (ORDER BY week))
        / NULLIF(LAG(unique_traders) OVER (ORDER BY week), 0), 1) AS traders_wow_pct,
    ROUND(100.0 * (avg_price - LAG(avg_price) OVER (ORDER BY week))
        / NULLIF(LAG(avg_price) OVER (ORDER BY week), 0), 1) AS price_wow_pct
FROM weekly_data
ORDER BY week DESC
```

### Visualization Setup

**Table** (ROW 23, full width)
- Type: **Table**
- Columns: week, avg_price ($), volume_usd ($), swaps, unique_traders, avg_trade_size ($), buy_sell_ratio, price_wow_pct (%), volume_wow_pct (%), swaps_wow_pct (%), traders_wow_pct (%)
- Title: `OWB Weekly Performance Summary`
- Format: `volume_usd` as `$0,0`, WoW columns with green/red conditional formatting (positive = green, negative = red)

---

---

# STEP-BY-STEP SETUP INSTRUCTIONS

## How to Create the Dashboard on Dune

### Step 1: Create the Dashboard

1. Go to https://dune.com
2. Click **"New"** -> **"Dashboard"**
3. Name: `OWB Token Analytics - Base | OneWayBlock`
4. Set to **Public**
5. Click **"Edit"** to enter editing mode

### Step 2: Create Queries (one by one)

For each of the 17 queries above:

1. Go to https://dune.com -> **"New"** -> **"Query"**
2. Paste the SQL code
3. Click **"Run"** to verify it works
4. **Save** with the exact name specified (e.g., `OWB - Overview KPIs`)
5. Do NOT close the query page yet - create visualizations first

### Step 3: Create Visualizations

After running each query:

1. Click **"New visualization"** (tab next to "Query results")
2. Select chart type as specified in the setup instructions
3. Configure X-axis, Y-axis, colors, labels as documented
4. Some queries need **multiple visualizations** (e.g., Query 1 needs 8 counter widgets)
5. Save each visualization

### Step 4: Assemble the Dashboard

1. Open your dashboard in **Edit** mode
2. Click **"Add visualization"** and search for your saved query
3. Select the specific visualization from that query
4. Resize and position according to the layout map
5. Add **text widgets** between sections (copy markdown from the Text Widgets section above)
6. Arrange everything according to the layout map

### Step 5: Final Touches

1. Review all widgets are loading correctly
2. Check that all text widgets render properly
3. Verify color consistency across charts
4. Add any custom CSS if available
5. Save and publish

---

# ADDITIONAL METRICS (OPTIONAL / FUTURE)

These queries can be added once the relevant contracts are verified:

### vOWB Economy (requires verified vOWB contract)

```sql
-- vOWB Daily Claims
-- IMPORTANT: Verify vOWB address 0xd5590f6cecef03b796fd904541727c2fe6346c06
-- This query tracks vOWB token distribution (in-game rewards)

SELECT
    DATE_TRUNC('day', block_time) AS day,
    COUNT(DISTINCT "to") AS unique_claimers,
    ROUND(SUM(amount), 0) AS total_vowb_claimed,
    COUNT(*) AS claim_count,
    SUM(COUNT(DISTINCT "to")) OVER (ORDER BY DATE_TRUNC('day', block_time)) AS cumulative_claimers,
    SUM(ROUND(SUM(amount), 0)) OVER (ORDER BY DATE_TRUNC('day', block_time)) AS cumulative_vowb_claimed
FROM tokens.transfers
WHERE blockchain = 'base'
  AND contract_address = 0xd5590f6cecef03b796fd904541727c2fe6346c06
  AND "from" = 0x0000000000000000000000000000000000000000
  AND block_time >= TIMESTAMP '2025-12-25'
GROUP BY 1
ORDER BY 1
```

### NFT Purchase Activity (requires verified NFT contract)

```sql
-- OWB NFT Purchases (requires verified NFT contract)
-- IMPORTANT: Verify NFT address 0x94b3a7eb32685e79b4566600fe92ecd14e430970

SELECT
    DATE_TRUNC('day', block_time) AS day,
    COUNT(*) AS nft_transfers,
    COUNT(DISTINCT "to") AS unique_buyers,
    SUM(COUNT(DISTINCT "to")) OVER (ORDER BY DATE_TRUNC('day', block_time)) AS cumulative_buyers
FROM tokens.transfers
WHERE blockchain = 'base'
  AND contract_address = 0x94b3a7eb32685e79b4566600fe92ecd14e430970
  AND "from" != 0x0000000000000000000000000000000000000000
  AND block_time >= TIMESTAMP '2025-12-25'
GROUP BY 1
ORDER BY 1
```

### OWB Staking (requires staking contract address)

```sql
-- Placeholder: OWB Staking Activity
-- Requires staking contract address (not yet confirmed)
-- Once available:
-- Track daily staked/unstaked amounts
-- Total staked OWB over time
-- Unique stakers
-- APY estimation from yield events
```

---

# SUMMARY TABLE

| # | Query Name | Chart Type(s) | Dashboard Row |
|---|-----------|---------------|---------------|
| 1 | OWB - Overview KPIs | 8 Counters | ROW 2 |
| 2 | OWB - Daily Price & Volume | Line + Bar + Mixed | ROW 4-5 |
| 3 | OWB - Volume by DEX | Stacked Area + Pie | ROW 7 left |
| 4 | OWB - Buy vs Sell Pressure | Stacked Bar + Line | ROW 7 right |
| 5 | OWB - Trade Size Distribution | Horizontal Bar | ROW 8 left |
| 6 | OWB - Hourly Trading Heatmap | Table / Scatter | ROW 8 right |
| 7 | OWB - Trader Intelligence | Stacked Bar + Area | ROW 10-11 |
| 8 | OWB - Top Traders | Table | ROW 12 |
| 9 | OWB - Trader Cohorts | 2x Pie | ROW 10 right |
| 10 | OWB - Pool TVL & Reserves | Stacked Area + Line | ROW 14 |
| 11 | OWB - Holder Growth | Mixed Bar + Line | ROW 16 left |
| 12 | OWB - Holder Distribution | 2x Pie | ROW 16 right |
| 13 | OWB - Top Holders | Table | ROW 17 |
| 14 | OWB - Large Transfers | Table | ROW 20 |
| 15 | OWB - Net Flow Analysis | Bar + Area | ROW 19 |
| 16 | OWB - Market Dynamics | Mixed Line/Area x2 | ROW 22 |
| 17 | OWB - Weekly Performance | Table | ROW 23 |

**Total: 17 queries, ~30+ visualizations, 9 text widgets**

---

*Guide compiled: February 26, 2026*
*Token: OWB (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1) on Base*
*Dashboard: https://dune.com/bossincrypto/owb-token-analytics-base-onewayblock*
