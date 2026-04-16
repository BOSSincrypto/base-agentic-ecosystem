# OWB Token Analytics Dashboard — V2 Implementation Guide

**Dashboard URL:** [dune.com/bossincrypto/owb-token-analytics-base-onewayblock](https://dune.com/bossincrypto/owb-token-analytics-base-onewayblock)

**Chain:** Base (L2)
**Token:** OWB (OneWayBlock) — `0xEF5997c2cf2f6c138196f8A6203afc335206b3c1`
**Total Supply:** 1B | **FDV basis:** price × 1e9

---

## Contract Registry (21 contracts)

| # | Contract | Address | Category |
|---|----------|---------|----------|
| 1 | OWB Token | `0xEF5997c2cf2f6c138196f8A6203afc335206b3c1` | Token |
| 2 | vOWB Token | `0xD5590F6CeCeF03b796fd904541727C2fe6346C06` | Token |
| 3 | Agentic Claim 1 | `0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb` | Agentic |
| 4 | Agentic Claim 2 | `0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203` | Agentic |
| 5 | Claim Rewards | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | Gaming |
| 6 | vOWB Swap | `0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088` | Tokenomics |
| 7 | NFT Sale (Web) | `0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b` | NFT |
| 8 | NFT Sale (Base App) | `0xf46A1D3eAA84558887169CF2CEE343491364c8BA` | NFT |
| 9 | Staking | `0x692d11c779d43BBC12Cb8565C7f71a54A47D117c` | Staking |
| 10 | Vesting | `0xBbf1c72B783AB17e1585802D0Bd99d9b87A04404` | Staking |
| 11 | Treasury | `0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d` | Treasury |
| 12 | Referral Share | `0x842C14301B1B7319F7f3dbbcf5465CE1B15bA386` | Referral |
| 13 | NFT Buildings | `0x177f1AcdDc2833978B2965D50Ae17038D275D1f2` | NFT |
| 14 | NFT Buildings S1 | `0x4Ce43ad4FE0B39529848929A3d36843ba6025F8B` | NFT |
| 15 | NFT Founders | `0xf6aF7eBe28a587638140fE8AD0829b4536bBA549` | NFT |
| 16 | NFT Skins | `0x744E408a2709C453789DAB5c23e62eed16D9c9ED` | NFT |
| 17 | NFT Passes | `0x49046E2988A78222693c04AD049b68e5A4801034` | NFT |
| 18 | S2 Claim | `0xCa01825a7Ebec9A7E2E74C3F4b942ce61570D868` | Drops |
| 19 | S1 First Claim | `0x8fA8E118deCEc48Bb7c9FFacE245efBeD4eCB667` | Drops |
| 20 | S1 Second Claim | `0x5a9FA56078d72e16937879Cc6ada403ED12F2814` | Drops |
| 21 | RetroDrop | `0x6d19e9bC21A2120fF6fe71aaD28EcD9d05ed6973` | Drops |
| 22 | GameFI Drop | `0x6541BAcBF182E58031BB6a329e74F6492b4a7aAf` | Drops |

**Liquidity Pools:**
- Uniswap V3: `0xf252f51919dfca2c9c0ea279f11183580edee4d6` (0.01% fee)
- Aerodrome: `0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD`
- USDC (Base): `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913`

---

## Dashboard Structure (10 Sections, 22 Queries)

### Section 1: Ecosystem Pulse — KPI Headline Bar
**Queries:** `01_owb_ecosystem_pulse.sql`, `02_owb_agentic_kpis.sql`
**Widget type:** Counter tiles (single-row)
**Color:** #3B82F6 (Blue) for infrastructure metrics, #8B5CF6 (Purple) for agentic metrics

| Metric | Source |
|--------|--------|
| Current Price | `prices.usd_latest` |
| Market Cap (FDV) | Price × 1B |
| Total Holders | Net positive balance wallets |
| Total Ecosystem Txs (YTD) | All 21 contracts |
| Unique Wallets (YTD) | All 21 contracts |
| DEX Volume (30d) | `dex.trades` |
| 24h Volume | `dex.trades` |
| WoW Txs Growth % | Rolling 7d vs prev 7d |
| WoW Users Growth % | Rolling 7d vs prev 7d |
| Total Agentic Txs | From March 25, 2026 |
| Agentic Passes Minted | ERC-721 mints |
| OWB Distributed (Agentic) | Claims 1 + 2 |

**Key fix:** WoW calculation uses rolling 7-day windows (not calendar weeks) to avoid Monday false negatives.

---

### Section 2: Agentic Layer (from March 25, 2026)
**Queries:** `02_owb_agentic_kpis.sql`, `08_owb_community_retention.sql`
**Widget type:** Counter tiles + area chart (DTU over time)
**Color:** #8B5CF6 (Purple)

Shows agentic-specific metrics starting from presale date:
- Agentic Claims 1 & 2 activity
- DTU (Daily Transacting Users) — NOT "bots"
- New vs Returning player split
- 7d Retention %
- Cumulative unique players

---

### Section 3: NFT Sales & Revenue
**Queries:** `04_owb_nft_sales_revenue.sql`, `05_owb_agentic_passes.sql`
**Widget type:** Stacked bar chart + line (cumulative revenue)
**Color:** #F59E0B (Amber)

Tracks NFT purchases from two sources:
- **Web shop** (vOWB + USDC payments)
- **Base App** (USDC payments via Base Pay)

Agentic Passes breakdown by tier:
- Hero ($10), Champion ($100), Legend ($1000)

---

### Section 4: Treasury & Revenue
**Queries:** `09_owb_treasury_flows.sql`
**Widget type:** Stacked area chart + cumulative line
**Color:** #10B981 (Green)

Tracks real platform revenue:
- Treasury USDC inflows (x402 payments, shop revenue)
- Base Pay USDC inflows (player payments)
- Treasury OWB flows
- Cumulative revenue and treasury balance

---

### Section 5: vOWB Tokenomics
**Queries:** `06_owb_vowb_tokenomics.sql`
**Widget type:** Dual-axis chart (claims bar + swap line)
**Color:** #8B5CF6 (Purple)

- vOWB minted (in-game claims)
- vOWB swapped to OWB
- Swap ratio (OWB/vOWB)
- Outstanding vOWB (not yet swapped)

---

### Section 6: Staking Analytics
**Queries:** `07_owb_staking_deep_dive.sql`
**Widget type:** Stacked bar chart + cumulative area
**Color:** #10B981 (Green)

Uses correct staking contract `0x692d11c...`:
- Daily stake/unstake/rewards events
- OWB token flows to/from staking
- Net staking flow and cumulative TVL
- Unique stakers activity

---

### Section 7: Price & Volume Dynamics
**Queries:** `12_owb_price_volume_enhanced.sql`, `13_owb_buy_sell_pressure.sql`, `18_owb_market_dynamics.sql`
**Widget type:** Candlestick-style (VWAP/High/Low) + volume bars + MA lines
**Color:** #F59E0B (Amber) for volume, #3B82F6 (Blue) for price

Enhanced with:
- VWAP with 7d/30d MAs
- Volume split by DEX (Aerodrome, Uniswap, Other)
- Buy vs Sell pressure with net buy pressure
- 14d Momentum Oscillator
- Annualized Volatility

---

### Section 8: DEX Trading Analytics
**Queries:** `14_owb_trade_size_distribution.sql`, `15_owb_hourly_heatmap.sql`, `16_owb_top_traders.sql`, `20_owb_trader_cohorts.sql`
**Widget type:** Pie chart (size dist) + heatmap + table (top traders)
**Color:** #3B82F6 (Blue)

- Trade size distribution (30d): <$10, $10-100, $100-1K, $1K-10K, >$10K
- Hourly trading heatmap (UTC hour × day of week)
- Top 50 traders with classification (Market Maker/Whale/Regular/Casual)
- Trader cohort analysis (new vs returning)

---

### Section 9: Holder Intelligence
**Queries:** `10_owb_holder_distribution.sql`, `11_owb_holder_growth.sql`, `21_owb_dead_capital_tracker.sql`
**Widget type:** Donut chart (tiers) + line chart (growth) + table (dead capital)
**Color:** #10B981 (Green) for growth, #EF4444 (Red) for dormant

- Holder tiers: Dust (<1K), Retail (1K-10K), Dolphin (10K-100K), Whale (100K-1M), Mega Whale (>1M)
- Concentration: Top 10/25/100 % of supply
- Daily new holder growth with 7d/30d MAs
- Dead capital tracker by dormancy period

---

### Section 10: Network Health & Flows
**Queries:** `03_owb_daily_ecosystem_activity.sql`, `17_owb_net_flow_analysis.sql`, `19_owb_weekly_performance.sql`, `22_owb_liquidity_pools.sql`
**Widget type:** Stacked area (by category) + WoW table
**Color:** Mixed by category

- Daily ecosystem activity across ALL contracts with category breakdown
- Net flow analysis (accumulation vs distribution)
- Large transfers tracking (>100K OWB)
- Liquidity pool reserves (Uniswap V3 + Aerodrome)
- Weekly performance comparison table with WoW % changes

---

## Color Palette

| Category | Hex | Usage |
|----------|-----|-------|
| Infrastructure | `#3B82F6` | Price, DEX metrics, trading analytics |
| Consumer/Agents | `#8B5CF6` | Agentic layer, vOWB, gaming |
| Growth | `#10B981` | Holders, staking, positive trends |
| Volume/Money | `#F59E0B` | Revenue, volume, NFT sales |
| Decline/Negative | `#EF4444` | Dead capital, sell pressure, negative trends |

---

## Key Terminology

| Term | Meaning |
|------|---------|
| DTU | Daily Transacting Users (NOT "bots") |
| vOWB | Virtual OWB — in-game token, swappable to OWB |
| CoC | Clash of Coins — primary GameFi application |
| x402 | Agent-to-agent commerce protocol |
| Agentic Presale | Started March 25, 2026 |

---

## Technical Standards

- **SQL dialect:** DuneSQL (Trino-based)
- **CTEs:** All queries use `WITH ... AS` for readability
- **Table qualification:** Always `base.transactions`, `base.logs`, `dex.trades`, `erc20_base.evt_Transfer`, `erc721_base.evt_Transfer`
- **Rounding:** `ROUND()` for all displayed numbers
- **Division safety:** `NULLIF(..., 0)` to prevent division by zero errors
- **Date handling:** Rolling 7-day windows instead of calendar weeks for WoW
- **Moving averages:** 7d MA and 30d MA where appropriate
- **Cumulative:** Running SUM via window functions
- **Agentic metrics:** Start from `DATE '2026-03-25'`

---

## Setup Instructions

### Creating queries on Dune

1. Go to [dune.com](https://dune.com) and log in
2. For each `.sql` file in `queries/owb-token-analytics/`:
   - Create a new query → paste the SQL
   - Name it according to the file name (e.g., "OWB - Ecosystem Pulse")
   - Run the query to verify it executes
   - Save and add to dashboard

### Dashboard Layout

1. **Top row:** Counter tiles from queries 01 + 02 (Ecosystem Pulse + Agentic KPIs)
2. **Section 2:** Query 08 chart (DTU / retention) + query 02 agentic counters
3. **Section 3:** Query 04 + 05 charts (NFT sales + passes)
4. **Section 4:** Query 09 chart (treasury flows)
5. **Section 5:** Query 06 chart (vOWB tokenomics)
6. **Section 6:** Query 07 chart (staking)
7. **Section 7:** Queries 12 + 13 + 18 charts (price & volume)
8. **Section 8:** Queries 14 + 15 + 16 + 20 (trading analytics)
9. **Section 9:** Queries 10 + 11 + 21 (holder intelligence)
10. **Section 10:** Queries 03 + 17 + 19 + 22 (network health)

### Visualization Tips

- Use **counter** widgets for single-value KPIs
- Use **area charts** for time series with cumulative totals
- Use **stacked bar charts** for category breakdowns
- Use **pie/donut charts** for distribution views
- Use **tables** for top traders and weekly performance
- Use **heatmaps** for hourly trading patterns
- Add **text widgets** between sections with section headers and descriptions

---

## Games Section Note

Include only these active games in the Base Agentic Gaming section:
- **Last AI Standing** — survival game
- **Clash of Coins (CoC)** — main GameFi application
- **LegendOfBase (Uptopia)** — adventure game

Do NOT include Agent Royale (dead project).

---

## Dashboard Intro Text (Markdown Widget)

```markdown
# OWB Token Analytics - Deep Dive | Base Chain

A comprehensive on-chain analytics dashboard for the **OWB token (Clash of Coins / OneWayBlock)** on Base.
Every metric is derived from verifiable on-chain data via Dune Analytics. No off-chain assumptions, no trust required.

**Prize Pool:** $5M | **21 smart contracts tracked** | **100% on-chain data**

Tracked pools: Aerodrome OWB/USDC + Uniswap V3 OWB/USDC (0.01% fee, 100% locked LP)

OWB contract: [0xEF5997...](https://basescan.org/token/0xEF5997c2cf2f6c138196f8A6203afc335206b3c1) | Total Supply: 1B | Circulating: ~142.5M (~14.25%)

Dashboard is created and supported by AX1 team [Twitter](https://x.com/AX1research)
```
