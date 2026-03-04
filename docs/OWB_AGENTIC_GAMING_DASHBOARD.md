# OWB Agentic Gaming — Dune Analytics Dashboard

> **Full implementation guide for building the Base Agentic Gaming & OWB dashboard on [dune.com](https://dune.com)**
>
> Dashboard URL (target): `https://dune.com/ax1research/base-agentic-gaming`
>
> Chain: **Base** · Last updated: March 2026

---

## Table of Contents

1. [Dashboard Overview](#1-dashboard-overview)
2. [Contract Registry](#2-contract-registry)
3. [Section 1–2: Ecosystem Overview](#3-sections-1-2-ecosystem-overview)
4. [Section 3: Base Agentic Gaming (2 queries)](#4-section-3-base-agentic-gaming)
5. [Section 4: OWB Agentic Gaming](#5-section-4-owb-agentic-gaming)
   - [4A: MRR (Monthly Recurring Revenue)](#4a-mrr-monthly-recurring-revenue)
   - [4B: Number of Bots (+ 3 sub-indicators)](#4b-number-of-bots)
   - [4C: Transactional Activity](#4c-transactional-activity)
6. [Section 5: Deep Analytics](#6-section-5-deep-analytics)
7. [Dashboard Layout Map](#7-dashboard-layout-map)
8. [Visualization Configuration](#8-visualization-configuration)
9. [Step-by-Step Setup on dune.com](#9-step-by-step-setup)
10. [Color Palette & Styling](#10-color-palette--styling)

---

## 1. Dashboard Overview

This dashboard provides a comprehensive analytics suite for **OWB (Clash of Coins)** and the broader **Base Agentic Gaming** ecosystem. It tracks:

- **Ecosystem health**: transactions, users, holder growth, DEX volume
- **Emerging agentic gaming projects** on Base (Section 3)
- **OWB deep dive** with MRR, bot metrics, and transaction analytics (Section 4)
- **Liquidity, holder distribution, and in-game economy** (Section 5)

### Dashboard Sections at a Glance

| Section | Focus | Queries |
|---------|-------|---------|
| 1–2 | Ecosystem Overview & KPIs | 2 |
| 3 | Base Agentic Gaming (emerging projects) | 2 |
| 4 | OWB Agentic Gaming (MRR, Bots, Txs) | 5 |
| 5 | Deep Analytics (Holders, Liquidity, In-Game) | 4 |
| **Total** | | **13 queries** |

---

## 2. Contract Registry

All addresses verified on BaseScan (March 2026). These are the contracts tracked across the dashboard.

### OWB Ecosystem

| Contract | Address | Purpose |
|----------|---------|---------|
| **OWB Token** | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | ERC-20 governance/utility token |
| **Staking** | `0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb` | OWB staking with dynamic APY |
| **Rewards Claim** | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | Claim rewards from Clash of Coins |
| **COC Token** | `0x4c3DEa2858e66c1e116b1eB54b4404025F84cFE9` | In-game currency (Clash of Coins) |
| **oCOIN Token** | `0x5B8F638330d7D6bD9D43811fe702F6894e97EF03` | Secondary in-game token |
| **Uniswap V3 Pool** | `0xf252f51919dfca2c9c0ea279f11183580edee4d6` | OWB/USDC 0.01% fee tier |
| **Aerodrome Pool** | `0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD` | OWB/USDC AMM pool |

### Base Agentic Gaming (Emerging)

| Contract | Address | Project |
|----------|---------|---------|
| **Last AI Standing** | `0x5e9e09b03d08017fddbc1652e9394e7cb4a24074` | Survival game for AI agents |

### Reference Tokens

| Token | Address |
|-------|---------|
| **USDC (Base)** | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` |

---

## 3. Sections 1–2: Ecosystem Overview

### Query 1: OWB Overview KPIs

**File:** `queries/owb-gaming-dashboard/01_owb_overview_kpis.sql`

**Purpose:** Top-level counters for the dashboard header — price, FDV, total transactions, unique wallets, holders, DEX volume, week-over-week growth, staking and claims activity.

**Visualization:** Split into **8 counter widgets** (see layout map below).

| Counter | Column | Data Field | Format |
|---------|--------|------------|--------|
| OWB Price | `OWB Price (USD)` | `$0.0000` | 6 decimals |
| FDV | `Fully Diluted Valuation` | `$0` | Abbreviated (e.g., $85M) |
| YTD Transactions | `Total Txs (2026 YTD)` | Number | Thousands separator |
| Unique Wallets | `Unique Wallets (YTD)` | Number | Thousands separator |
| Holders | `Total Holders` | Number | Thousands separator |
| DEX Volume 30d | `DEX Volume (30d USD)` | `$0` | Abbreviated |
| WoW Txs Growth | `WoW Txs Growth %` | `+0.0%` | Green if positive, Red if negative |
| WoW Users Growth | `WoW Users Growth %` | `+0.0%` | Green if positive, Red if negative |

---

### Query 2: OWB Daily Activity

**File:** `queries/owb-gaming-dashboard/02_owb_daily_activity.sql`

**Purpose:** Daily time series of contract transactions, DEX volume, and users across all OWB contracts. Includes 7d moving averages and cumulative totals.

**Visualizations:**

1. **Line Chart — "OWB Daily Transactions & 7d MA"**
   - X-axis: `day`
   - Y-axis (left): `Contract Transactions` (bar, color: `#8B5CF6`)
   - Y-axis (right): `Contract Txs 7d MA` (line, color: `#F59E0B`, line width: 2)
   - Chart height: 300px

2. **Area Chart — "OWB Cumulative Growth"**
   - X-axis: `day`
   - Y1: `Cumulative Contract Txs` (area, color: `#3B82F6`)
   - Y2: `Cumulative DEX Volume` (line, color: `#F59E0B`)

3. **Stacked Bar — "Transaction Breakdown by Type"**
   - X-axis: `day`
   - Stacked bars: `Token Txs` (#8B5CF6), `Gaming (Claims) Txs` (#10B981), `Staking Txs` (#3B82F6)

---

## 4. Section 3: Base Agentic Gaming

> **Constraint: Maximum 2 queries for this section.**
>
> This section tracks emerging agentic gaming projects on Base. As of March 2026, the key projects are:
>
> - **Last AI Standing** — Survival game where AI agents pay USDC to stay alive; last agent wins the pot
> - **OWB / Clash of Coins** — GameFi with AI mascot Kaira; staking, rewards, and 450K+ users
>
> Additional projects expected in coming weeks: Agent Arena, SpaceMolt, DX Terminal Pro (DXRG)

### Query 11: Emerging Projects Tracker

**File:** `queries/owb-gaming-dashboard/11_base_agentic_gaming_emerging.sql`

**Purpose:** Comparative table of all tracked agentic gaming contracts — total transactions, unique users, 7d/30d activity, week-over-week growth, and Activity Score.

**Activity Score Formula** (from AGENTS.md):
```
Score = 55% × (project_txs_30d / max_txs_30d) + 45% × (project_users_30d / max_users_30d)
```

**Visualization: Sortable Table**

| Column | Format | Notes |
|--------|--------|-------|
| Project | Text | Project name |
| Category | Text | Game type tag |
| Total Txs (All Time) | Number | Thousands separator |
| Users (30d) | Number | |
| Txs (7d) | Number | |
| WoW Growth % | Percentage | Color: green (+) / red (-) |
| First Seen | Date | |
| Activity Score | Number (1 decimal) | Bold, color gradient |

**Table Configuration:**
- Sort default: Activity Score DESC
- Conditional formatting on "WoW Growth %" and "Activity Score"
- Row highlight on hover

### Query 12: Daily Activity Trends

**File:** `queries/owb-gaming-dashboard/12_base_agentic_gaming_daily.sql`

**Purpose:** Daily transaction trends across all gaming contracts with per-project breakdown and 7d moving averages.

**Visualization: Stacked Area Chart — "Base Agentic Gaming Daily Activity"**

| Series | Color | Type |
|--------|-------|------|
| OWB Token Txs | `#8B5CF6` (Purple) | Stacked area |
| CoC Rewards Txs | `#10B981` (Green) | Stacked area |
| OWB Staking Txs | `#3B82F6` (Blue) | Stacked area |
| Last AI Standing Txs | `#F59E0B` (Amber) | Stacked area |
| Gaming Txs 7d MA | `#EF4444` (Red) | Line overlay, dashed |

- X-axis: `day`
- Chart height: 350px

---

## 5. Section 4: OWB Agentic Gaming

This is the deepest section of the dashboard, containing three key metric groups:

### 4A: MRR (Monthly Recurring Revenue)

### Query 10: MRR Proxy

**File:** `queries/owb-gaming-dashboard/10_owb_mrr_proxy.sql`

**Purpose:** Estimates Monthly Recurring Revenue from:
1. **LP Fee Revenue** — trading fees generated on Uniswap V3 and Aerodrome pools (estimated at 0.2% average across fee tiers)
2. **Gas Revenue** — ETH gas spent on staking and claiming operations (converted to USD at ~$2000/ETH)
3. **Token Transfer Activity** — volume of OWB transferred outside of pools/staking (game economy proxy)

**Visualizations:**

1. **Grouped Bar Chart — "Monthly Revenue Components"**
   - X-axis: `Month`
   - Bars: `Est LP Fee Revenue (USD)` (#F59E0B), `Staking Txs` (#3B82F6), `Claim Txs` (#10B981)
   - Chart height: 350px

2. **Line Chart — "MRR Trend"**
   - X-axis: `Month`
   - Y: `Est Total Monthly Revenue (USD)` (line, color: `#F59E0B`, line width: 3)
   - Secondary line: `MoM Activity Growth %` (dashed, color: `#EF4444`)

3. **Counter Widgets (current month):**
   - "Current Month DEX Volume" → latest `DEX Volume (USD)`
   - "Unique Stakers This Month" → latest `Unique Stakers`
   - "Unique Claimers This Month" → latest `Unique Claimers`
   - "MoM Growth" → latest `MoM Activity Growth %`

---

### 4B: Number of Bots

The "Number of Bots" metric uses **3 complementary indicators**:

#### Indicator 1: Bot Classification Summary (Query 8)

**File:** `queries/owb-gaming-dashboard/08_owb_bot_metrics.sql`

**Purpose:** Classifies all wallets interacting with OWB contracts into behavior types:
- **High-Frequency Bot**: 50+ claims, avg interval < 15 min
- **Semi-Automated**: 20+ claims, avg interval < 1 hour
- **Active Player**: 10+ claims
- **Casual Player**: 3+ claims
- **One-Time User**: fewer than 3 claims

**Visualization: Horizontal Bar Chart — "Wallet Classification by Behavior"**

| Series | Color |
|--------|-------|
| High-Frequency Bot | `#EF4444` (Red) |
| Semi-Automated | `#F59E0B` (Amber) |
| Active Player | `#10B981` (Green) |
| Casual Player | `#3B82F6` (Blue) |
| One-Time User | `#8B5CF6` (Purple) |

- X-axis: `Wallet Count`
- Y-axis: `Behavior Type`
- Data labels: show both count and "% of All Wallets"

**Counter Widgets:**
- "Total Identified Bots" → sum of High-Frequency Bot + Semi-Automated wallet counts
- "Bot Claim Share" → sum of their "% of All Claims"

#### Indicator 2: Bot Activity Daily Trend (Query 9)

**File:** `queries/owb-gaming-dashboard/09_owb_bot_daily_trend.sql`

**Purpose:** Daily breakdown of claims by wallet type (Bot / Semi-Auto / Human), showing how automated activity evolves over time.

**Visualization: Stacked Area Chart — "Bot vs Human Claims Over Time"**

| Series | Color |
|--------|-------|
| Bot | `#EF4444` (Red) |
| Semi-Auto | `#F59E0B` (Amber) |
| Human | `#10B981` (Green) |

- X-axis: `day`
- Y-axis: `Claims` (stacked)
- Chart height: 300px

#### Indicator 3: Top Bot Wallets (Query 13)

**File:** `queries/owb-gaming-dashboard/13_owb_bot_top_wallets.sql`

**Purpose:** Detailed table of the top 100 most active wallets with their classification, transaction breakdown, and activity patterns.

**Visualization: Sortable Table**

| Column | Format |
|--------|--------|
| Wallet | Truncated address with link |
| Classification | Badge (colored) |
| Total Txs | Number |
| Active Days | Number |
| Txs/Active Day | Number (1 decimal) |
| Claims / Staking / Token Txs | Number |
| Avg Interval (sec) | Number |
| First Seen / Last Active | Date |

- Sort default: Total Txs DESC
- Conditional formatting: Red rows for "High-Frequency Bot", Amber for "Semi-Automated"

#### Bonus Indicator: Activity Heatmap (Query 14)

**File:** `queries/owb-gaming-dashboard/14_owb_bot_hourly_heatmap.sql`

**Purpose:** Hour-of-day × day-of-week activity patterns. Bots show uniform 24/7 patterns while humans cluster in timezone-specific hours.

**Visualization: Heatmap** (if supported) or **Grouped Bar Chart**
- X-axis: `Hour (UTC)`
- Series: `Bot`, `Semi-Auto`, `Human`
- Alternative: Pivot table with days as rows, hours as columns, colored by intensity

---

### 4C: Transactional Activity

### Query 3: DEX Trading Analytics

**File:** `queries/owb-gaming-dashboard/03_owb_dex_analytics.sql`

**Purpose:** Daily buy vs sell volume, net flow, trader counts, price range, and trade sizes. Provides trading pressure analysis.

**Visualizations:**

1. **Dual Bar Chart — "Buy vs Sell Volume"**
   - X-axis: `day`
   - Green bars (up): `Buy Volume (USD)`
   - Red bars (down): `Sell Volume (USD)`
   - Line overlay: `Volume 7d MA` (#F59E0B)

2. **Line Chart — "OWB Price & Net Flow"**
   - X-axis: `day`
   - Y (left): `Avg Price (USD)` (line, #8B5CF6)
   - Y (right): `Net Flow (USD)` (bar, green if positive, red if negative)

3. **Counter Widgets:**
   - "Buy Ratio (30d)" → latest rolling average of `Buy Ratio %`
   - "Avg Trade Size" → latest `Avg Trade Size (USD)`
   - "Total Unique Traders (30d)" → latest `Total Unique Traders`

### Query 4: Staking & Claims

**File:** `queries/owb-gaming-dashboard/04_owb_staking_and_claims.sql`

**Purpose:** Tracks staking deposits/withdrawals, rewards claims, and net staking flow over time.

**Visualizations:**

1. **Dual Area Chart — "Staking Flow"**
   - X-axis: `day`
   - Positive area (green): `OWB Staked (Daily)`
   - Negative area (red): `OWB Unstaked (Daily)`
   - Line: `Cumulative Net Staking` (#3B82F6)

2. **Bar Chart — "Claims Activity"**
   - X-axis: `day`
   - Bars: `Claim Transactions` (#10B981)
   - Line overlay: `Cumulative Claims` (#F59E0B)

---

## 6. Section 5: Deep Analytics

### Query 5: Holder Dynamics

**File:** `queries/owb-gaming-dashboard/05_owb_holder_dynamics.sql`

**Purpose:** Daily new holder growth, cumulative total, and 7d moving average.

**Visualization: Area + Line Chart — "OWB Holder Growth"**
- X-axis: `day`
- Area: `New Holders` (fill: `#10B981`, opacity: 0.3)
- Line: `Cumulative Holders` (color: `#3B82F6`, right Y-axis)
- Dashed line: `New Holders 7d MA` (color: `#F59E0B`)

### Query 6: Holder Distribution

**File:** `queries/owb-gaming-dashboard/06_owb_holder_distribution.sql`

**Purpose:** Holder concentration analysis by bucket size (Dust → Mega Whale).

**Visualizations:**

1. **Pie Chart — "Supply Distribution by Holder Size"**
   - Slices: `Holder Bucket`
   - Values: `% of Supply`
   - Colors: gradient from `#3B82F6` (smallest) to `#EF4444` (largest)

2. **Horizontal Bar — "Number of Holders by Bucket"**
   - X: `Number of Holders`
   - Y: `Holder Bucket`

### Query 7: Liquidity & TVL

**File:** `queries/owb-gaming-dashboard/07_owb_liquidity_tvl.sql`

**Purpose:** Tracks USDC and OWB reserves in both liquidity pools, with TVL calculation.

**Visualization: Stacked Area — "OWB Liquidity Pool TVL"**
- X-axis: `day`
- Stacked areas: Uniswap V3 TVL (#3B82F6), Aerodrome TVL (#8B5CF6)
- Line: Total TVL (#F59E0B)

### Query 15: In-Game Economy

**File:** `queries/owb-gaming-dashboard/15_owb_coc_ingame_economy.sql`

**Purpose:** Tracks COC and oCOIN in-game token transfers, showing game economy health.

**Visualization: Dual Line Chart — "In-Game Economy Activity"**
- X-axis: `day`
- Y (left): `COC Transfers` (line, #10B981), `oCOIN Transfers` (line, #8B5CF6)
- Y (right): `Cumulative In-Game Txs` (area, #F59E0B, opacity: 0.2)

---

## 7. Dashboard Layout Map

The dashboard uses a **16-row layout** with widgets placed across 1–3 columns per row.

```
┌──────────────────────────────────────────────────────────────┐
│ ROW 0: Text Widget — Dashboard Title & Description           │
│ "OWB Agentic Gaming — Base Analytics Dashboard"              │
│ Subtitle with last-updated date and chain info               │
├──────────────────────────────────────────────────────────────┤
│ ROW 1: 4 Counter Widgets (Query 1)                           │
│ [OWB Price] [FDV] [Total Holders] [DEX Volume 30d]          │
├──────────────────────────────────────────────────────────────┤
│ ROW 2: 4 Counter Widgets (Query 1)                           │
│ [YTD Txs] [Unique Wallets] [WoW Txs Growth] [WoW Users]    │
├──────────────────────────────────────────────────────────────┤
│ ROW 3: Line Chart — OWB Daily Txs & 7d MA (Query 2)         │
│ Full width                                                    │
├──────────────────────────────────────────────────────────────┤
│ ROW 4: 2 Charts (Query 2)                                    │
│ [Cumulative Growth — Area] [Tx Breakdown by Type — Stacked]  │
├──────────────────────────────────────────────────────────────┤
│ ROW 5: Text Widget — "Section 3: Base Agentic Gaming"        │
├──────────────────────────────────────────────────────────────┤
│ ROW 6: Table — Emerging Projects Tracker (Query 11)          │
│ Full width                                                    │
├──────────────────────────────────────────────────────────────┤
│ ROW 7: Stacked Area — Gaming Daily Activity (Query 12)       │
│ Full width                                                    │
├──────────────────────────────────────────────────────────────┤
│ ROW 8: Text Widget — "Section 4: OWB Agentic Gaming"         │
├──────────────────────────────────────────────────────────────┤
│ ROW 9: 4 Counters — MRR Quick Stats (Query 10)               │
│ [DEX Vol] [Stakers] [Claimers] [MoM Growth]                 │
├──────────────────────────────────────────────────────────────┤
│ ROW 10: 2 Charts — MRR Deep Dive (Query 10)                  │
│ [Monthly Revenue Bars] [MRR Trend Line]                      │
├──────────────────────────────────────────────────────────────┤
│ ROW 11: 2 Counters + Horizontal Bar — Bot Metrics (Query 8)  │
│ [Total Bots counter] [Bot Claim Share] [Classification Bar]  │
├──────────────────────────────────────────────────────────────┤
│ ROW 12: 2 Charts — Bot Trends (Query 9 + Query 14)           │
│ [Bot vs Human Claims — Stacked Area] [Hourly Heatmap]        │
├──────────────────────────────────────────────────────────────┤
│ ROW 13: Table — Top Bot Wallets (Query 13)                   │
│ Full width                                                    │
├──────────────────────────────────────────────────────────────┤
│ ROW 14: 2 Charts — DEX & Staking (Query 3 + Query 4)         │
│ [Buy vs Sell Volume] [Staking Flow]                          │
├──────────────────────────────────────────────────────────────┤
│ ROW 15: 3 Charts — Deep Analytics (Query 5 + 6 + 7)          │
│ [Holder Growth] [Distribution Pie] [TVL Trend]               │
├──────────────────────────────────────────────────────────────┤
│ ROW 16: Line Chart — In-Game Economy (Query 15)              │
│ Full width                                                    │
├──────────────────────────────────────────────────────────────┤
│ ROW 17: Text Widget — Methodology & Data Sources              │
└──────────────────────────────────────────────────────────────┘
```

---

## 8. Visualization Configuration

### Counter Widget Settings

All counter widgets should use:
- **Font size:** Large
- **Prefix:** `$` for USD values, none for counts
- **Suffix:** `%` for percentage values
- **Decimal places:** 0 for counts, 2 for USD, 6 for price
- **Thousands separator:** Yes
- **Conditional coloring:** Green for positive growth, Red for negative

### Chart Settings

| Chart Type | Grid Lines | Legend | Tooltip | Height |
|-----------|------------|--------|---------|--------|
| Line | Yes (Y only) | Bottom | Crosshair | 300px |
| Area | Yes (Y only) | Bottom | Crosshair | 300px |
| Bar | Yes (Y only) | Bottom | Hover | 300px |
| Stacked Area | Yes (Y only) | Bottom | Crosshair | 350px |
| Pie | No | Right | Hover | 300px |
| Table | N/A | N/A | N/A | Auto |

### Date Formatting
- X-axis: `MMM DD` (e.g., "Mar 04")
- Counters: ISO date
- Tables: `YYYY-MM-DD`

---

## 9. Step-by-Step Setup on dune.com

### Phase 1: Create All Queries

1. **Log in** to [dune.com](https://dune.com) and navigate to **New Query** (top-right "+" button).

2. **For each query file** in `queries/owb-gaming-dashboard/`:
   - Click **"New Query"**
   - Copy the SQL from the file and paste into the query editor
   - Set the **Engine** to **DuneSQL** (default)
   - Click **"Run"** to verify the query executes successfully
   - Click **"Save"** and name it using the title from the SQL file header comment (e.g., "OWB Gaming - Overview KPIs")
   - Note: Queries will take 10-60 seconds to run depending on complexity

3. **Query creation order** (recommended):
   ```
   01_owb_overview_kpis.sql          → "OWB Gaming - Overview KPIs"
   02_owb_daily_activity.sql         → "OWB Gaming - Daily Activity"
   03_owb_dex_analytics.sql          → "OWB Gaming - DEX Analytics"
   04_owb_staking_and_claims.sql     → "OWB Gaming - Staking & Claims"
   05_owb_holder_dynamics.sql        → "OWB Gaming - Holder Dynamics"
   06_owb_holder_distribution.sql    → "OWB Gaming - Holder Distribution"
   07_owb_liquidity_tvl.sql          → "OWB Gaming - Liquidity & TVL"
   08_owb_bot_metrics.sql            → "OWB Gaming - Bot Metrics"
   09_owb_bot_daily_trend.sql        → "OWB Gaming - Bot Daily Trend"
   10_owb_mrr_proxy.sql              → "OWB Gaming - MRR Proxy"
   11_base_agentic_gaming_emerging.sql → "Base Agentic Gaming - Emerging Projects"
   12_base_agentic_gaming_daily.sql  → "Base Agentic Gaming - Daily Activity"
   13_owb_bot_top_wallets.sql        → "OWB Gaming - Top Bot Wallets"
   14_owb_bot_hourly_heatmap.sql     → "OWB Gaming - Activity Heatmap"
   15_owb_coc_ingame_economy.sql     → "OWB Gaming - In-Game Economy"
   ```

4. **Set query schedules** (optional but recommended):
   - Queries 1, 2, 3, 4: **Every 6 hours** (high-activity data)
   - Queries 5, 6, 7: **Every 24 hours** (slow-changing data)
   - Queries 8–15: **Every 12 hours** (medium-frequency)

### Phase 2: Create Visualizations

For each saved query, create the appropriate visualizations:

1. Open the saved query and click **"New visualization"**
2. Select the visualization type from the table below
3. Configure axes, colors, and labels as specified in Section 8
4. **Name each visualization** clearly (it will appear on the dashboard)

**Visualization List (in order of creation):**

| # | Query | Viz Name | Type |
|---|-------|----------|------|
| V1 | Q1 | OWB Price | Counter |
| V2 | Q1 | FDV | Counter |
| V3 | Q1 | Total Holders | Counter |
| V4 | Q1 | DEX Volume (30d) | Counter |
| V5 | Q1 | YTD Transactions | Counter |
| V6 | Q1 | Unique Wallets | Counter |
| V7 | Q1 | WoW Txs Growth | Counter |
| V8 | Q1 | WoW Users Growth | Counter |
| V9 | Q2 | Daily Txs & 7d MA | Mixed (Bar + Line) |
| V10 | Q2 | Cumulative Growth | Area Chart |
| V11 | Q2 | Tx Breakdown by Type | Stacked Bar |
| V12 | Q11 | Emerging Projects Table | Table |
| V13 | Q12 | Gaming Daily Activity | Stacked Area |
| V14 | Q10 | Current DEX Volume | Counter |
| V15 | Q10 | Unique Stakers | Counter |
| V16 | Q10 | Unique Claimers | Counter |
| V17 | Q10 | MoM Growth | Counter |
| V18 | Q10 | Monthly Revenue Bars | Grouped Bar |
| V19 | Q10 | MRR Trend | Line Chart |
| V20 | Q8 | Total Identified Bots | Counter |
| V21 | Q8 | Bot Claim Share | Counter |
| V22 | Q8 | Wallet Classification | Horizontal Bar |
| V23 | Q9 | Bot vs Human Claims | Stacked Area |
| V24 | Q14 | Activity Heatmap | Grouped Bar |
| V25 | Q13 | Top Bot Wallets | Table |
| V26 | Q3 | Buy vs Sell Volume | Dual Bar |
| V27 | Q3 | Price & Net Flow | Mixed (Line + Bar) |
| V28 | Q4 | Staking Flow | Dual Area |
| V29 | Q4 | Claims Activity | Bar + Line |
| V30 | Q5 | Holder Growth | Area + Line |
| V31 | Q6 | Supply Distribution | Pie Chart |
| V32 | Q7 | Liquidity Pool TVL | Stacked Area |
| V33 | Q15 | In-Game Economy | Dual Line |

### Phase 3: Build the Dashboard

1. Go to **dune.com** → **Dashboards** → **New Dashboard**
2. Name it: **"OWB Agentic Gaming — Base Analytics"**
3. Set the **description**:
   ```
   Comprehensive analytics for OWB (Clash of Coins) and emerging Base Agentic Gaming projects.
   Tracks MRR, bot activity, DEX trading, staking, holder dynamics, and in-game economy.
   Chain: Base | Data sources: base.transactions, dex.trades, tokens.transfers, prices.usd_latest
   ```

4. **Add widgets row by row** following the Layout Map in Section 7:

   **ROW 0 — Title:**
   - Add **Text Widget**
   - Markdown content:
     ```markdown
     # OWB Agentic Gaming — Base Analytics Dashboard
     
     Real-time analytics for the OWB (Clash of Coins) ecosystem and emerging
     Base Agentic Gaming projects. Tracking MRR, bot metrics, DEX activity,
     staking dynamics, and in-game economy health.
     
     **Chain:** Base · **Token:** OWB (`0xEF59...b3c1`) · **Data:** Updated every 6h
     ```

   **ROW 1 — KPI Counters (first row):**
   - Add V1 (OWB Price), V2 (FDV), V3 (Total Holders), V4 (DEX Volume 30d)
   - Set all to 1/4 width

   **ROW 2 — KPI Counters (second row):**
   - Add V5 (YTD Txs), V6 (Unique Wallets), V7 (WoW Txs Growth), V8 (WoW Users Growth)
   - Set all to 1/4 width

   **ROW 3 — Daily Activity Chart:**
   - Add V9 (Daily Txs & 7d MA) — full width

   **ROW 4 — Supplementary Charts:**
   - Add V10 (Cumulative Growth) — 1/2 width
   - Add V11 (Tx Breakdown) — 1/2 width

   **ROW 5 — Section 3 Header:**
   - Add **Text Widget**:
     ```markdown
     ## Section 3: Base Agentic Gaming
     
     Tracking emerging agentic gaming projects on Base. These projects feature
     AI agents as primary participants — playing games, making strategic decisions,
     and transacting autonomously on-chain.
     ```

   **ROW 6 — Emerging Projects Table:**
   - Add V12 (Emerging Projects Table) — full width

   **ROW 7 — Gaming Daily Trends:**
   - Add V13 (Gaming Daily Activity) — full width

   **ROW 8 — Section 4 Header:**
   - Add **Text Widget**:
     ```markdown
     ## Section 4: OWB Agentic Gaming
     
     Deep dive into OWB (Clash of Coins) with three key metrics:
     **MRR** (Monthly Recurring Revenue) · **Bots** (Automated Activity) · **Transactions** (On-chain Activity)
     
     OWB Studio targets 100M users with Kaira AI — an always-on AI mascot
     streaming gameplay on Twitch/Discord 24/7.
     ```

   **ROW 9 — MRR Counters:**
   - Add V14, V15, V16, V17 — 1/4 width each

   **ROW 10 — MRR Charts:**
   - Add V18 (Monthly Revenue Bars) — 1/2 width
   - Add V19 (MRR Trend) — 1/2 width

   **ROW 11 — Bot Summary:**
   - Add V20 (Total Bots counter) — 1/4 width
   - Add V21 (Bot Claim Share counter) — 1/4 width
   - Add V22 (Classification Bar) — 1/2 width

   **ROW 12 — Bot Trends:**
   - Add V23 (Bot vs Human Claims) — 1/2 width
   - Add V24 (Activity Heatmap) — 1/2 width

   **ROW 13 — Top Bots Table:**
   - Add V25 (Top Bot Wallets) — full width

   **ROW 14 — Transaction Analytics:**
   - Add V26 (Buy vs Sell Volume) — 1/2 width
   - Add V28 (Staking Flow) — 1/2 width

   **ROW 15 — Deep Analytics:**
   - Add V30 (Holder Growth) — 1/3 width
   - Add V31 (Supply Distribution Pie) — 1/3 width
   - Add V32 (Liquidity TVL) — 1/3 width

   **ROW 16 — In-Game Economy:**
   - Add V33 (In-Game Economy) — full width

   **ROW 17 — Methodology:**
   - Add **Text Widget**:
     ```markdown
     ## Methodology & Data Sources
     
     **Data Tables Used:**
     - `base.transactions` — All Base mainnet transactions
     - `dex.trades` — Spellbook-curated DEX trade data
     - `tokens.transfers` — ERC-20 token transfer events
     - `prices.usd_latest` — Latest token prices
     
     **Bot Classification Criteria:**
     - High-Frequency Bot: 50+ claims with <15 min average interval
     - Semi-Automated: 20+ claims with <1 hour average interval
     - Active/Casual/One-Time: classified by claim count
     
     **MRR Estimation:**
     Revenue is estimated from LP trading fees (0.2% average across
     fee tiers) plus gas costs of staking/claiming operations.
     This is a proxy metric — actual protocol revenue may differ.
     
     **Activity Score:** `55% × normalized_txs + 45% × normalized_users`
     
     **Contracts Tracked:**
     - OWB Token: `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1`
     - Staking: `0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb`
     - Rewards: `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40`
     - COC: `0x4c3DEa2858e66c1e116b1eB54b4404025F84cFE9`
     - oCOIN: `0x5B8F638330d7D6bD9D43811fe702F6894e97EF03`
     - Last AI Standing: `0x5e9e09b03d08017fddbc1652e9394e7cb4a24074`
     ```

5. **Save the dashboard** and set visibility to **Public**.

### Phase 4: Polish & Schedule

1. **Review all widgets** — ensure titles, colors, and data labels are correct
2. **Enable auto-refresh** on the dashboard (set to 6 hours)
3. **Add dashboard tags**: `base`, `gaming`, `agentic`, `owb`, `defi`
4. **Share the URL** with stakeholders

---

## 10. Color Palette & Styling

Consistent with the project's AGENTS.md color system:

| Use Case | Color | Hex |
|----------|-------|-----|
| Infrastructure / DeFi | Blue | `#3B82F6` |
| Consumer / Token | Purple | `#8B5CF6` |
| Growth / Gaming / Positive | Green | `#10B981` |
| Volume / Money / Warning | Amber | `#F59E0B` |
| Decline / Bots / Negative | Red | `#EF4444` |
| Background (dark mode) | Dark Gray | `#1F2937` |
| Text (dark mode) | White | `#F9FAFB` |

### Typography
- Dashboard title: H1
- Section headers: H2
- Widget titles: Default (auto from Dune)
- Counter values: Large font

### Spacing
- Gap between widgets: Default Dune spacing
- Section dividers: Text widgets with H2 headers
- Full-width charts for main metrics, half-width for comparisons

---

## Appendix: Adding New Projects

When new agentic gaming projects launch on Base, update the dashboard by:

1. **Verify** the contract address on BaseScan
2. **Add** the address to the `gaming_contracts` CTE in queries 11 and 12
3. **Re-run** both queries to include the new project
4. The table and charts will automatically pick up the new data

Example addition:
```sql
-- Add to gaming_contracts CTE in queries 11 and 12:
(0xNEW_CONTRACT_ADDRESS, 'New Project Name', 'Game Category'),
```

---

*Dashboard designed for the [base-agentic-ecosystem](https://github.com/BOSSincrypto/base-agentic-ecosystem) repository.*
*Research and queries by Devin AI — March 2026.*
