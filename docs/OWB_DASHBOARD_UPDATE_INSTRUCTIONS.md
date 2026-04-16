# OWB Agentic Gaming Dashboard - Update Instructions

> **Full guide for updating the dashboard on Dune Analytics**
>
> Dashboard URL: `https://dune.com/bossincrypto/owb-token-analytics-base-onewayblock`
>
> Repository: `https://github.com/BOSSincrypto/base-agentic-ecosystem`
>
> Updated: April 2026

---

## Table of Contents

1. [Summary of Changes](#1-summary-of-changes)
2. [Critical Fixes](#2-critical-fixes)
3. [Full Query List (18 total)](#3-full-query-list)
4. [New Queries (3)](#4-new-queries)
5. [Dune Update Instructions](#5-dune-update-instructions)
6. [Visualization Setup](#6-visualization-setup)
7. [Updated Dashboard Layout Map](#7-layout-map)
8. [Color Palette](#8-color-palette)
9. [Query Refresh Schedule](#9-query-refresh-schedule)
10. [Contract Registry](#10-contract-registry)

---

## 1. Summary of Changes

### Fixed 13 of 15 existing queries + added 3 new ones

| Change Type | Count | Queries |
|------------|-------|---------|
| **Critical bugs** | 4 | 01, 02, 04, 10 |
| **Medium bugs** | 5 | 05, 08, 09, 11-15 |
| **Start date fix** | 7 | 01, 02, 04, 07, 08, 09, 10 |
| **No changes needed** | 2 | 03, 06 |
| **New queries** | 3 | 16, 17, 18 |

### Key Changes:

1. **Fixed staking address** - was `0x98430ECBe...` (that is Agentic Claim 1!), now `0x692d11c779d43BBC12Cb8565C7f71a54A47D117c` (real staking)
2. **Added Agentic Claim 2** - `0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203` (was missing from all queries)
3. **Fixed WoW formula** - was tied to calendar week (`date_trunc('week')`), replaced with rolling 7d windows
4. **Fixed start date** - was `2026-01-01`, now `2026-03-25` (agentic presale launch)
5. **Renamed "Bot" metrics to "DTU"** - Daily Transacting Users (less negative terminology)
6. **Completely rewrote Query 10 (MRR)** - now tracks real revenue: NFT Sales + Treasury USDC + LP Fees
7. **Added 3 new queries** - Retention (16), NFT Purchases (17), Agentic Passes (18)

---

## 2. Critical Fixes

### Bug #1: Wrong staking address (CRITICAL)

**Affected:** Queries 01, 02, 04, 10

**Before:**
```
0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb -> labeled as "Staking"
```

**After:**
```
0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb -> "Agentic Claim 1"
0x692d11c779d43BBC12Cb8565C7f71a54A47D117c -> "Staking" (correct address)
```

**Impact:** All staking metrics were showing agentic claims data instead of real staking. FDV, APY, staker counts - all were wrong.

---

### Bug #2: Missing Agentic Claim 2 (CRITICAL)

**Affected:** Queries 01, 02, 04, 08, 09, 13, 14

**Before:** Only one claims contract
```
0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb (Agentic Claim 1)
```

**After:** Two contracts
```
0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb (Agentic Claim 1)
0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203 (Agentic Claim 2)
```

**Impact:** Part of agentic claims activity was not counted - understated metrics.

---

### Bug #3: WoW formula breaks early in the week

**Affected:** Query 01

**Before:**
```sql
WHERE t.block_time >= date_trunc('week', now())
-- On Monday morning: compares 0 days with full previous week -> -99%
```

**After:**
```sql
-- Rolling 7-day windows
current_7d: now() - interval '7' day  ->  now()
prev_7d:    now() - interval '14' day ->  now() - interval '7' day
```

---

### Bug #4: MRR was counting DEX volume instead of real revenue

**Affected:** Query 10

**Before:** Staking txs + Claims txs + DEX volume = "MRR" (meaningless metric)

**After:** NFT Sales (USDC) + Treasury (USDC) + LP Fees (0.2% of DEX volume) = Revenue Proxy

---

## 3. Full Query List (18 total)

### Section 1-2: Ecosystem Overview (4 queries)

| # | File | Dune Name | Tracks |
|---|------|-----------|--------|
| 01 | `01_owb_overview_kpis.sql` | OWB Gaming - Overview KPIs | Price, FDV, Txs, Wallets, Holders, DEX Vol, WoW |
| 02 | `02_owb_daily_activity.sql` | OWB Gaming - Daily Activity | Daily txs, users, 7d MA, cumulative |
| 03 | `03_owb_dex_analytics.sql` | OWB Gaming - DEX Analytics | Buy/Sell, Net Flow, Price, Trade Size |
| 04 | `04_owb_staking_and_claims.sql` | OWB Gaming - Staking & Agentic Claims | Staking, Rewards Claims, Agentic Claims |

### Section 3: Base Agentic Gaming (2 queries)

| # | File | Dune Name | Tracks |
|---|------|-----------|--------|
| 11 | `11_base_agentic_gaming_emerging.sql` | Base Agentic Gaming - Emerging Projects | Project table, Activity Score |
| 12 | `12_base_agentic_gaming_daily.sql` | Base Agentic Gaming - Daily Activity | Daily activity per project |

### Section 4: OWB Agentic Gaming (7 queries)

| # | File | Dune Name | Tracks |
|---|------|-----------|--------|
| 10 | `10_owb_mrr_proxy.sql` | OWB Gaming - Revenue Proxy | NFT Sales + Treasury + LP Fees |
| 08 | `08_owb_bot_metrics.sql` | OWB Gaming - DTU Metrics | Wallet classification by type |
| 09 | `09_owb_bot_daily_trend.sql` | OWB Gaming - DTU Daily Trend | Automated vs Manual claims daily |
| 13 | `13_owb_bot_top_wallets.sql` | OWB Gaming - Top DTU Wallets | Top 100 active wallets |
| 14 | `14_owb_bot_hourly_heatmap.sql` | OWB Gaming - Activity Heatmap | Activity by hour/day |
| 17 | `17_owb_nft_purchases.sql` | OWB Gaming - NFT Sales & Passes | **NEW:** NFT sales Web + Base App |
| 18 | `18_owb_agentic_passes.sql` | OWB Gaming - Agentic Passes & Claims | **NEW:** Agentic Claim 1 vs 2 breakdown |

### Section 5: Deep Analytics (5 queries)

| # | File | Dune Name | Tracks |
|---|------|-----------|--------|
| 05 | `05_owb_holder_dynamics.sql` | OWB Gaming - Holder Dynamics | New holders, cumulative, 7d MA |
| 06 | `06_owb_holder_distribution.sql` | OWB Gaming - Holder Distribution | Pie chart distribution |
| 07 | `07_owb_liquidity_tvl.sql` | OWB Gaming - Liquidity & TVL | TVL Uniswap V3 + Aerodrome |
| 15 | `15_owb_coc_ingame_economy.sql` | OWB Gaming - In-Game Economy | COC token transfers |
| 16 | `16_owb_retention.sql` | OWB Gaming - Community Growth & Retention | **NEW:** New vs Returning users |

---

## 4. New Queries (3)

### Query 16: Community Growth & Retention

**Why:** Shows how many new users arrive daily and how many return. Key community health indicator.

**Visualization:** Area + Line Chart
- X: `day`
- Area (green #10B981): `New Users`
- Line (blue #3B82F6): `Cumulative Users`
- Dashed line (amber #F59E0B): `New Users 7d MA`
- Bar (purple #8B5CF6): `Returning Users`

**File:** `queries/owb-gaming-dashboard/16_owb_retention.sql`

---

### Query 17: NFT Sales & Passes

**Why:** Tracks real revenue from NFT/pass sales through both channels (Web and Base App). Main revenue source for the project.

**Visualization:**
1. **Stacked Bar - "NFT Sales Revenue"**
   - X: `day`
   - Bars: `Web USDC Revenue` (#3B82F6), `App USDC Revenue` (#8B5CF6)
   - Line: `Revenue 7d MA` (#F59E0B)

2. **Counter:**
   - "Total NFT Revenue" -> last value of `Cumulative USDC Revenue`
   - Prefix: `$`, Decimals: 2

**File:** `queries/owb-gaming-dashboard/17_owb_nft_purchases.sql`

---

### Query 18: Agentic Passes & Claims

**Why:** Detailed breakdown by two Agentic Claim contracts. Compare v1 vs v2 and track agentic ecosystem growth.

**Visualization:**
1. **Stacked Bar - "Agentic Claims by Contract"**
   - X: `day`
   - Bars: `Agentic Claim 1 Txs` (#3B82F6), `Agentic Claim 2 Txs` (#8B5CF6)
   - Line: `Agentic Claims 7d MA` (#F59E0B)

2. **Area - "Cumulative Agentic Claimants"**
   - `New Agentic Claimants` (#10B981, opacity 0.3)
   - `Cumulative Agentic Claimants` (line, #3B82F6)

**File:** `queries/owb-gaming-dashboard/18_owb_agentic_passes.sql`

---

## 5. Dune Update Instructions

### Step 1: Update existing queries (13 total)

For each query below:

1. Open query on dune.com (find by name in My Queries)
2. **Select all SQL code** (Ctrl+A)
3. **Replace** with new code from the corresponding file
4. Click **Run** to verify
5. Click **Save**

**Update order:**

```
01_owb_overview_kpis.sql          -> "OWB Gaming - Overview KPIs"
02_owb_daily_activity.sql         -> "OWB Gaming - Daily Activity"
04_owb_staking_and_claims.sql     -> "OWB Gaming - Staking & Agentic Claims" (RENAME!)
05_owb_holder_dynamics.sql        -> "OWB Gaming - Holder Dynamics"
07_owb_liquidity_tvl.sql          -> "OWB Gaming - Liquidity & TVL"
08_owb_bot_metrics.sql            -> "OWB Gaming - DTU Metrics" (RENAME!)
09_owb_bot_daily_trend.sql        -> "OWB Gaming - DTU Daily Trend" (RENAME!)
10_owb_mrr_proxy.sql              -> "OWB Gaming - Revenue Proxy" (RENAME!)
11_base_agentic_gaming_emerging.sql -> "Base Agentic Gaming - Emerging Projects"
12_base_agentic_gaming_daily.sql  -> "Base Agentic Gaming - Daily Activity"
13_owb_bot_top_wallets.sql        -> "OWB Gaming - Top DTU Wallets" (RENAME!)
14_owb_bot_hourly_heatmap.sql     -> "OWB Gaming - Activity Heatmap"
15_owb_coc_ingame_economy.sql     -> "OWB Gaming - In-Game Economy"
```

**Queries to RENAME** (names changed):
- Query 04: was "Staking & Claims" -> now "Staking & **Agentic** Claims"
- Query 08: was "Bot Metrics" -> now "**DTU** Metrics"
- Query 09: was "Bot Daily Trend" -> now "**DTU** Daily Trend"
- Query 10: was "MRR Proxy" -> now "**Revenue** Proxy"
- Query 13: was "Top Bot Wallets" -> now "Top **DTU** Wallets"

### Step 2: Create new queries (3 total)

For each new query:

1. Click **"New Query"** (top-right "+" button)
2. Paste SQL from the file
3. Engine: **DuneSQL** (default)
4. Click **Run**
5. **Save** with the title from the file header comment

```
16_owb_retention.sql              -> "OWB Gaming - Community Growth & Retention"
17_owb_nft_purchases.sql          -> "OWB Gaming - NFT Sales & Passes"
18_owb_agentic_passes.sql         -> "OWB Gaming - Agentic Passes & Claims"
```

### Step 3: Create visualizations for new queries

After creating each new query, add visualizations:

**Query 16 (Retention):**
1. New Visualization -> **Area Chart**
   - Title: "Community Growth - New vs Returning Users"
   - X: `day`
   - Y1 (area): `New Users` -> color: `#10B981`
   - Y2 (line): `Cumulative Users` -> color: `#3B82F6`, right Y-axis
   - Y3 (dashed): `New Users 7d MA` -> color: `#F59E0B`
   - Height: 350px

**Query 17 (NFT Sales):**
1. New Visualization -> **Bar Chart**
   - Title: "NFT Sales Revenue (USDC)"
   - X: `day`
   - Bars: `Web USDC Revenue` (#3B82F6), `App USDC Revenue` (#8B5CF6)
   - Line overlay: `Revenue 7d MA` (#F59E0B)
   - Height: 300px

2. New Visualization -> **Counter**
   - Title: "Total NFT Revenue"
   - Column: `Cumulative USDC Revenue`
   - Row: Last
   - Prefix: `$`
   - Decimals: 2

**Query 18 (Agentic Passes):**
1. New Visualization -> **Stacked Bar Chart**
   - Title: "Agentic Claims by Contract"
   - X: `day`
   - Bars: `Agentic Claim 1 Txs` (#3B82F6), `Agentic Claim 2 Txs` (#8B5CF6)
   - Line: `Agentic Claims 7d MA` (#F59E0B)
   - Height: 300px

2. New Visualization -> **Area Chart**
   - Title: "Cumulative Agentic Claimants"
   - X: `day`
   - Area: `New Agentic Claimants` (#10B981, opacity 0.3)
   - Line: `Cumulative Agentic Claimants` (#3B82F6)

### Step 4: Add new widgets to dashboard

Open the dashboard in edit mode and add:

1. **After Row 10 (MRR Charts)** - add:
   - NFT Sales Revenue chart (Query 17) - 1/2 width
   - Total NFT Revenue counter (Query 17) - 1/2 width

2. **After Row 7 (Gaming Daily Activity)** - add:
   - Agentic Claims by Contract (Query 18) - full width

3. **Before Row 16 (In-Game Economy)** - add:
   - Community Growth chart (Query 16) - full width

### Step 5: Update Text Widgets

Update the header text widget:

```markdown
# OWB Agentic Gaming - Base Analytics Dashboard

Real-time analytics for the OWB (Clash of Coins) ecosystem and emerging
Base Agentic Gaming projects. Tracking revenue, DTU metrics, DEX activity,
staking dynamics, NFT sales, and in-game economy health.

**Chain:** Base | **Token:** OWB (0xEF59...b3c1) | **Data:** Updated every 6h
**Queries:** 18 | **Last Updated:** April 2026
```

---

## 6. Visualization Setup

### Counter Widget Settings

| Parameter | Value |
|-----------|-------|
| Font size | Large |
| Prefix `$` | For USD values |
| Suffix `%` | For percentages |
| Decimals | 0 (counts), 2 (USD), 6 (price) |
| Thousands separator | Yes |
| Conditional color | Green (+), Red (-) |

### Chart Settings

| Type | Grid Lines | Legend | Tooltip | Height |
|------|-----------|--------|---------|--------|
| Line | Y only | Bottom | Crosshair | 300px |
| Area | Y only | Bottom | Crosshair | 300px |
| Bar | Y only | Bottom | Hover | 300px |
| Stacked Area | Y only | Bottom | Crosshair | 350px |
| Pie | No | Right | Hover | 300px |
| Table | N/A | N/A | N/A | Auto |

### Date Formatting
- X-axis: `MMM DD` (e.g., "Mar 25")
- Counters: ISO date
- Tables: `YYYY-MM-DD`

---

## 7. Layout Map

Updated dashboard layout (18 queries + 3 new):

```
ROW 0:  Text Widget - Dashboard Title & Description
ROW 1:  4 Counter Widgets (Q1): [Price] [FDV] [Holders] [DEX Vol 30d]
ROW 2:  4 Counter Widgets (Q1): [YTD Txs] [Wallets] [WoW Txs] [WoW Users]
ROW 3:  Line Chart - OWB Daily Txs & 7d MA (Q2) - full width
ROW 4:  [Cumulative Growth - Area (Q2)] [Tx Breakdown - Stacked (Q2)]
ROW 5:  Text Widget - "Section 3: Base Agentic Gaming"
ROW 6:  Table - Emerging Projects Tracker (Q11) - full width
ROW 7:  Stacked Area - Gaming Daily Activity (Q12) - full width
ROW 7b: NEW - Agentic Claims by Contract (Q18) - full width
ROW 8:  Text Widget - "Section 4: OWB Agentic Gaming"
ROW 9:  4 Counters - Revenue Quick Stats (Q10)
ROW 10: [Monthly Revenue Bars (Q10)] [Revenue Trend Line (Q10)]
ROW 10b: NEW - [NFT Sales Revenue (Q17) - 1/2] [Total NFT Revenue (Q17) - 1/2]
ROW 11: [Total DTU counter (Q8)] [DTU Claim Share (Q8)] [Classification Bar (Q8)]
ROW 12: [Automated vs Manual Claims (Q9)] [Hourly Heatmap (Q14)]
ROW 13: Table - Top DTU Wallets (Q13) - full width
ROW 14: [Buy vs Sell Volume (Q3)] [Staking Flow (Q4)]
ROW 15: [Holder Growth (Q5)] [Distribution Pie (Q6)] [TVL Trend (Q7)]
ROW 15b: NEW - Community Retention (Q16) - full width
ROW 16: Line Chart - In-Game Economy (Q15) - full width
ROW 17: Text Widget - Methodology & Data Sources
```

---

## 8. Color Palette

| Element | HEX | Usage |
|---------|-----|-------|
| Infrastructure / DeFi | `#3B82F6` (Blue) | Staking, Uniswap, primary lines |
| Consumer / Gaming | `#8B5CF6` (Purple) | OWB Token, Aerodrome, secondary series |
| Growth / Positive | `#10B981` (Green) | New holders, rewards, buying |
| Volume / Money | `#F59E0B` (Amber) | 7d MA lines, revenue, LP fees |
| Cumulative dark | `#1E40AF`, `#6D28D9` | Dark variants for cumulative lines |
| Decline / Negative | `#EF4444` (Red) | Selling, high-frequency automated, negative WoW |

### Application Rules:
- **7d MA lines** always `#F59E0B` (amber), dashed, width 2
- **Cumulative** lines - dark variants of primary colors
- **Counters** with WoW/MoM: green if positive, red if negative
- **DTU classification**: Red -> Amber -> Green -> Blue -> Purple (automated to manual)

---

## 9. Query Refresh Schedule

| Queries | Frequency | Reason |
|---------|-----------|--------|
| 01, 02, 03, 04 | Every 6 hours | High-frequency data |
| 05, 06, 07 | Every 24 hours | Slow-changing data |
| 08, 09, 10, 13, 14 | Every 12 hours | Medium frequency |
| 11, 12 | Every 12 hours | Gaming ecosystem |
| 15 | Every 24 hours | In-game economy |
| 16 (NEW) | Every 12 hours | Retention |
| 17 (NEW) | Every 12 hours | NFT Sales |
| 18 (NEW) | Every 12 hours | Agentic Claims |

---

## 10. Contract Registry (Current)

| Contract | Address | Purpose |
|----------|---------|---------|
| **OWB Token** | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | ERC-20 governance/utility |
| **Staking** | `0x692d11c779d43BBC12Cb8565C7f71a54A47D117c` | OWB staking |
| **Rewards Claim** | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | Claim rewards CoC |
| **Agentic Claim 1** | `0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb` | Agentic presale claims |
| **Agentic Claim 2** | `0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203` | Agentic claims v2 |
| **NFT Sale (Web)** | `0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b` | Web NFT sales |
| **NFT Sale (Base App)** | `0xf46A1D3eAA84558887169CF2CEE343491364c8BA` | Base App NFT sales |
| **Treasury** | `0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d` | Project treasury |
| **COC Token** | `0x4c3DEa2858e66c1e116b1eB54b4404025F84cFE9` | In-game currency |
| **Uniswap V3 Pool** | `0xf252f51919dfca2c9c0ea279f11183580edee4d6` | OWB/USDC 0.01% |
| **Aerodrome Pool** | `0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD` | OWB/USDC AMM |
| **USDC (Base)** | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` | Reference token |
| **Last AI Standing** | `0x88beBFeA498619D4eA891E707c47C43E2D43E62d` | Gaming project |

---

## Post-Update Checklist

- [ ] All 18 queries run without errors on Dune
- [ ] Queries 04, 08, 09, 10, 13 renamed
- [ ] 3 new queries (16, 17, 18) created and added to dashboard
- [ ] All visualizations configured with correct colors
- [ ] Counter widgets show correct WoW values
- [ ] Layout map matches description above
- [ ] Refresh schedule configured
- [ ] Header text widget updated
