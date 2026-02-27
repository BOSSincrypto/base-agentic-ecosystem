# TWT Analytics Dashboard - Complete Guide

> Dashboard URL: https://dune.com/bossincrypto/twt-analytics
>
> Token: TWT (Trust Wallet Token) on BNB Chain
> Contract: `0x4b0f1812e5df2a09796481ff14017e6005508003`

---

## Dashboard Structure Overview

The dashboard is organized into **6 sections** with a total of **10 queries**. Each section answers a specific analytical question about TWT.

### Layout Map

```
+------------------------------------------------------------------+
|  HEADER TEXT WIDGET (description of the dashboard)               |
+------------------------------------------------------------------+
|  [KPI 1]      [KPI 2]      [KPI 3]      [KPI 4]      [KPI 5]   |
|  Price Now   24h Volume   Market Cap   Holders     24h Txs      |
+------------------------------------------------------------------+
|  SECTION 1: PRICE & MARKET DYNAMICS                              |
|  [Chart: Daily Price + Volume - dual axis, full width]           |
+------------------------------------------------------------------+
|  SECTION 2: DEX TRADING ANALYTICS                                |
|  [Chart: Buy vs Sell Volume]     [Chart: Unique Traders Daily]   |
|  [Table: DEX Breakdown]                                          |
+------------------------------------------------------------------+
|  SECTION 3: TOKEN TRANSFER ANALYSIS                              |
|  [Chart: Daily Transfers + Volume]  [Chart: Transfer Sizes]      |
+------------------------------------------------------------------+
|  SECTION 4: HOLDER DYNAMICS                                      |
|  [Chart: Net Holder Growth]    [Pie: Holder Distribution]        |
+------------------------------------------------------------------+
|  SECTION 5: WHALE TRACKER                                        |
|  [Table: Recent Large Transfers > $50K]                          |
+------------------------------------------------------------------+
|  SECTION 6: NETWORK HEALTH & VELOCITY                            |
|  [Chart: Active Addresses]   [Chart: Token Velocity Index]       |
+------------------------------------------------------------------+
|  METHODOLOGY & DATA SOURCES                                      |
+------------------------------------------------------------------+
```

---

## Header Text Widget

**Widget type:** Text

**Content (paste as Markdown in Dune text widget):**

```
## TWT On-Chain Analytics

A deep-dive analytical dashboard tracking Trust Wallet Token (TWT) on BNB Chain.

Token contract: `0x4b0f1812e5df2a09796481ff14017e6005508003`

This dashboard monitors price dynamics, DEX trading patterns, holder distribution, whale movements, and network health metrics - providing a comprehensive view of TWT's on-chain activity.

Data sources: BNB Chain raw tables, Dune curated DEX trades, token transfers, and price feeds.
Maintained by: @bossincrypto
```

---

## QUERY 1: TWT Key Metrics Summary (KPI Counters)

**Purpose:** Top-level KPI row - 5 counter widgets showing current state at a glance.

**Visualization:** 5 separate **Counter** widgets in a row. Each counter sourced from the same query but displaying different columns.

**Counter settings:**
- `current_price` - Title: "TWT Price", Prefix: "$", Decimals: 4
- `volume_24h` - Title: "24h DEX Volume", Prefix: "$", Suffix: none, Format: compact
- `market_cap_approx` - Title: "Approx Market Cap", Prefix: "$", Format: compact
- `holders_approx` - Title: "Active Addresses (30d)", Format: number
- `txs_24h` - Title: "24h Transactions", Format: number

