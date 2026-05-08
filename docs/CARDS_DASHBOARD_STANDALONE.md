# CARDS MARKET DASHBOARD — Standalone Dune Dashboard (V2)

> **Dashboard name:** `Cards Market: The Gacha Economy Across Chains`
> **URL (proposed):** `dune.com/ax1research/cards-market`
> **Platform:** Dune Analytics (DuneSQL / Trino)
> **Chains:** Base · Polygon · Solana (cross-chain) · BNB (V2)
> **Supported by:** [AX1 Community](https://twitter.com/AX1ecosystem)
> **Date:** May 2026
> **Engine:** Medium required for Solana queries; Small for EVM

---

## CONTENTS

1. [Overview & Philosophy](#overview--philosophy)
2. [Tracked Projects & Addresses](#tracked-projects--addresses)
3. [Collector Crypt — Gacha Architecture](#collector-crypt--gacha-architecture)
4. [Phygitals — Pack Architecture](#phygitals--pack-architecture)
5. [Courtyard — Data Quality Note](#courtyard--data-quality-note)
6. [Materialization Strategy](#materialization-strategy)
7. [Dashboard Structure (Hempanda/AX1)](#dashboard-structure)
8. [Text Widget C.H: Dashboard Header](#text-widget-ch-dashboard-header)
9. [Text Widget C.S1: Market Pulse](#text-widget-cs1-market-pulse)
10. [Query C.1: KPI Counters](#query-c1-kpi-counters--the-vital-signs)
11. [Text Widget C.S2: Capital Flow](#text-widget-cs2-the-capital-race)
12. [Query C.2: Weekly Volume — Hero Chart](#query-c2-weekly-volume--the-capital-race)
13. [Query C.3: Market Share %](#query-c3-market-share--who-controls-the-ecosystem)
14. [Text Widget C.S3: Aftermarket](#text-widget-cs3-the-aftermarket)
15. [Query C.4: Secondary Market](#query-c4-secondary-market--life-after-the-pack)
16. [Text Widget C.S4: Deep Dive](#text-widget-cs4-inside-the-machine)
17. [Query C.5: Card Types — Niche Interest](#query-c5-card-types--whats-in-the-pack)
18. [Query C.6: CC Gacha Plays by Rarity](#query-c6-collector-crypt-gacha--rarity-distribution)
19. [Query C.7: CC Key Metrics P&L](#query-c7-collector-crypt-key-metrics--the-pl)
20. [Text Widget C.F: Methodology & Sources](#text-widget-cf-methodology--sources)
21. [Visualization Specs](#visualization-specs)
22. [Layout Map](#layout-map)
23. [Color Palette](#color-palette)
24. [Implementation Checklist](#implementation-checklist)
25. [V2 Roadmap](#v2-roadmap)
26. [Known Limitations](#known-limitations)

---

## OVERVIEW & PHILOSOPHY

### What Is This

The first **cross-chain aggregate dashboard** for the tokenized trading cards market (RWA Cards / Gacha). Five projects across three blockchains — all in one place.

### What Is Gacha and Why It Matters

**For the mass market:** Gacha is the digital version of buying a sealed pack of trading cards — you pay, and you get random cards. Except now the cards are on a blockchain, backed 1:1 by real physical cards in certified vaults. You can hold them, trade them instantly, or redeem the actual physical card shipped to your door.

**The market has three layers:**
1. **Primary (Pack Sales / Gacha)** — Users pay USDC to open randomized packs or operate claw machines → receive NFT cards of varying rarity
2. **Secondary (Trading)** — Cards trade freely on marketplaces (OpenSea, MagicEden, native platforms) like any NFT
3. **Buyback (Instant Liquidity)** — Projects guarantee buyback at 85–90% of fair market value, creating a price floor

**Why this is one of the next big things you're missing:** By Feb 2026, the tokenized cards market reached **$1.4B+ in cumulative volume** across platforms. Weekly gacha spending routinely exceeds $10M — surpassing traditional NFT marketplace volume on Solana since mid-2025. This is a new asset class being built in real time.

### Why a Separate Dashboard

The [Base Agentic Ecosystem](https://dune.com/ax1research/base-agentic-ecosystem) dashboard by AX1 became the de facto standard for AI agent market share — Virtuals Protocol itself reposts the data. **Goal: create the same standard for the Cards market** — a single source of truth where anyone can transparently see each project's market share, cumulative volumes, and growth dynamics.

### Key Principles

1. **Transparency** — Market share of every project visible at a glance
2. **Cross-chain** — All projects on one chart regardless of chain (Base + Polygon + Solana)
3. **Mass-market friendly** — Understandable without crypto background
4. **On-chain only** — Only verifiable blockchain data, no self-reported numbers
5. **Resource-efficient** — Materialized views for heavy Solana queries, medium engine where needed
6. **Narrative-driven** — Every widget tells part of a story, not just displays numbers

### Competitive Dashboards

| Dashboard | URL | Coverage | Weakness |
|-----------|-----|----------|----------|
| Phygitals Dashboard | `dune.com/unit_tx/phygitals-dashboard` | Only Phygitals (Solana) | One project, one chain |
| Pokemon TCG RWA SOL | `dune.com/zkayape/pokemontcgsol` | CC + Phygitals + Emporium (Solana) | Solana only, no Base/Polygon |
| Beezie Dashboard | `dune.com/unit_tx/beezie-dashboard` | Only Beezie (Base) | One project |
| Beezie (diam0nd) | `dune.com/diam0nd/beezie` | Only Beezie (Base) + referrals | One project |
| Sergey RUA — Courtyard | `dune.com/queries/7426512–7426783` | Only Courtyard (Polygon) | One project |
| Hempanda — Upshot | `dune.com/queries/7425705` | Only Upshot (Base) | One project |

**Our advantage:** No existing dashboard combines ALL 5 projects into one cross-chain market share view. This is the **aggregate standard** for the entire tokenized cards market.

---

## TRACKED PROJECTS & ADDRESSES

| # | Project | Chain | Type | How Volume Is Tracked | Data Source |
|---|---------|-------|------|----------------------|-------------|
| 1 | **Beezie** | Base | NFT Claw Machine | NFT sales via marketplaces | `nft.trades` (blockchain='base') |
| 2 | **Courtyard** | Polygon | NFT Marketplace | Marketplace trade events (volume + fees) | `polygon.logs` (raw byte parse) |
| 3 | **Collector Crypt** | Solana | Gacha Packs + CARDS Token | USDC inflows to gacha wallets | `tokens_solana.transfers` |
| 4 | **Upshot** | Base | Prediction Cards | USDC deposits to contract | `erc20_base.evt_Transfer` |
| 5 | **Phygitals** | Solana | Pack Opening + Claw + Lucky Draw | USDC inflows to gacha wallets | `tokens_solana.transfers` |

### Key Token Addresses

| Token | Chain | Address |
|-------|-------|---------|
| USDC | Base | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` |
| USDC | Polygon | `0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359` |
| USDC | Solana | `EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v` |
| CARDS | Solana | `CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp` |

### Project Addresses

| Project | Address / Contract | Role |
|---------|-------------------|------|
| **Beezie** | `0xbb5ec6fd4b61723bd45c399840f1d868840ca16f` | NFT contract (Base) |
| **Courtyard** | `0x5e4943373c2198625bd441ae0629e9e7b4fb4797` | Marketplace contract (Polygon) |
| **Courtyard** | topic0: `0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd` | Trade event signature |
| **Courtyard** | `0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD` | NFT contract (for reference) |
| **Upshot** | `0x939dbbcf075de12d9d8df08ef727591ddebbc13b` | Deposit contract (Base) |

### Market Scale (Caggy / DefiLlama, Feb 2026)

| Project | All-Time Volume | Gross Revenue | Inventory |
|---------|----------------|---------------|-----------|
| Courtyard | $723.9M | $100.2M | 230K certs |
| Collector Crypt | $579.6M | $30.3M | 51K certs |
| Phygitals | $136.1M | $9.2M | ~36K certs |
| Beezie | $28.2M (Base) | $14.3M | 18K certs |

---

## COLLECTOR CRYPT — GACHA ARCHITECTURE

Source: team context (Sergey RUA, cont_2.md) + DefiLlama adapter (`fees/collector-crypt/index.ts`).

### How Gacha Works

1. User pays USDC → one of 3 gacha wallets
2. VRF selects random rarity pool (Low → Legend)
3. Card transfers from rarity pool wallet → user wallet
4. User can hold, trade secondary, or redeem physical card

### Gacha Wallets (USDC receivers)

| Wallet | Address |
|--------|---------|
| Gacha Primary | `GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3` |
| Gacha Secondary | `GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z` |
| Gacha Tertiary | `96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s` |

### Rarity Pool Wallets (card distributors)

| Rarity | Wallet 1 | Wallet 2 |
|--------|----------|----------|
| **Low** | `Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu` | `Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN` |
| **Mid** | `Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney` | `miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt` |
| **High** | `HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns` | `HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb` |
| **Epic** | `EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF` | `epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn` |
| **Legend** | `LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf` | `LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj` |
| **One** | `onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs` | — |
| **Sport** | `SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD` | `SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8` |

### Internal Addresses (excluded from analytics)

| Address | Role |
|---------|------|
| `DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd` | Fee/royalty wallet |
| `cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi` | CC internal |
| `GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3` | Gacha contract |
| `GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z` | Gacha contract |
| `96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s` | Gacha contract |
| `BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M` | Internal ops |
| `21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8` | Internal ops |
| `DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE` | Internal ops |
| `HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u` | Internal ops |
| `Cc4pHGnoaRWL1WnHsV517T3YvQn5gLDBMiuVXkF9rZhK` | Internal (buyback exclusion) |
| `8373hLiAEXxaJ3oV7SRzx4KHwurEg9rEG98tUPj1sdtX` | Internal (buyback exclusion) |

### Existing Public Queries (reference)

| Query | Source | Description | Engine |
|-------|--------|-------------|--------|
| Plays by Rarity | Giedi (public) | Daily gacha by rarity pool | Medium required (timeout on small) |
| Monthly Retention | `dune.com/queries/7432781` | Monthly cohort retention | From 01.2026 (timeout) |
| Key Metrics P&L | `dune.com/queries/7433053` | Weekly USDC P&L (spend, outflows, fees) | From 01.2026 |

---

## PHYGITALS — PACK ARCHITECTURE

Source: DefiLlama adapter (`fees/phygitals/index.ts`) + Phygitals docs.

### How Phygitals Works

1. User pays USDC → gacha/pack wallet to open randomized packs ($1–$250 tiers)
2. Receives compressed NFT (cNFT via Metaplex Bubblegum) representing a graded physical card
3. Can trade on marketplace (Tensor, MagicEden), hold, or redeem physical card
4. Buyback at 85–90% of FMV via platform

### Revenue Wallets (USDC receivers)

| Wallet | Address | Role |
|--------|---------|------|
| Main Gacha | `62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS` | Primary pack purchase receiver |
| Secondary Gacha | `42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e` | Secondary pack receiver |
| Lucky Draw | `4SabGkbLc9uxzrq4f1Es9tJPZfHVzP28kwSosR2sYJRt` | Lucky Draw fees |
| Royalties | `2CEe9G68EqWmer21DhRhxJ3coUvRspDxT9NJuc2PJYo5` | Marketplace royalties/fees |

### Internal Exclusions

| Address | Role |
|---------|------|
| `42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e` | Internal rebalancing |
| `5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf` | Internal ops |

### Data Notes
- Token: USDC on Solana (`EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v`)
- Table: `tokens_solana.transfers`
- Primary volume = USDC to gacha wallets (main + secondary) + lucky draw fees
- Buyback = USDC sent FROM main gacha wallet back to users
- Start date: 2025-03-16
- Supported TCGs: Pokémon (primary), Baseball, Football, Basketball, One Piece, Yu-Gi-Oh!, Dragon Ball
- NFT tech: Compressed NFTs (cNFTs) via Metaplex Bubblegum protocol

---

## COURTYARD — DATA SOURCE NOTE

### Approach: Raw Marketplace Events

Courtyard operates its own marketplace on Polygon. The Dune Spellbook `nft.trades` table does NOT have a Courtyard-specific marketplace model (Spellbook PR #8704 still open), so using `nft.trades` massively undercounts volume.

**Solution:** We parse raw trade events directly from `polygon.logs`:
- **Contract:** `0x5e4943373c2198625bd441ae0629e9e7b4fb4797` (Courtyard marketplace)
- **Event topic0:** `0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd`
- **Data layout:** `substr(data, 33, 32)` = volume (USDC, 6 decimals), `substr(data, 97, 32)` = fees (USDC, 6 decimals)

### What This Captures

- ✅ **Trading volume (turnover)** on Courtyard's native marketplace — significantly more realistic than `nft.trades`
- ✅ **Platform fees** — enables fee rate % calculation
- ⚠️ **Note:** This is trading volume (turnover), not net incoming revenue. For market share comparison this is the correct metric.
- ⚠️ **unique_buyers** not available from raw logs (no decoded buyer address in this event) — uses `COUNT(DISTINCT tx_hash)` as proxy in KPI counter

### Future Options

1. When Spellbook PR #8704 merges → can switch back to `nft.trades` for cleaner data + buyer addresses
2. Could cross-reference with `nft.transfers` to get buyer/seller from same tx_hash

---

## MATERIALIZATION STRATEGY

### Why Materialization Is Needed

Solana queries (Collector Crypt, Phygitals) scan `tokens_solana.transfers` — one of the heaviest tables on Dune. Cross-chain aggregation (Base + Polygon + Solana) multiplies the load.

### Approach

| Query | Engine | Strategy |
|-------|--------|----------|
| Q1: Weekly Volume | **Medium** | `block_date >= DATE '2026-01-01'` filter; weekly aggregation reduces rows |
| Q2: Market Share | **Medium** | Same data as Q1, could use materialized view of Q1 |
| Q3: Secondary Market | Small | EVM nft.trades only (fast); Solana DEX for CARDS token |
| Q4: Card Types | **Medium** | Heavy Solana scan of rarity pool transfers |
| Q5: KPI Counters | **Medium** | Aggregates all chains; shares CTEs with Q1 |
| Q6: CC Gacha Plays | **Medium** | From Giedi's query; timeout on small engine confirmed |
| Q7: CC P&L | **Medium** | Multi-wallet USDC flow aggregation |

### Optimization Tips

1. Always use `block_date >= DATE '2026-01-01'` for Solana queries (partition pruning)
2. Use `approx_distinct()` instead of `COUNT(DISTINCT ...)` for unique users
3. Weekly aggregation (`date_trunc('week', ...)`) reduces output rows
4. Exclude incomplete current week: `WHERE week < date_trunc('week', NOW())`
5. Consider Dune materialized views for Q1 data if refresh rate allows
6. On Dune, set query schedule to refresh every 6–12 hours (not live)

---

## DASHBOARD STRUCTURE

Based on Hempanda/AX1 proposal. Five core sections following the natural flow: overview → volume → share → aftermarket → deep dive.

| Section | Narrative | Widgets |
|---------|----------|---------|
| **Header** | What is gacha? Why does the cards market matter? | 1 text widget |
| **Market Pulse** | Instant health check: volume, users, leader, momentum | 1 text + 5 counters |
| **Capital Race** | Where does the money go? Weekly flows + market share | 1 text + 3 charts |
| **Aftermarket** | What happens after you open the pack? Secondary trading | 1 text + 1 chart |
| **Inside the Machine** | Niche data: card types + CC gacha rarity + P&L | 1 text + 3 charts |
| **Footer** | Methodology, sources, limitations, V2 preview | 1 text widget |

**Total: 7 queries · 6 text widgets · 5 counters · 7 charts = 25 widgets in 14 rows**

---

## TEXT WIDGET C.H: DASHBOARD HEADER

**Row C-1:** Full width (12 columns). First thing users see.

**How to add:** Edit dashboard → Add text widget → paste text → stretch to 12 columns.

**Text (copy as-is):**

```markdown
# Cards Market: The Gacha Economy Across Chains

**The first cross-chain dashboard for the $1.4B+ tokenized trading cards market.** Physical Pokémon, sports, and anime trading cards — graded, vaulted, and tokenized as digital assets across Base, Polygon, and Solana.

### How it works — in 30 seconds

Imagine buying a sealed pack of Pokémon cards — except digitally, on a blockchain. You pay USDC, get random cards backed 1:1 by real graded cards in insured vaults. You can:

- 🎰 **Open Packs / Play the Machine** — Pay USDC, get random NFT cards (this is "gacha")
- 🔄 **Trade Instantly** — Sell on OpenSea, MagicEden, or native marketplaces
- 📦 **Redeem Physical** — Burn the NFT, receive the actual graded card
- 💰 **Buyback Floor** — Most projects guarantee 85–90% of fair market value back

### Five projects. Three chains. One market.

| Project | Chain | Mechanic | Total Volume |
|---------|-------|----------|-------------|
| **Courtyard** | Polygon | NFT Marketplace — the "blue chip" of RWA cards | $723.9M |
| **Collector Crypt** | Solana | Gacha packs with 7 rarity tiers + $CARDS token | $579.6M |
| **Phygitals** | Solana | Pack opening + claw + lucky draw — 60K+ cards tokenized | $136.1M |
| **Beezie** | Base | NFT Claw Machine — gamified, social, viral | $28.2M |
| **Upshot** | Base | Prediction market with card-backed USDC positions | — |

> Built by [AX1 Research](https://twitter.com/AX1ecosystem) · Data: 2026 YTD · On-chain USDC inflows + NFT trades · Updated weekly
```

---

## TEXT WIDGET C.S1: MARKET PULSE

**Row C-2:** Full width (12 columns).

```markdown
---

## Market Pulse: The Vital Signs

Five numbers that tell you everything about the health of the tokenized cards market. Total capital committed, unique participants, the current market leader, active projects, and week-over-week momentum — all derived from on-chain data across three blockchains.

> Think of these as the EKG of a market being born. Green means growing. Flat means consolidating. Red means we have a problem.
```

---

## QUERY C.1: KPI COUNTERS — THE VITAL SIGNS

### What It Does

Single query for **5 key numbers** at the top. Aggregates all 5 projects across 3 chains.

### Dashboard Description

> **Title:** `Cards Market — KPI Counters (V2)`
> **Description:** The heartbeat of the tokenized cards market — total capital inflows, active participants, who's leading, and whether the market is accelerating or slowing. Cross-chain: Base + Polygon + Solana.

### SQL

**File:** `queries/cards-dashboard/05_kpi_counters.sql`

```sql
-- Q5: Combined KPI Counters (V2 — 5 projects)
-- 5 key numbers: total_volume_usd, unique_users, top_project, active_projects, wow_growth_pct
-- Engine: Medium (Solana queries)

WITH beezie_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(buyer)       AS users
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
),

courtyard_vol AS (
    SELECT
        COALESCE(ROUND(SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6, 2), 0) AS vol,
        COUNT(DISTINCT tx_hash) AS users
    FROM polygon.logs
    WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
      AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
      AND block_date >= DATE '2026-01-01'
),

cc_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(from_owner)  AS users
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
          '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
          'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
          'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
),

upshot_vol AS (
    SELECT
        COALESCE(SUM(CAST(value AS DOUBLE) / 1e6), 0) AS vol,
        approx_distinct("from")                        AS users
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

phygitals_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(from_owner)  AS users
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND (
          (to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e'
           AND from_owner NOT IN ('62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '4SabGkbLc9uxzrq4f1Es9tJPZfHVzP28kwSosR2sYJRt'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
      )
),

all_projects AS (
    SELECT project, vol FROM (
        VALUES
            ('Beezie',          (SELECT vol FROM beezie_vol)),
            ('Courtyard',       (SELECT vol FROM courtyard_vol)),
            ('Collector Crypt', (SELECT vol FROM cc_vol)),
            ('Upshot',          (SELECT vol FROM upshot_vol)),
            ('Phygitals',       (SELECT vol FROM phygitals_vol))
    ) AS t(project, vol)
),

this_week AS (
    SELECT
        COALESCE((
            SELECT SUM(amount_usd) FROM nft.trades
            WHERE blockchain = 'base'
              AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
              AND block_time >= NOW() - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6 FROM polygon.logs
            WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
              AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
              AND block_date >= CURRENT_DATE - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(amount_usd) FROM tokens_solana.transfers
            WHERE block_date >= CURRENT_DATE - INTERVAL '7' DAY
              AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
              AND to_owner IN (
                  'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
                  'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
                  '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
              )
        ), 0) AS vol
),

prev_week AS (
    SELECT
        COALESCE((
            SELECT SUM(amount_usd) FROM nft.trades
            WHERE blockchain = 'base'
              AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
              AND block_time >= NOW() - INTERVAL '14' DAY
              AND block_time <  NOW() - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6 FROM polygon.logs
            WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
              AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
              AND block_date >= CURRENT_DATE - INTERVAL '14' DAY
              AND block_date <  CURRENT_DATE - INTERVAL '7' DAY
        ), 0)
      + COALESCE((
            SELECT SUM(amount_usd) FROM tokens_solana.transfers
            WHERE block_date >= CURRENT_DATE - INTERVAL '14' DAY
              AND block_date <  CURRENT_DATE - INTERVAL '7' DAY
              AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
              AND to_owner IN (
                  'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
                  'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
                  '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
              )
        ), 0) AS vol
)

SELECT
    ROUND((SELECT SUM(vol) FROM all_projects), 0) AS total_volume_usd,
    (SELECT users FROM beezie_vol)
  + (SELECT users FROM courtyard_vol)
  + (SELECT users FROM cc_vol)
  + (SELECT users FROM upshot_vol)
  + (SELECT users FROM phygitals_vol)               AS unique_users,
    (SELECT project FROM all_projects ORDER BY vol DESC LIMIT 1) AS top_project,
    (SELECT COUNT(*) FROM all_projects WHERE vol > 0) AS active_projects,
    ROUND(
        100.0 * ((SELECT vol FROM this_week) - (SELECT vol FROM prev_week))
        / NULLIF((SELECT vol FROM prev_week), 0)
    , 1)                                              AS wow_growth_pct
```

### Visualizations (5 counters)

| Counter | Column | Format | Position |
|---------|--------|--------|----------|
| **Total Capital Inflows** | `total_volume_usd` | `$X.XM` prefix `$` | Row C-3, col 1–3 |
| **Unique Participants** | `unique_users` | `X,XXX` | Row C-3, col 4–5 |
| **Market Leader** | `top_project` | Text | Row C-3, col 6–8 |
| **Active Projects** | `active_projects` | `X / 5` | Row C-3, col 9–10 |
| **WoW Momentum** | `wow_growth_pct` | `+X.X%` suffix `%` | Row C-3, col 11–12 |

---

## TEXT WIDGET C.S2: THE CAPITAL RACE

**Row C-4:** Full width (12 columns).

```markdown
---

## The Capital Race: Where Users Put Their Money

The heart of the dashboard. Weekly stacked bars show raw capital inflows — you see exactly how much money flows into each project. The normalized chart below reveals the hidden story: market share shifts that volume alone can't show.

> A project can grow in absolute volume while losing market share. Watch both charts to see the full picture.
```

---

## QUERY C.2: WEEKLY VOLUME — THE CAPITAL RACE

### What It Does

**HERO CHART.** Weekly stacked bar of ALL 5 projects. Same query also powers the 100% stacked area (market share % over time). Two visualizations from one query.

### Dashboard Description

> **Title:** `Cards Market — Weekly Volume by Project (V2)`
> **Viz 1 Title:** `The Capital Race: Weekly Inflows by Project`
> **Viz 1 Description:** Raw capital flowing into the tokenized cards market every week. Each layer is a project — the taller the stack, the bigger the market. All volumes in USDC equivalent.
> **Viz 2 Title:** `Market Share Drift: Who's Gaining Ground?`
> **Viz 2 Description:** Same data, different lens. Each project's share of total weekly volume, normalized to 100%. When a color band grows, that project is capturing more of the market — even if total volume is flat.

### SQL

**File:** `queries/cards-dashboard/01_weekly_volume_by_project.sql`

```sql
-- Q1: Weekly Primary Volume by Project (V2 — 5 projects)
-- HERO CHART: stacked bar + 100% stacked area (market share % over time)
-- Engine: Medium (Solana queries)

WITH beezie AS (
    SELECT
        date_trunc('week', block_time)    AS week,
        'Beezie'                          AS project,
        'Base'                            AS chain,
        COALESCE(SUM(amount_usd), 0)      AS volume_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

courtyard AS (
    SELECT
        date_trunc('week', block_date)    AS week,
        'Courtyard'                       AS project,
        'Polygon'                         AS chain,
        COALESCE(ROUND(SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6, 2), 0) AS volume_usd
    FROM polygon.logs
    WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
      AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
      AND block_date >= DATE '2026-01-01'
    GROUP BY 1
),

collector_crypt AS (
    SELECT
        date_trunc('week', block_time)    AS week,
        'Collector Crypt'                 AS project,
        'Solana'                          AS chain,
        COALESCE(SUM(amount_usd), 0)      AS volume_usd
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
          '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
          'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
          'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
    GROUP BY 1
),

upshot AS (
    SELECT
        date_trunc('week', evt_block_time)  AS week,
        'Upshot'                            AS project,
        'Base'                              AS chain,
        COALESCE(SUM(CAST(value AS DOUBLE) / 1e6), 0) AS volume_usd
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-01-01'
    GROUP BY 1
),

phygitals AS (
    SELECT
        date_trunc('week', block_time)    AS week,
        'Phygitals'                       AS project,
        'Solana'                          AS chain,
        COALESCE(SUM(amount_usd), 0)      AS volume_usd
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND (
          (to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e'
           AND from_owner NOT IN ('62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '4SabGkbLc9uxzrq4f1Es9tJPZfHVzP28kwSosR2sYJRt'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
      )
    GROUP BY 1
),

combined AS (
    SELECT * FROM beezie
    UNION ALL SELECT * FROM courtyard
    UNION ALL SELECT * FROM collector_crypt
    UNION ALL SELECT * FROM upshot
    UNION ALL SELECT * FROM phygitals
)

SELECT
    week,
    project,
    chain,
    ROUND(volume_usd, 2) AS volume_usd
FROM combined
WHERE week < date_trunc('week', NOW())
ORDER BY week, project
```

### Visualization 1: Stacked Bar

| Parameter | Value |
|-----------|-------|
| Chart type | Stacked Bar |
| X-axis | `week` (date) |
| Y-axis | `volume_usd` |
| Group by | `project` |
| Colors | Beezie=#3B82F6, Courtyard=#8B5CF6, CC=#10B981, Upshot=#60A5FA, Phygitals=#34D399 |
| Height | 400px |

### Visualization 2: 100% Stacked Area

| Parameter | Value |
|-----------|-------|
| Chart type | 100% Stacked Area |
| X-axis | `week` (date) |
| Y-axis | `volume_usd` |
| Group by | `project` |
| Normalize | 100% |
| Colors | Same as Viz 1 |
| Height | 300px |

---

## QUERY C.3: MARKET SHARE — WHO CONTROLS THE ECOSYSTEM?

### What It Does

Cumulative market share donut chart — each project's slice of total 2026 YTD volume.

### Dashboard Description

> **Title:** `Cards Market — Market Dominance (V2)`
> **Viz Title:** `Market Dominance: Who Controls the Ecosystem?`
> **Description:** Each project's share of total gacha/cards market volume in 2026. The bigger the slice, the bigger the player. Hover for exact USDC amounts. Note: Courtyard tracks marketplace turnover (see methodology).

### SQL

**File:** `queries/cards-dashboard/02_market_share_total.sql`

```sql
-- Q2: Market Share — Total Volume by Project (V2 — 5 projects)
-- Donut pie chart showing each project's share of the gacha market
-- Engine: Medium (Solana queries)

WITH beezie AS (
    SELECT 'Beezie' AS project, 'Base' AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
),

courtyard AS (
    SELECT 'Courtyard' AS project, 'Polygon' AS chain,
        COALESCE(ROUND(SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6, 2), 0) AS total_volume_usd
    FROM polygon.logs
    WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
      AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
      AND block_date >= DATE '2026-01-01'
),

collector_crypt AS (
    SELECT 'Collector Crypt' AS project, 'Solana' AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
          '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
          'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
          'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
),

upshot AS (
    SELECT 'Upshot' AS project, 'Base' AS chain,
        COALESCE(SUM(CAST(value AS DOUBLE) / 1e6), 0) AS total_volume_usd
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

phygitals AS (
    SELECT 'Phygitals' AS project, 'Solana' AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND (
          (to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e'
           AND from_owner NOT IN ('62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
          OR
          (to_owner = '4SabGkbLc9uxzrq4f1Es9tJPZfHVzP28kwSosR2sYJRt'
           AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                                  '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'))
      )
)

SELECT
    project,
    chain,
    ROUND(total_volume_usd, 2) AS total_volume_usd,
    project || ' (' || chain || ')' AS label
FROM (
    SELECT * FROM beezie
    UNION ALL SELECT * FROM courtyard
    UNION ALL SELECT * FROM collector_crypt
    UNION ALL SELECT * FROM upshot
    UNION ALL SELECT * FROM phygitals
)
ORDER BY total_volume_usd DESC
```

### Visualization: Donut Pie

| Parameter | Value |
|-----------|-------|
| Chart type | Donut Pie |
| Values | `total_volume_usd` |
| Labels | `label` |
| Colors | Beezie=#3B82F6, Courtyard=#8B5CF6, CC=#10B981, Upshot=#60A5FA, Phygitals=#34D399 |
| Height | 350px |
| Show % | Yes |

---

## TEXT WIDGET C.S3: THE AFTERMARKET

**Row C-8:** Full width (12 columns).

```markdown
---

## The Aftermarket: Life After the Pack

What happens after you open the pack? Some cards get traded on secondary marketplaces (OpenSea, MagicEden, native platforms). Others get redeemed for the physical card. The secondary market tells you how "alive" a project's ecosystem is — healthy trading means the cards have real perceived value beyond the initial gacha pull.

> For Collector Crypt, secondary trading happens through the $CARDS token on DEXes (Raydium, Orca). For EVM projects, it's NFT marketplace trades.
```

---

## QUERY C.4: SECONDARY MARKET — LIFE AFTER THE PACK

### Dashboard Description

> **Title:** `Cards Market — Secondary Market Volume (V2)`
> **Viz Title:** `The Aftermarket: Weekly Secondary Volume by Project`
> **Description:** NFT secondary sales on marketplaces + CARDS token DEX trading. This measures how actively cards change hands after the initial purchase. Higher secondary volume = healthier ecosystem.

### SQL

**File:** `queries/cards-dashboard/03_secondary_market_volume.sql`

```sql
-- Q3: Secondary Market Volume by Project (V2 — includes Phygitals royalties)
-- NFT secondary via nft.trades; CC secondary via CARDS DEX; Phygitals via royalty proxy
-- Engine: Small for EVM, Medium for Solana DEX

WITH beezie_secondary AS (
    SELECT
        date_trunc('week', block_time)  AS week,
        'Beezie'                        AS project,
        'Base'                          AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(buyer)          AS unique_buyers
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

courtyard_secondary AS (
    SELECT
        date_trunc('week', block_date)  AS week,
        'Courtyard'                     AS project,
        'Polygon'                       AS chain,
        COALESCE(ROUND(SUM(bytearray_to_uint256(substr(data, 33, 32))) / 1e6, 2), 0) AS volume_usd,
        COUNT(*)                        AS trades,
        CAST(0 AS BIGINT)               AS unique_buyers
    FROM polygon.logs
    WHERE contract_address = 0x5e4943373c2198625bd441ae0629e9e7b4fb4797
      AND topic0 = 0xa6ae807740439025f50884311ce0f96f5c3809a8f7170f9459dab1b14c9d8afd
      AND block_date >= DATE '2026-01-01'
    GROUP BY 1
),

collector_crypt_dex AS (
    SELECT
        date_trunc('week', block_time)  AS week,
        'Collector Crypt'               AS project,
        'Solana'                        AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(trader_id)      AS unique_buyers
    FROM dex_solana.trades
    WHERE block_date >= DATE '2026-01-01'
      AND (   token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
           OR token_sold_mint_address   = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp')
    GROUP BY 1
),

phygitals_royalties AS (
    SELECT
        date_trunc('week', block_time)  AS week,
        'Phygitals'                     AS project,
        'Solana'                        AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(from_owner)     AS unique_buyers
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND to_owner = '2CEe9G68EqWmer21DhRhxJ3coUvRspDxT9NJuc2PJYo5'
      AND from_owner NOT IN ('42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
                             '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf')
    GROUP BY 1
),

combined AS (
    SELECT * FROM beezie_secondary
    UNION ALL SELECT * FROM courtyard_secondary
    UNION ALL SELECT * FROM collector_crypt_dex
    UNION ALL SELECT * FROM phygitals_royalties
)

SELECT
    week,
    project,
    chain,
    ROUND(volume_usd, 2)  AS volume_usd,
    trades,
    unique_buyers
FROM combined
WHERE week < date_trunc('week', NOW())
ORDER BY week, project
```

### Visualization: Stacked Bar

| Parameter | Value |
|-----------|-------|
| Chart type | Stacked Bar |
| X-axis | `week` (date) |
| Y-axis | `volume_usd` |
| Group by | `project` |
| Colors | Same chain-grouped palette |
| Height | 350px |

---

## TEXT WIDGET C.S4: INSIDE THE MACHINE

**Row C-10:** Full width (12 columns).

```markdown
---

## Inside the Machine: What's Being Minted and Who's Playing

Deep dive into the composition of the market. What types of cards are people actually buying? How does Collector Crypt's gacha rarity system distribute cards? And is the project making money or burning through reserves?

> **Card Types** shows market preference (Pokémon dominates, but Sport is growing). **Gacha Plays** reveals player behavior by rarity tier. **Key Metrics** shows the financial health of Collector Crypt — the largest gacha project.
```

---

## QUERY C.5: CARD TYPES — WHAT'S IN THE PACK?

### Dashboard Description

> **Title:** `Cards Market — Card Types (Niche Interest)`
> **Viz Title:** `What's in the Pack? Card Type Distribution`
> **Description:** Cumulative card distributions by type across the gacha market. Based on Collector Crypt rarity pool data — Sport wallet = sport cards, all other pools = Pokémon/TCG. V2 will add Phygitals types (Baseball, Football, Basketball, One Piece, Yu-Gi-Oh!).

### SQL

**File:** `queries/cards-dashboard/04_niche_card_types.sql`

```sql
-- Q4: Card Types Distribution (V2 — Niche Interest)
-- Based on Collector Crypt rarity pool distributions
-- Sport wallet = Sport cards; all other rarity wallets = Pokemon / TCG
-- Engine: Medium (Solana transfers)

WITH cc_distributions AS (
    SELECT
        CASE from_owner
            WHEN 'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'  THEN 'Sport'
            WHEN 'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'  THEN 'Sport'
            ELSE 'Pokemon / TCG'
        END AS card_type,
        COUNT(*) AS cards_distributed
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2025-01-01'
      AND from_owner IN (
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'
      )
      AND to_owner NOT IN (
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
    GROUP BY 1
)

SELECT
    card_type,
    cards_distributed,
    ROUND(
        100.0 * cards_distributed
        / NULLIF(SUM(cards_distributed) OVER (), 0)
    , 1) AS pct
FROM cc_distributions
ORDER BY cards_distributed DESC
```

### Visualization: Donut Pie

| Parameter | Value |
|-----------|-------|
| Chart type | Donut Pie |
| Values | `cards_distributed` |
| Labels | `card_type` |
| Colors | Pokemon=#F59E0B (amber), Sport=#10B981 (green) |
| Height | 300px |
| Show % | Yes |

---

## QUERY C.6: COLLECTOR CRYPT GACHA — RARITY DISTRIBUTION

### Dashboard Description

> **Title:** `CC Gacha — Plays by Rarity (V2)`
> **Viz 1 Title:** `Inside the Machine: Gacha Rarity Distribution`
> **Viz 1 Description:** Weekly card distributions from each rarity pool. Low is the most common, Legend is the rarest. This is the gacha engine — where randomness meets value.
> **Viz 2 Title:** `Gacha Players: Weekly Unique Participants by Rarity`
> **Viz 2 Description:** How many unique wallets are pulling from each rarity tier? Declining player counts at high rarities = healthy distribution (few can afford Legend pulls).
> **⚠️ Engine:** Medium required (small engine times out on `tokens_solana.transfers` scan)

### SQL

**File:** `queries/cards-dashboard/06_collector_crypt_gacha_plays.sql`

```sql
-- Q6: Collector Crypt — Gacha Plays by Rarity (weekly)
-- Adapted from Giedi's public query
-- IMPORTANT: Requires MEDIUM engine (small engine timeout confirmed)
-- Engine: Medium

WITH rarity_wallets AS (
    SELECT * FROM (
        VALUES
            ('Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',  'Low'),
            ('Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',  'Low'),
            ('Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',  'Mid'),
            ('miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',  'Mid'),
            ('HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns', 'High'),
            ('HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',  'High'),
            ('EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',  'Epic'),
            ('epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',  'Epic'),
            ('LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',  'Legend'),
            ('LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',  'Legend'),
            ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',   'One'),
            ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',  'Sport'),
            ('SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',  'Sport')
    ) AS t(wallet, rarity)
),

excluded_recipients AS (
    SELECT address FROM (
        VALUES
            ('Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu'),
            ('Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN'),
            ('Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney'),
            ('miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt'),
            ('HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns'),
            ('HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb'),
            ('EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF'),
            ('epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn'),
            ('LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf'),
            ('LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj'),
            ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs'),
            ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'),
            ('SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'),
            ('DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd'),
            ('cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'),
            ('GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'),
            ('GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z'),
            ('96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s')
    ) AS t(address)
)

SELECT
    date_trunc('week', tr.block_time)   AS week,
    rw.rarity,
    approx_distinct(tr.tx_id)           AS plays,
    approx_distinct(tr.to_owner)        AS unique_players,
    COUNT(*)                            AS cards_distributed
FROM tokens_solana.transfers tr
INNER JOIN rarity_wallets rw
    ON tr.from_owner = rw.wallet
WHERE tr.block_date >= DATE '2026-01-01'
  AND tr.to_owner NOT IN (SELECT address FROM excluded_recipients)
GROUP BY 1, 2
ORDER BY week DESC, plays DESC
```

### Visualization 1: Stacked Bar

| Parameter | Value |
|-----------|-------|
| Chart type | Stacked Bar |
| X-axis | `week` |
| Y-axis | `cards_distributed` |
| Group by | `rarity` |
| Colors | Low=#94A3B8, Mid=#60A5FA, High=#3B82F6, Epic=#8B5CF6, Legend=#F59E0B, One=#EF4444, Sport=#10B981 |
| Height | 350px |

### Visualization 2: Line Chart

| Parameter | Value |
|-----------|-------|
| Chart type | Line |
| X-axis | `week` |
| Y-axis | `unique_players` |
| Group by | `rarity` |
| Colors | Same as Viz 1 |
| Height | 250px |

---

## QUERY C.7: COLLECTOR CRYPT KEY METRICS — THE P&L

### What It Does

Weekly P&L for Collector Crypt's gacha economy. Tracks USDC inflows (gacha spend), outflows (buybacks), fee wallet receipts, and net revenue. Based on DefiLlama adapter methodology.

### Dashboard Description

> **Title:** `CC Key Metrics — Weekly P&L (V2)`
> **Viz Title:** `Collector Crypt P&L: Revenue vs Buybacks`
> **Description:** Is Collector Crypt making money? Weekly USDC flows through the gacha system — what comes in (gacha spend), what goes out (buybacks to players), and what stays (net revenue + fees). When net_revenue is positive, the project is profitable.

### SQL

**File:** `queries/cards-dashboard/07_cc_key_metrics_pnl.sql`

```sql
-- Q7: Collector Crypt — Key Metrics P&L (weekly)
-- USDC flow analysis: gacha spend, buybacks, fees, net revenue
-- Based on DefiLlama adapter methodology (fees/collector-crypt/index.ts)
-- Engine: Medium

WITH gacha_weekly AS (
    SELECT
        date_trunc('week', block_time) AS week,
        SUM(amount_usd) AS gacha_spend
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
          '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
          'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
          'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
    GROUP BY 1
),

fees_weekly AS (
    SELECT
        date_trunc('week', block_time) AS week,
        SUM(amount_usd) AS fees
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner = 'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
    GROUP BY 1
),

buyback_weekly AS (
    SELECT
        date_trunc('week', block_time) AS week,
        SUM(amount_usd) AS buyback
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND from_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z'
      )
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND to_owner NOT IN (
          'BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M',
          '21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8',
          'DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE',
          'HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u',
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8',
          'Cc4pHGnoaRWL1WnHsV517T3YvQn5gLDBMiuVXkF9rZhK',
          '8373hLiAEXxaJ3oV7SRzx4KHwurEg9rEG98tUPj1sdtX',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
    GROUP BY 1
)

SELECT
    COALESCE(g.week, f.week, b.week)                                  AS week,
    COALESCE(ROUND(g.gacha_spend, 2), 0)                              AS gacha_spend,
    COALESCE(ROUND(b.buyback, 2), 0)                                  AS buyback,
    COALESCE(ROUND(f.fees, 2), 0)                                     AS fees,
    COALESCE(ROUND(g.gacha_spend, 2), 0)
      + COALESCE(ROUND(f.fees, 2), 0)
      - COALESCE(ROUND(b.buyback, 2), 0)                              AS net_revenue
FROM gacha_weekly g
FULL OUTER JOIN fees_weekly f ON g.week = f.week
FULL OUTER JOIN buyback_weekly b ON g.week = b.week
WHERE COALESCE(g.week, f.week, b.week) < date_trunc('week', NOW())
ORDER BY week DESC
```

### Visualization: Multi-series Bar + Line

| Parameter | Value |
|-----------|-------|
| Chart type | Mixed (Bar + Line) |
| X-axis | `week` |
| Bar series | `gacha_spend` (green), `buyback` (red) |
| Line series | `net_revenue` (blue, dashed) |
| Height | 350px |

---

## TEXT WIDGET C.F: METHODOLOGY & SOURCES

**Row C-14:** Full width (12 columns). Last widget.

```markdown
---

## Methodology & Sources

### Data Sources
- **Beezie (Base):** `nft.trades` — NFT contract `0xbb5ec6...16f`
- **Courtyard (Polygon):** `nft.trades` — NFT contract `0x251BE3...cAD` ⚠️ Provisional: only captures trades via indexed marketplaces. Courtyard's own marketplace pending Spellbook integration ([PR #8704](https://github.com/duneanalytics/spellbook/pull/8704))
- **Collector Crypt (Solana):** `tokens_solana.transfers` — USDC to 3 gacha wallets, internal addresses excluded per [DefiLlama methodology](https://github.com/DefiLlama/dimension-adapters/blob/master/fees/collector-crypt/index.ts)
- **Phygitals (Solana):** `tokens_solana.transfers` — USDC to gacha + lucky draw wallets, per [DefiLlama methodology](https://github.com/DefiLlama/dimension-adapters/blob/master/fees/phygitals/index.ts)
- **Upshot (Base):** `erc20_base.evt_Transfer` — USDC deposits to `0x939dbb...13b`

### Definitions
- **Volume** = Total USDC-equivalent inflows from users to project contracts (pack purchases, claw plays, deposits)
- **Market Share** = Project volume / total market volume × 100%
- **Secondary Volume** = NFT trades on marketplaces (OpenSea, MagicEden) + CARDS token DEX trading
- **Buyback** = USDC returned from gacha wallets to user wallets (instant liquidity mechanism)
- **WoW Growth** = (This week volume − Last week volume) / Last week volume × 100%

### Engine Requirements
- Solana queries require **medium engine** (small engine timeout on `tokens_solana.transfers`)
- EVM queries run on small engine
- Recommended refresh: every 6–12 hours

### Known Data Quality Issues
- ⚠️ **Courtyard:** Numbers likely undercount true marketplace volume. See [Courtyard Data Quality Note](#courtyard--data-quality-note)
- **Phygitals:** Card type breakdown not available on-chain in V1 (only total volume)
- **Cross-chain users:** Same person on multiple chains counted separately per chain

> Built by [AX1 Research](https://twitter.com/AX1ecosystem) | [GitHub](https://github.com/BOSSincrypto/base-agentic-ecosystem) | Dashboard V2 — May 2026
```

---

## VISUALIZATION SPECS

### Color Palette (chain-grouped)

| Project | Chain | Primary Color | HEX |
|---------|-------|---------------|-----|
| Beezie | Base | Blue | `#3B82F6` |
| Upshot | Base | Light Blue | `#60A5FA` |
| Courtyard | Polygon | Purple | `#8B5CF6` |
| Collector Crypt | Solana | Green | `#10B981` |
| Phygitals | Solana | Light Green | `#34D399` |
| (BNB future) | BNB | Amber | `#F59E0B` |

### Rarity Colors (CC Gacha)

| Rarity | Color | HEX |
|--------|-------|-----|
| Low | Slate | `#94A3B8` |
| Mid | Light Blue | `#60A5FA` |
| High | Blue | `#3B82F6` |
| Epic | Purple | `#8B5CF6` |
| Legend | Amber/Gold | `#F59E0B` |
| One | Red | `#EF4444` |
| Sport | Green | `#10B981` |

### P&L Colors

| Metric | Color | HEX |
|--------|-------|-----|
| Gacha Spend (inflow) | Green | `#10B981` |
| Buyback (outflow) | Red | `#EF4444` |
| Fees | Amber | `#F59E0B` |
| Net Revenue | Blue | `#3B82F6` |

---

## LAYOUT MAP

```
Row C-1:  [======== C.H: Dashboard Header (12 col) ========]
Row C-2:  [======== C.S1: Market Pulse text (12 col) =======]
Row C-3:  [KPI-1 (3)][KPI-2 (2)][KPI-3 (3)][KPI-4 (2)][KPI-5 (2)]
Row C-4:  [======== C.S2: Capital Race text (12 col) =======]
Row C-5:  [====== Q2 Viz1: Weekly Volume Stacked Bar (12 col) ======]
Row C-6:  [== Q2 Viz2: Market Share % Area (8 col) ==][Q3: Donut Pie (4 col)]
Row C-7:  [======== C.S3: Aftermarket text (12 col) ========]
Row C-8:  [====== Q4: Secondary Market Stacked Bar (12 col) ======]
Row C-9:  [======== C.S4: Deep Dive text (12 col) =========]
Row C-10: [== Q5: Card Types Donut (4 col) ==][== Q6 Viz1: Gacha Rarity Bar (8 col) ==]
Row C-11: [====== Q6 Viz2: Gacha Players Line (12 col) ======]
Row C-12: [====== Q7: CC P&L Bar+Line (12 col) ======]
Row C-13: [======== C.F: Methodology & Sources (12 col) ====]
```

**Total: 13 rows · 7 queries · 6 text widgets · 5 counters · 7 charts = 25 widgets**

---

## IMPLEMENTATION CHECKLIST

### Phase 1: Create Queries on Dune (Engine: Medium)

- [ ] Create Q1 (KPI Counters) → save as `Cards Market - KPI Counters (V2)`
- [ ] Create Q2 (Weekly Volume) → save as `Cards Market - Weekly Volume by Project (V2)`
- [ ] Create Q3 (Market Share) → save as `Cards Market - Market Dominance (V2)`
- [ ] Create Q4 (Secondary Market) → save as `Cards Market - Secondary Market (V2)`
- [ ] Create Q5 (Card Types) → save as `Cards Market - Card Types (V2)`
- [ ] Create Q6 (CC Gacha Plays) → save as `CC Gacha - Plays by Rarity (V2)` ⚠️ Medium engine
- [ ] Create Q7 (CC P&L) → save as `CC Key Metrics - Weekly P&L (V2)`

### Phase 2: Create Visualizations

- [ ] Q1 → 5 counter widgets
- [ ] Q2 → Stacked Bar + 100% Stacked Area
- [ ] Q3 → Donut Pie
- [ ] Q4 → Stacked Bar
- [ ] Q5 → Donut Pie
- [ ] Q6 → Stacked Bar + Line Chart
- [ ] Q7 → Mixed Bar + Line

### Phase 3: Build Dashboard

- [ ] Create new dashboard `Cards Market: The Gacha Economy Across Chains`
- [ ] Add all text widgets (6 total)
- [ ] Arrange per layout map (13 rows)
- [ ] Apply color palette
- [ ] Set descriptions on each visualization
- [ ] Set dashboard description (English)

### Phase 4: Quality Assurance

- [ ] Verify all 5 projects show data in Q2 stacked bar
- [ ] Verify market share % sums to ~100%
- [ ] Verify CC gacha plays show all 7 rarity tiers
- [ ] Verify P&L shows positive/negative net revenue
- [ ] Cross-reference CC numbers with DefiLlama ($33M cumulative revenue)
- [ ] Add ⚠️ note to Courtyard visualization description
- [ ] Set query refresh schedule (every 6–12 hours)
- [ ] Test all queries on Medium engine

---

## V2 ROADMAP

### V2.1 — Buybacks by Project
Track buyback flows (USDC from project wallets back to users):
- CC: from gacha wallets → users (partially in Q7 already)
- Phygitals: from `62Q9eeDY...` → users
- Beezie: SWAP feature (needs address identification)

### V2.2 — Buyer Cohort Analysis (Hempanda proposal)
Segment buyers by average check size:
- **Whales** (>$1000/week) — what % of volume do they control?
- **Middles** ($100–$1000/week) — core loyal base
- **Newcomers** (<$100/week) — market growth indicator

### V2.3 — Monthly Retention (from query 7432781)
Monthly cohort retention: what % of users from month N return in month N+1?
Heavy query, requires materialization.

### V2.4 — BNB Chain Integration
Add BNB chain projects when identified. Color: `#F59E0B` (Amber).

### V2.5 — Courtyard Fix
When Spellbook PR #8704 merges → Courtyard marketplace trades appear in `nft.trades`.
Alternative: parse raw Seaport events from `polygon.logs`.

### V2.6 — Phygitals Card Types
Phygitals supports: Pokémon, Baseball, Football, Basketball, One Piece, Yu-Gi-Oh!, Dragon Ball.
On-chain type classification requires cNFT metadata parsing (Metaplex DAS API or similar).

---

## KNOWN LIMITATIONS

1. **Courtyard tracks turnover** — Using raw `polygon.logs` marketplace events (trading volume + fees), NOT net revenue. Spellbook PR #8704 still open for `nft.trades` support. `unique_buyers` uses `tx_hash` count as proxy.
2. **Cross-chain user dedup** — Same person on multiple chains counted as separate users. True unique count requires off-chain identity resolution.
3. **Phygitals card types** — Cannot distinguish card types (Pokemon vs Sport vs One Piece) from on-chain USDC transfers alone. Requires cNFT metadata.
4. **Solana query weight** — `tokens_solana.transfers` is one of the heaviest Dune tables. Medium engine required; small engine consistently times out.
5. **No off-chain data** — Credit card purchases on Phygitals/Courtyard not captured (only on-chain USDC/crypto flows).
6. **Buyback completeness** — Buyback tracking may miss some internal rebalancing flows despite exclusion lists.
7. **BNB chain** — Referenced in team discussion but no specific project/address identified yet for V1.