```sql
WITH latest_price AS (
    SELECT
        price AS current_price
    FROM prices.usd_latest
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
),
volume_24h AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS volume_24h
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_time >= NOW() - INTERVAL '24' hour
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
),
active_30d AS (
    SELECT
        COUNT(DISTINCT "from") + COUNT(DISTINCT "to") AS holders_approx_raw
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND block_date >= CURRENT_DATE - INTERVAL '30' day
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
),
holders_dedup AS (
    SELECT COUNT(DISTINCT addr) AS holders_approx
    FROM (
        SELECT "from" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND block_date >= CURRENT_DATE - INTERVAL '30' day
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
        UNION
        SELECT "to" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND block_date >= CURRENT_DATE - INTERVAL '30' day
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
    ) u
),
txs_24h AS (
    SELECT COUNT(*) AS txs_24h
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND block_date >= CURRENT_DATE - INTERVAL '1' day
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
)
SELECT
    lp.current_price,
    v.volume_24h,
    lp.current_price * 1e9 AS market_cap_approx,  -- TWT total supply ~1B
    h.holders_approx,
    t.txs_24h
FROM latest_price lp
CROSS JOIN volume_24h v
CROSS JOIN holders_dedup h
CROSS JOIN txs_24h t
```

**Notes:**
- `market_cap_approx` uses total supply ~1B. For more precision, you can adjust the multiplier to the actual circulating supply (check CoinGecko/CMC).
- `prices.usd_latest` provides the most recent price from Dune's price feed.

---

## QUERY 2: TWT Daily Price and DEX Volume (Time Series)

**Purpose:** Show price trend alongside trading volume. The main analytical chart.

**Visualization:** **Area chart** (or Combined chart)
- Left Y-axis: `price_usd` (line, color: #4A90D9)
- Right Y-axis: `dex_volume_usd` (bars, color: #50C878, opacity 0.4)
- X-axis: `day`
- Also show `ma7_price` as a dashed line (color: #FF6B6B)
- Toggle: Show/hide 30d MA

```sql
WITH daily_price AS (
    SELECT
        DATE_TRUNC('day', minute) AS day,
        AVG(price) AS price_usd
    FROM prices.usd
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND minute >= CAST('2024-01-01' AS TIMESTAMP)
    GROUP BY 1
),
daily_volume AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        SUM(amount_usd) AS dex_volume_usd,
        COUNT(*) AS trades_count
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_date >= CAST('2024-01-01' AS DATE)
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
    GROUP BY 1
)
SELECT
    COALESCE(p.day, v.day) AS day,
    p.price_usd,
    v.dex_volume_usd,
    v.trades_count,
    AVG(p.price_usd) OVER (ORDER BY p.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_price,
    AVG(p.price_usd) OVER (ORDER BY p.day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS ma30_price,
    AVG(v.dex_volume_usd) OVER (ORDER BY COALESCE(p.day, v.day) ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_volume
FROM daily_price p
FULL OUTER JOIN daily_volume v ON p.day = v.day
WHERE COALESCE(p.day, v.day) IS NOT NULL
ORDER BY 1
```

**Chart settings:**
- Title: "TWT Price & DEX Volume (Daily)"
- Enable zoom/scroll on X-axis
- Gridlines: subtle gray (#333)

---

## QUERY 3: DEX Buy vs Sell Pressure

**Purpose:** Separate buy and sell volume to see directional pressure. Critical for understanding market sentiment.

**Visualization:** **Stacked bar chart**
- X-axis: `day`
- Y-axis stacked: `buy_volume_usd` (green #22C55E), `sell_volume_usd` (red #EF4444)
- Overlay line: `net_flow_usd` (white dashed)

```sql
WITH trades AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        CASE
            WHEN token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
            THEN 'buy'
            ELSE 'sell'
        END AS side,
        amount_usd,
        tx_from
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_date >= CURRENT_DATE - INTERVAL '180' day
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
      AND amount_usd > 0
)
SELECT
    day,
    SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END) AS buy_volume_usd,
    SUM(CASE WHEN side = 'sell' THEN amount_usd ELSE 0 END) AS sell_volume_usd,
    SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END)
      - SUM(CASE WHEN side = 'sell' THEN amount_usd ELSE 0 END) AS net_flow_usd,
    COUNT(DISTINCT CASE WHEN side = 'buy' THEN tx_from END) AS unique_buyers,
    COUNT(DISTINCT CASE WHEN side = 'sell' THEN tx_from END) AS unique_sellers,
    ROUND(
        100.0 * SUM(CASE WHEN side = 'buy' THEN amount_usd ELSE 0 END)
        / NULLIF(SUM(amount_usd), 0),
        1
    ) AS buy_ratio_pct
FROM trades
GROUP BY 1
ORDER BY 1
```

**Additional visualization from same query:**
- **Counter widget** showing latest day's `buy_ratio_pct` - Title: "Buy Ratio (24h)", Suffix: "%"
- Color: green if > 50, red if < 50

---

## QUERY 4: DEX Breakdown by Protocol

**Purpose:** Show which DEXes handle TWT volume. Useful for understanding liquidity fragmentation.

**Visualization:** Two widgets from one query:
1. **Pie chart** - `total_volume_usd` by `project` (last 30d)
2. **Table** - sorted by volume, showing all columns

```sql
SELECT
    project,
    COUNT(*) AS trades_count,
    COUNT(DISTINCT tx_from) AS unique_traders,
    SUM(amount_usd) AS total_volume_usd,
    SUM(amount_usd) / COUNT(DISTINCT DATE_TRUNC('day', block_time)) AS avg_daily_volume,
    AVG(amount_usd) AS avg_trade_size_usd,
    MIN(block_time) AS first_trade,
    MAX(block_time) AS last_trade
FROM dex.trades
WHERE blockchain = 'bnb'
  AND block_date >= CURRENT_DATE - INTERVAL '30' day
  AND (
      token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
  )
  AND amount_usd > 0
GROUP BY 1
ORDER BY total_volume_usd DESC
```

**Table formatting:**
- Column `total_volume_usd`: format as USD, 0 decimals
- Column `avg_trade_size_usd`: format as USD, 2 decimals
- Column `unique_traders`: number format
- Column `first_trade` / `last_trade`: date format

---

## QUERY 5: Unique DEX Traders (Daily Time Series)

**Purpose:** Track how many unique wallets trade TWT each day. Growth indicator for community engagement.

**Visualization:** **Stacked area chart**
- X-axis: `day`
- Areas: `new_traders` (blue #3B82F6), `returning_traders` (purple #8B5CF6)
- Overlay line: `cumulative_unique_traders` on right Y-axis (white)

```sql
WITH daily_traders AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        tx_from AS trader
    FROM dex.trades
    WHERE blockchain = 'bnb'
      AND block_date >= CAST('2024-01-01' AS DATE)
      AND (
          token_bought_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          OR token_sold_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      )
    GROUP BY 1, 2
),
first_seen AS (
    SELECT
        trader,
        MIN(day) AS first_day
    FROM daily_traders
    GROUP BY 1
),
classified AS (
    SELECT
        dt.day,
        dt.trader,
        CASE WHEN dt.day = fs.first_day THEN 'new' ELSE 'returning' END AS trader_type
    FROM daily_traders dt
    JOIN first_seen fs ON dt.trader = fs.trader
)
SELECT
    day,
    COUNT(DISTINCT CASE WHEN trader_type = 'new' THEN trader END) AS new_traders,
    COUNT(DISTINCT CASE WHEN trader_type = 'returning' THEN trader END) AS returning_traders,
    COUNT(DISTINCT trader) AS total_traders,
    SUM(COUNT(DISTINCT CASE WHEN trader_type = 'new' THEN trader END)) OVER (ORDER BY day) AS cumulative_unique_traders
FROM classified
GROUP BY 1
ORDER BY 1
```

---

## QUERY 6: Token Transfer Analysis (Volume & Count)

**Purpose:** Analyze all TWT transfers (not just DEX), including CEX deposits/withdrawals, wallet-to-wallet, staking operations. This captures the full picture that DEX-only queries miss.

**Visualization:** **Combined chart** (full width)
- Bars: `transfer_volume_usd` (teal #14B8A6, opacity 0.5)
- Line 1: `transfer_count` on right Y-axis (yellow #FBBF24)
- Line 2: `ma7_volume` (dashed white)

```sql
WITH daily AS (
    SELECT
        block_date AS day,
        COUNT(*) AS transfer_count,
        SUM(amount_usd) AS transfer_volume_usd,
        COUNT(DISTINCT "from") AS unique_senders,
        COUNT(DISTINCT "to") AS unique_receivers,
        SUM(CASE WHEN amount_usd >= 50000 THEN amount_usd ELSE 0 END) AS whale_volume_usd,
        COUNT(CASE WHEN amount_usd >= 50000 THEN 1 END) AS whale_txs
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)
    GROUP BY 1
)
SELECT
    day,
    transfer_count,
    transfer_volume_usd,
    unique_senders,
    unique_receivers,
    whale_volume_usd,
    whale_txs,
    ROUND(100.0 * whale_volume_usd / NULLIF(transfer_volume_usd, 0), 1) AS whale_pct,
    AVG(transfer_volume_usd) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_volume,
    AVG(transfer_count) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_count
FROM daily
ORDER BY 1
```

**Additional counter from this query:**
- Latest `whale_pct` as a Counter widget - Title: "Whale Share of Volume", Suffix: "%"

---

## QUERY 7: Transfer Size Distribution (Cohort Analysis)

**Purpose:** Understand the distribution of transfer sizes. Shows whether activity is retail-driven or whale-driven.

**Visualization:** Two options:
1. **Stacked area chart** - daily breakdown by cohort
2. **Horizontal bar chart** - aggregated over 30d

```sql
WITH transfers AS (
    SELECT
        block_date AS day,
        amount_usd,
        CASE
            WHEN amount_usd < 100 THEN 'Micro (<$100)'
            WHEN amount_usd < 1000 THEN 'Small ($100-$1K)'
            WHEN amount_usd < 10000 THEN 'Medium ($1K-$10K)'
            WHEN amount_usd < 100000 THEN 'Large ($10K-$100K)'
            ELSE 'Whale ($100K+)'
        END AS size_bucket,
        CASE
            WHEN amount_usd < 100 THEN 1
            WHEN amount_usd < 1000 THEN 2
            WHEN amount_usd < 10000 THEN 3
            WHEN amount_usd < 100000 THEN 4
            ELSE 5
        END AS bucket_order
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CURRENT_DATE - INTERVAL '90' day
      AND amount_usd > 0
)
SELECT
    day,
    size_bucket,
    bucket_order,
    COUNT(*) AS tx_count,
    SUM(amount_usd) AS total_volume_usd,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY day), 1) AS pct_of_txs,
    ROUND(100.0 * SUM(amount_usd) / NULLIF(SUM(SUM(amount_usd)) OVER (PARTITION BY day), 0), 1) AS pct_of_volume
FROM transfers
GROUP BY 1, 2, 3
ORDER BY 1, 3
```

**Chart settings for stacked area:**
- Color scheme: Micro=#6B7280, Small=#3B82F6, Medium=#8B5CF6, Large=#F59E0B, Whale=#EF4444
- Stack: normalized (100%) or absolute
- Title: "Transfer Size Distribution (90d)"

---

## QUERY 8: Holder Growth (Net Change & Cumulative)

**Purpose:** Track net holder growth using the balance change approach. Shows accumulation vs distribution trends.

**Visualization:** **Combined chart**
- Bars: `net_new_holders` (green if positive, red if negative)
- Line: `cumulative_holders_estimate` on right Y-axis (white)

```sql
WITH transfers AS (
    SELECT
        block_date AS day,
        "to" AS address,
        amount AS inflow
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)

    UNION ALL

    SELECT
        block_date AS day,
        "from" AS address,
        -amount AS inflow
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)
),
daily_balances AS (
    SELECT
        day,
        address,
        SUM(inflow) AS net_change
    FROM transfers
    WHERE address != 0x0000000000000000000000000000000000000000
    GROUP BY 1, 2
),
running AS (
    SELECT
        day,
        address,
        SUM(net_change) OVER (PARTITION BY address ORDER BY day) AS running_balance,
        LAG(SUM(net_change) OVER (PARTITION BY address ORDER BY day)) OVER (PARTITION BY address ORDER BY day) AS prev_balance
    FROM daily_balances
),
classified AS (
    SELECT
        day,
        SUM(CASE WHEN running_balance > 0 AND (prev_balance IS NULL OR prev_balance <= 0) THEN 1 ELSE 0 END) AS new_holders,
        SUM(CASE WHEN running_balance <= 0 AND prev_balance > 0 THEN 1 ELSE 0 END) AS lost_holders
    FROM running
    GROUP BY 1
)
SELECT
    day,
    new_holders,
    lost_holders,
    new_holders - lost_holders AS net_new_holders,
    SUM(new_holders - lost_holders) OVER (ORDER BY day) AS cumulative_holders_estimate,
    AVG(CAST(new_holders - lost_holders AS DOUBLE)) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_net_holders
FROM classified
ORDER BY 1
```

**Notes:** This is a computationally heavy query. It approximates holder count by tracking balance changes. For the first load, use `medium` engine if needed. Results are accurate and update daily.

---

## QUERY 9: Whale Tracker (Large Transfers Table)

**Purpose:** Real-time table of large TWT movements. Alerts for significant wallet activity.

**Visualization:** **Table** widget (full width)
- Sortable columns
- Highlight rows where amount_usd > $500K in red
- Link tx_hash to BSCScan

```sql
SELECT
    block_time,
    "from" AS sender,
    "to" AS receiver,
    amount AS twt_amount,
    amount_usd,
    CASE
        WHEN amount_usd >= 500000 THEN 'MEGA'
        WHEN amount_usd >= 100000 THEN 'WHALE'
        ELSE 'LARGE'
    END AS category,
    tx_hash
FROM tokens.transfers
WHERE blockchain = 'bnb'
  AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
  AND block_date >= CURRENT_DATE - INTERVAL '30' day
  AND amount_usd >= 50000
ORDER BY amount_usd DESC
LIMIT 100
```

**Table formatting:**
- `block_time`: Date+Time format
- `sender` / `receiver`: Truncate address (Dune auto-does this), clickable
- `twt_amount`: Number format with comma separator
- `amount_usd`: USD format, 0 decimals
- `category`: Color-coded (MEGA=red, WHALE=orange, LARGE=yellow)
- `tx_hash`: Link to `https://bscscan.com/tx/{tx_hash}`

---

## QUERY 10: Network Health - Active Addresses & Token Velocity

**Purpose:** Composite network health view. Token velocity = transfer volume / market cap proxy. High velocity = tokens change hands often (active usage). Low velocity = tokens are held (accumulation).

**Visualization:** **Combined chart**
- Area: `active_addresses` (blue #3B82F6, left Y-axis)
- Line: `velocity_index` (orange #F59E0B, right Y-axis)
- Dashed line: `ma7_velocity` (white dashed, right Y-axis)

```sql
WITH daily_transfers AS (
    SELECT
        block_date AS day,
        COUNT(*) AS transfer_count,
        SUM(amount) AS total_twt_transferred,
        SUM(amount_usd) AS total_usd_transferred
    FROM tokens.transfers
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND block_date >= CAST('2024-01-01' AS DATE)
    GROUP BY 1
),
daily_active AS (
    SELECT
        block_date AS day,
        COUNT(DISTINCT addr) AS active_addresses
    FROM (
        SELECT block_date, "from" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          AND block_date >= CAST('2024-01-01' AS DATE)
        UNION
        SELECT block_date, "to" AS addr
        FROM tokens.transfers
        WHERE blockchain = 'bnb'
          AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
          AND block_date >= CAST('2024-01-01' AS DATE)
    ) u
    GROUP BY 1
),
daily_price AS (
    SELECT
        DATE_TRUNC('day', minute) AS day,
        AVG(price) AS price_usd
    FROM prices.usd
    WHERE blockchain = 'bnb'
      AND contract_address = 0x4b0f1812e5df2a09796481ff14017e6005508003
      AND minute >= CAST('2024-01-01' AS TIMESTAMP)
    GROUP BY 1
)
SELECT
    COALESCE(t.day, a.day) AS day,
    a.active_addresses,
    t.transfer_count,
    t.total_twt_transferred,
    t.total_usd_transferred,
    p.price_usd,
    -- Velocity = daily transfer volume / approx market cap
    -- Approx market cap = price * 1B (total supply)
    CASE
        WHEN p.price_usd > 0
        THEN t.total_twt_transferred / (1e9)
        ELSE NULL
    END AS velocity_index,
    AVG(
        CASE
            WHEN p.price_usd > 0
            THEN t.total_twt_transferred / (1e9)
            ELSE NULL
        END
    ) OVER (ORDER BY COALESCE(t.day, a.day) ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_velocity,
    AVG(CAST(a.active_addresses AS DOUBLE)) OVER (ORDER BY COALESCE(t.day, a.day) ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7_active_addresses
FROM daily_transfers t
FULL OUTER JOIN daily_active a ON t.day = a.day
LEFT JOIN daily_price p ON COALESCE(t.day, a.day) = p.day
WHERE COALESCE(t.day, a.day) IS NOT NULL
ORDER BY 1
```

---

## Section Text Widgets (Separators)

Between each section, add a **Text widget** as a visual separator. Here are the texts:

### Before Section 1 (after KPIs):
```
### Price & Market Dynamics
TWT daily price with 7-day and 30-day moving averages overlaid on DEX trading volume.
Divergence between price and volume trends often signals upcoming reversals.
```

### Before Section 2:
```
### DEX Trading Analytics
Buy vs sell pressure breakdown, unique trader growth, and DEX protocol market share.
The buy ratio indicates directional sentiment - sustained >55% signals accumulation phases.
```

### Before Section 3:
```
### Token Transfer Analysis
All on-chain TWT movements - including CEX deposits/withdrawals, OTC, staking, and P2P transfers.
Transfer size distribution reveals whether activity is retail-driven or whale-dominated.
```

### Before Section 4:
```
### Holder Dynamics
Net holder growth tracks the difference between new wallets acquiring TWT and wallets selling their entire position.
Consistent positive net growth during price dips signals strong hands accumulating.
```

### Before Section 5:
```
### Whale Tracker
Large transfers (>$50K USD) in the last 30 days. Whale movements to exchanges may signal selling pressure.
Movements to cold wallets or new addresses may indicate OTC deals or accumulation.
```

### Before Section 6:
```
### Network Health & Velocity
Token velocity measures how frequently TWT changes hands relative to total supply.
Rising velocity with stable price = healthy usage. Rising velocity with falling price = distribution.
Active address trends reveal organic network adoption independent of price action.
```

### Bottom Methodology:
```
### Methodology & Data Sources

**Data tables used:**
- `prices.usd` / `prices.usd_latest` - Token price feeds (CoinPaprika + DEX)
- `dex.trades` (blockchain = 'bnb') - DEX trade events (PancakeSwap, BiSwap, etc.)
- `tokens.transfers` (blockchain = 'bnb') - All BEP-20 transfer events
- TWT contract: `0x4b0f1812e5df2a09796481ff14017e6005508003`

**Definitions:**
- **Active Address:** Any address that sent or received TWT in the measured period
- **Whale Transfer:** Single transfer worth >= $50,000 USD
- **Token Velocity:** Daily TWT transferred / Total Supply (1B). Values >1 mean the entire supply theoretically changed hands
- **Buy Ratio:** Percentage of DEX volume where TWT was the token_bought (buying pressure)
- **Net Holder Growth:** New wallets acquiring TWT minus wallets emptying their entire TWT balance per day
- **Moving Averages:** 7-day simple moving averages (7d MA) smooth out daily noise

**Limitations:**
- Holder count is approximate (based on transfer events, not a full balance snapshot)
- CEX internal transfers are not visible on-chain
- Price data depends on Dune's price feed availability for TWT on BNB Chain
- Market cap uses total supply of 1B TWT (not circulating supply)

**Update frequency:** All queries use live on-chain data. Dashboard refreshes on each page load.
```

---

## Dashboard Visual Settings

### Color Palette
Use a consistent dark theme color palette across all charts:

| Element | Color | Hex |
|---------|-------|-----|
| Primary (price, main metric) | Blue | #3B82F6 |
| Positive / Buy | Green | #22C55E |
| Negative / Sell | Red | #EF4444 |
| Volume bars | Teal | #14B8A6 |
| Secondary metric | Purple | #8B5CF6 |
| Moving averages | White dashed | #FFFFFF |
| Whale/warning | Orange | #F59E0B |
| Neutral/micro | Gray | #6B7280 |

### Widget Sizing (12-column Dune grid)
| Widget | Width (columns) | Height |
|--------|----------------|--------|
| Header text | 12 | auto |
| Each KPI counter | 2-3 | small |
| Price & Volume chart | 12 | medium-large |
| Buy/Sell chart | 6 | medium |
| Unique Traders chart | 6 | medium |
| DEX Breakdown pie | 4 | medium |
| DEX Breakdown table | 8 | medium |
| Transfer Volume chart | 12 | medium |
| Transfer Size chart | 6 | medium |
| Holder Growth chart | 6 | medium |
| Holder Dist pie | 6 | medium |
| Whale Table | 12 | medium-large |
| Active Addresses chart | 6 | medium |
| Velocity chart | 6 | medium |
| Methodology text | 12 | auto |

---

## Step-by-Step Implementation Guide

### Step 1: Create Queries
1. Go to https://dune.com/queries
2. Click "New Query"
3. Copy-paste each query from above
4. Name each query clearly:
   - `TWT: Key Metrics Summary`
   - `TWT: Daily Price & Volume`
   - `TWT: Buy vs Sell Pressure`
   - `TWT: DEX Protocol Breakdown`
   - `TWT: Unique Traders (New vs Returning)`
   - `TWT: Transfer Volume & Count`
   - `TWT: Transfer Size Distribution`
   - `TWT: Holder Growth`
   - `TWT: Whale Tracker`
   - `TWT: Network Health & Velocity`
5. Run each query to verify it works
6. Save each query

### Step 2: Create Visualizations
For each query, create the visualizations as described:
1. Click "New visualization" on the query results
2. Select the chart type specified
3. Configure axes, colors, and formatting as described
4. Save the visualization

### Step 3: Build the Dashboard
1. Go to https://dune.com/bossincrypto/twt-analytics
2. Click "Edit"
3. Add widgets in the order shown in the Layout Map
4. For text widgets: Add > Text widget > paste the markdown content
5. For chart widgets: Add > Visualization > search for your saved query
6. Resize widgets according to the sizing table
7. Save the dashboard

### Step 4: Final Polish
- Ensure all counters show the correct column from Query 1
- Verify chart colors match the color palette
- Test that all queries execute without errors
- Check that the dashboard loads in < 30 seconds total
- Add the dashboard to your Dune profile

---

## Query Performance Notes

All queries are optimized for Dune's `small` engine:
- Partition filters (`blockchain`, `block_date`) are always included
- No unnecessary full table scans
- Date ranges are bounded (starting from 2024-01-01)
- Aggregations happen before joins
- Window functions use bounded frames (ROWS BETWEEN)

If any query times out on `small`, switch to `medium` engine. Query 8 (Holder Growth) is the heaviest - it may need `medium` on first run.

---

## Estimated Total Credits Per Full Refresh

| Query | Est. Credits |
|-------|-------------|
| Q1: Key Metrics | 3-5 |
| Q2: Price & Volume | 3-4 |
| Q3: Buy vs Sell | 3-4 |
| Q4: DEX Breakdown | 2-3 |
| Q5: Unique Traders | 4-6 |
| Q6: Transfer Analysis | 3-5 |
| Q7: Transfer Sizes | 3-4 |
| Q8: Holder Growth | 5-8 |
| Q9: Whale Tracker | 2-3 |
| Q10: Network Health | 4-6 |
| **Total** | **~32-48** |
