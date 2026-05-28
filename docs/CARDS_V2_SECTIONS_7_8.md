# Cards Market V2 — Sections 7, 8, 9: Полная Инструкция

> **Дашборд:** `Tokenized Cards Market 2026`
> **URL:** https://dune.com/ax1research/cards-market
> **Новые разделы:** Section 7 (CC Deep Dive), Section 8 (Card Type Mix), Section 9 (Beezie Deep Dive)
> **Дата:** Май 2026
> **Ревизия:** rev. 2 — на основе подтверждённых контрактов

---

## СОДЕРЖАНИЕ

1. [Общий план](#общий-план)
2. [Контракты и кошельки](#контракты-и-кошельки)
3. [Section 7: Collector Crypt Deep Dive](#section-7-collector-crypt-deep-dive)
4. [Section 8: Card Type Composition](#section-8-card-type-composition)
5. [Section 9: Beezie Deep Dive](#section-9-beezie-deep-dive)
6. [Cross-project: Market-Share Inflow Sources](#cross-project-market-share-inflow-sources)
7. [Методология](#методология)
8. [Визуализации и оформление](#визуализации-и-оформление)
9. [Цветовая палитра](#цветовая-палитра)
10. [Карта Layout](#карта-layout)
11. [Credit Optimization Checklist](#credit-optimization-checklist)
12. [Open Items / Dependencies](#open-items--dependencies)
13. [Порядок интеграции](#порядок-интеграции)

---

## ОБЩИЙ ПЛАН

### Что это за разделы

V2 расширяет Cards Market дашборд тремя новыми секциями:

| Section | Queries | Что отслеживает |
|---------|---------|----------------|
| **7) Collector Crypt Deep Dive** | 6 queries (7.1–7.4c) | Гача: plays/rarity, USDC inflow, buyback/net revenue, $CARDS token |
| **8) Card Type Composition** | 2 queries (8.1–8.2) | Тематические категории карт по всем проектам |
| **9) Beezie Deep Dive** | 2 queries (9.1–9.2) | Claw-машины по тирам, buyback через swap pool |

### Где располагаются

Порядок на дашборде Cards Market:
1. Overview (KPIs)
2. Weekly Volume by Project
3. Flow Composition
4. Market Share
5. **→ Section 8: Card Type Composition** ← НОВОЕ
6. Aftermarket
7. **→ Section 7: Collector Crypt Deep Dive** ← НОВОЕ
8. **→ Section 9: Beezie Deep Dive** ← НОВОЕ (если одобрено @ax1ecosystem)
9. Behavior by Chain *(v2)*
10. User Quality *(v2)*
11. Methodology (footer)

---

## КОНТРАКТЫ И КОШЕЛЬКИ

### Collector Crypt — Solana

| Роль | Адрес |
|------|-------|
| Gacha N | `GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3` |
| Gacha Z | `GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z` |
| Main | `96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s` |
| USDC Solana | `EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v` |
| $CARDS token | `CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp` |

**Exclusion list** (22 адреса — команда, боты, rarity-label, internal + сами gacha):
`BAxTk97H...`, `21KhtC7y...`, `DFEstpYN...`, `HW2HRqN1...`,
`Low6UekJ...`, `Lowq9dkp...`, `Mid9NeCp...`, `miDtj3vg...`,
`HighJBfn...`, `HiGHqwYd...`, `EpicWWZs...`, `epiC3zkq...`,
`LGNDXqcm...`, `LGNDfXQF...`, `onePMfir...`, `SportGmq...`,
`SPrT7eFr...`, `DQPERZ9e...`, `cc3novbX...`,
+ 3 gacha кошелька выше

### Beezie — Base

| Роль | Адрес |
|------|-------|
| Hub V1 (claw entry) | `0x964E72Ae6BE07a191bE1778DbC52457272a53154` |
| Hub V2 (routing) | `0xAa9CfAA6cAB4D3bFeEAb5deE99401df22f855A6b` |
| SWAP (buyback pool) | `0x80d7C04B738eF379971a6b73f25B1A71ea1c820D` |
| Fee receiver | `0x7b50cb4a207cf86a9ccec11aa14a3e45f2db5718` |
| NFT collection | `0xbb5ec6fd4b61723bd45c399840f1d868840ca16f` |
| Marketplace | `0xac305f7e7fe93a13b110b39ed98be556476d247f` |
| USDC Base | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` |

**Claw Machines — Old System** (15 машин, прямой inflow):

| Tier | Цена | Количество | Адреса |
|------|------|-----------|--------|
| Wildcard | $30 | 5 | `0x25Ac...`, `0x8ed2...`, `0xfdf2...`, `0x92D7...`, `0xa344...` |
| Silver TCG | $50 | 5 | `0x7B89...`, `0x7d71...`, `0x6863...`, `0x310B...`, `0x4067...` |
| Gold TCG | $250 | 4 | `0x044C...`, `0x1334...`, `0x6F4a...`, `0x08f4...` |
| Platinum TCG | $500 | 1 | `0x5dfb...` |

**Claw Machines — New System** (5 машин, inflow через Hub V1 → Hub V2):

| Tier | Адрес |
|------|-------|
| Wildcard | `0xe0fb...` |
| Silver TCG | `0x2b90...` |
| Gold TCG | `0x0d31...` |
| Platinum TCG | `0x2caa...` |
| No tier | `0x4e95...` |

### Decoded Table

`beezie_base.beezieclawmachinefactoryv2_evt_clawmachinecreated` — для автообнаружения новых машин.

---

## SECTION 7: COLLECTOR CRYPT DEEP DIVE

### Text Widget — Section Header

> Collector Crypt is the deepest single-project economy in this dashboard: a multi-tier gacha mint, an active buyback program, and a separate token layer ($CARDS) trading on Solana DEXes. The visualizations below isolate each flow so they read independently — what users pay in, what the project pays back, what gets minted by tier, and the token leg, which is economically distinct from the cards themselves.

---

### Query 7.1: Gacha Plays by Rarity

**Файл:** `queries/cards-market/01_cc_gacha_plays_by_rarity.sql`

**Назначение:** Еженедельное количество plays и распределённых карт из 3 gacha кошельков к внешним пользователям. Агрегированная версия (без разбивки по тирам) — rarity routing не подтверждён on-chain.

**Block text (dashboard):**
> Weekly play counts and cards distributed from Collector Crypt's gacha wallets. Counts are non-monetary (number of pulls and unique players); USDC value is shown separately in 7.2 because per-tier dollar attribution is not reliably recoverable on-chain.

**Источник данных:** `tokens_solana.transfers`

**Визуализация:**
- Тип: **Bar** (single series)
- X: `week` | Y: `plays` (toggle `cards_distributed`)
- KPI above: total plays last 4 wk, unique players last 4 wk
- Engine: **medium** (small таймаутит на Solana)

**Решение по дизайну:** Используем fallback (без tier split) пока @Hempanda не подтвердит, что mint route содержит rarity-label hop. Честный агрегат лучше красивой, но непроверенной разбивки.

---

### Query 7.2: Gacha Revenue (Inflow)

**Файл:** `queries/cards-market/02_cc_gacha_revenue_inflow.sql`

**Назначение:** Еженедельный USDC inflow в gacha кошельки — валовая выручка гачи до вычета buyback.

**Block text (dashboard):**
> USDC paid by users into Collector Crypt's gacha wallets — gross top-line of the gacha economy before buyback offset. This is what users spend to play; net revenue is in 7.3.

**Источник данных:** `tokens_solana.transfers` с фильтром `token_mint_address = USDC`

**Визуализация:**
- Тип: **Bar**
- X: `week` | Y: `usdc_inflow` ($0.0a формат)
- KPI: total inflow last 4 wk + WoW %
- Engine: **medium**

---

### Query 7.3: Buyback Outflow & Net Revenue

**Файл:** `queries/cards-market/03_cc_buyback_net_revenue.sql`

**Назначение:** USDC, возвращённый пользователям через buyback, и чистая выручка (inflow − outflow) по неделям.

**Block text (dashboard):**
> The mirror flow: USDC paid back to users when they sell cards into the buyback program. Net gacha revenue (line) is weekly inflow minus outflow — the money the project actually keeps. Negative weeks signal payout-heavy periods.

**Источник данных:** `tokens_solana.transfers` — два CTE (outflow + inflow) через `FULL OUTER JOIN`

**Визуализация:**
- Тип: **Combo** — bars `buyback_outflow`, line `net_revenue` (правая ось)
- KPI: total buybacks 4wk, net margin = SUM(net)/SUM(gross), buyback ratio = outflow/inflow
- Engine: **medium**

---

### Query 7.4a: $CARDS DEX Volume

**Файл:** `queries/cards-market/04_cc_cards_dex_volume.sql`

**Назначение:** Ежедневный объём торгов $CARDS на DEX и уникальные трейдеры.

**Block text (dashboard):**
> $CARDS is Collector Crypt's project token on Solana, separate from the gacha layer above. Token volume reflects speculator activity, not card spend, and should not be aggregated with gacha revenue.

**Источник данных:** `dex_solana.trades`

**Визуализация:**
- Тип: **Line + Bar combo**
- Bar: `dex_volume_usd` | Line: `unique_traders`
- Disclaimer: *"$CARDS DEX activity reflects speculation, not card spend. Separate layer."*
- Engine: **medium**

---

### Query 7.4b: $CARDS Price

**Файл:** `queries/cards-market/05_cc_cards_price.sql`

**Назначение:** Ежедневная цена $CARDS. Первичный источник: `prices.usd_daily` (если индексирован). Fallback: VWAP из DEX trades.

**Визуализация:**
- Тип: **Line**
- X: `day` | Y: `price`
- Engine: **small** (если prices.usd_daily) / **medium** (если VWAP fallback)

---

### Query 7.4c: $CARDS Top 20 Holders

**Файл:** `queries/cards-market/06_cc_cards_top_holders.sql`

**Назначение:** Топ-20 держателей $CARDS по net balance из всех transfers.

**Визуализация:**
- Тип: **Horizontal bar** (% labels)
- Y: `holder` (truncated) | X: `pct_supply`
- Engine: **medium**

**Примечание:** Подтвердить decimals $CARDS для корректного масштабирования balance.

---

## SECTION 8: CARD TYPE COMPOSITION

### Text Widget — Section Header

> The cards-on-chain market is not uniform: some projects skew Pokemon, others toward sport, One Piece, or other IP. This section shows what dominates overall and how each project distributes its catalogue. Beezie is excluded from the thematic view because its on-chain axis is claw tier (price/quality), not IP theme — that breakdown is in Beezie's deep-dive. Upshot is excluded entirely as a prediction-market product, not a card collection.

### Позиция на дашборде

Размещается **между Market Share и Aftermarket**.

---

### Query 8.1: Overall Market by Category (Donut)

**Файл:** `queries/cards-market/07_card_type_overall_pie.sql`

**Назначение:** Общий рынок карт по тематическим категориям (Pokemon, Sport, Marvel/Disney, One Piece, etc.). Объединяет данные Courtyard (Polygon) + Collector Crypt (Solana). Phygitals — stub до получения metadata source.

**Покрытие проектов:**
- **Courtyard** — категории из NFT metadata (Polygon). Strongest source.
- **Collector Crypt** — coarse split: Sport tier vs Pokemon default.
- **Phygitals** — multi-category, stub (metadata source TBD).
- **Beezie** — excluded (tier axis, not theme).
- **Upshot** — excluded (prediction market).

**Визуализация:**
- Тип: **Donut**
- Series: `category` | Values: `total_cards`
- Engine: **medium** (из-за CC на Solana)

---

### Query 8.2: Category Mix per Project (Stacked Bar)

**Файл:** `queries/cards-market/08_card_type_per_project.sql`

**Назначение:** 100%-нормализованная горизонтальная полоса, показывающая IP theme distribution по каждому проекту.

**Визуализация:**
- Тип: **Horizontal stacked bar**, 100%-normalized
- Y: `project` (sorted by total desc) | X: `pct_of_project`
- Series: `category` | Та же палитра, что и 8.1
- Engine: **medium**

---

## SECTION 9: BEEZIE DEEP DIVE

### Text Widget — Section Header

> Beezie runs a claw-machine gacha on Base across four price tiers (Wildcard $30, Silver TCG $50, Gold TCG $250, Platinum TCG $500), with a buyback swap pool and an internal marketplace. Two machine generations exist: an old system with 15 machines taking direct USDC inflow, and a new system routing through Hub V1 → Hub V2.

---

### Query 9.1: Claw Inflow by Tier

**Файл:** `queries/cards-market/09_beezie_claw_inflow.sql`

**Назначение:** Еженедельный USDC inflow в claw machines по тирам. Все 20 машин (old + new system).

**Источник данных:** `erc20_base.evt_transfer` с фильтром USDC Base

**Визуализация:**
- Тип: **Stacked bar**
- X: `week` | Y: `usdc_inflow` | Series: `tier`
- Engine: **small** (Base, не Solana)

**Self-maintaining machine list (рекомендация для v3):**
```sql
SELECT machine_address, tier
FROM beezie_base.beezieclawmachinefactoryv2_evt_clawmachinecreated
```
Это долгосрочное решение для "they keep changing contract addresses" — query factory event вместо static VALUES.

---

### Query 9.2: Buyback via Swap Pool

**Файл:** `queries/cards-market/10_beezie_buyback.sql`

**Назначение:** USDC из swap/buyback pool (`0x80d7...`) к пользователям.

**Источник данных:** `erc20_base.evt_transfer`

**Визуализация:**
- Тип: **Bar**
- X: `week` | Y: `buyback_usdc`
- KPI: total buyback 4wk, num_buybacks, unique_recipients
- Engine: **small**

---

## CROSS-PROJECT: MARKET-SHARE INFLOW SOURCES

Каноничные источники inflow по проектам для KPI и Market Share блоков:

| Project | Chain | Inflow definition | Key contract(s) |
|---------|-------|-------------------|-----------------|
| Collector Crypt | Solana | USDC → 3 gacha wallets | `GachaN`, `GachaZ`, `Main` |
| Beezie | Base | USDC → claw machines (old direct + new via Hub) | machines list / Hub `0x964E…` → `0xAa9C…` |
| Courtyard | Polygon | primary mint volume | `0x7760…`, topic0 `0x3ac0…`, `substring(data,97,32)/1e6` |
| Phygitals | Solana | USDC → gacha + lucky-draw wallets (pairwise exclusion) | `62Q9…`, `42oN…`, `4Sab…` |
| Upshot | Base | USDC deposits to cashier (NOT cards) | cashier `0x939d…`, exclude pool `0x5176…` |

### Courtyard: primary vs secondary vs buyback

```sql
SELECT date_trunc('week', evt_block_time) AS week,
       CASE WHEN feeAccrued > 0 THEN 'Secondary' ELSE 'Buyback' END AS flow_type,
       SUM(amount/1e6) AS usdc_volume
FROM courtyard_polygon.orderbook_evt_tradeexecuted
WHERE evt_block_time >= DATE '2026-01-01'
GROUP BY 1, 2
ORDER BY week DESC
```

### Phygitals: pairwise exclusion

```sql
-- Phygitals inflow: count USDC to gacha wallet only if NOT from sibling gacha/lucky-draw/treasury
-- Treasury sibling: 5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf
-- Apply per-destination exclusion as specified in the contract sheet.
```

### Upshot: deposits/withdrawals

```sql
-- Deposit topic0  0x6e610d33...  user=substring(topic1,13,20)  amt=to_uint(substring(data,1,32))/1e6
-- Withdrawal topic0 0x739fda11...
-- EXCLUDE sponsoring pool 0x517671cbe... and treasury 0x22fa745c...
-- Methodology note: Upshot = prediction market, included with asterisk, excluded from gacha/category blocks.
```

---

## МЕТОДОЛОГИЯ

### Section 7 — Collector Crypt

Money flows computed from `tokens_solana.transfers` on the three gacha wallets (`GachaN`, `GachaZ`, `Main`). Inflow = USDC users send in; buyback outflow = USDC sent back; net = inflow − outflow per week. A 22-address exclusion list (team, bots, rarity-label and internal addresses, and the gacha wallets themselves) removes internal movement. Rarity-tier splits shown for play counts only; per-tier USDC attribution is not reliably recoverable on-chain. $CARDS (`CARDScc…`) queried separately from `dex_solana.trades` and represents token speculation, not card spend.

### Section 8 — Card Type Composition

Cards grouped by IP theme. Courtyard categories from Polygon NFT metadata; Phygitals from Solana mint metadata (Pokemon, One Piece, sport, figurines) — stub until source available; Collector Crypt is a coarse Sport-vs-Pokemon split. Beezie excluded (its axis is claw price tier, shown in its deep-dive); Upshot excluded (prediction market).

### Section 9 — Beezie

Claw inflow is USDC into machine contracts on Base across four tiers, captured for both the legacy direct-inflow machines and the new Hub-routed machines; the machine set is discovered dynamically from the factory event to survive address rotation. Buyback is USDC out of the swap pool. Fees are USDC into the fee receiver.

### Phygitals Token

$PKMN ticker is reserved (confirmed Oct 2025, secured on Hyperliquid) but **no token is live**; there is no on-chain token data to show.

---

## ВИЗУАЛИЗАЦИИ И ОФОРМЛЕНИЕ

### Section 7

| Query | Виз. | X | Y | Доп. |
|-------|------|---|---|------|
| 7.1 Gacha Plays | Bar | week | plays | toggle cards_distributed |
| 7.2 Gacha Revenue | Bar | week | usdc_inflow | $0.0a format |
| 7.3 Buyback & Net | Combo | week | bars: buyback_outflow, line: net_revenue | right axis for line |
| 7.4a DEX Volume | Line+Bar | day | bar: dex_volume_usd, line: unique_traders | |
| 7.4b Price | Line | day | price | |
| 7.4c Top Holders | H-Bar | holder | pct_supply | % labels |

### Section 8

| Query | Виз. | X/Y | Series |
|-------|------|-----|--------|
| 8.1 Overall | Donut | — | category |
| 8.2 Per Project | H-Stacked Bar (100%) | project | category |

### Section 9

| Query | Виз. | X | Y | Series |
|-------|------|---|---|--------|
| 9.1 Claw Inflow | Stacked Bar | week | usdc_inflow | tier |
| 9.2 Buyback | Bar | week | buyback_usdc | — |

---

## ЦВЕТОВАЯ ПАЛИТРА

### Section 7 (Rarity, если будет включена)

| Rarity | HEX |
|--------|-----|
| Low | `#9CA3AF` |
| Mid | `#3B82F6` |
| High | `#8B5CF6` |
| Epic | `#EC4899` |
| Legend | `#F59E0B` |
| One | `#EF4444` |
| Sport | `#10B981` |
| Unmapped | `#374151` |

### Section 8 (Card Type)

| Category | HEX |
|----------|-----|
| Pokemon | `#FFCB05` |
| Sport | `#1E40AF` |
| Marvel/Disney | `#DC2626` |
| One Piece | `#F97316` |
| TCG other | `#7C3AED` |
| Figurine/Other | `#14B8A6` |
| Unknown | `#6B7280` |

### Section 9 (Beezie Tiers)

| Tier | HEX |
|------|-----|
| Wildcard | `#9CA3AF` |
| Silver TCG | `#3B82F6` |
| Gold TCG | `#F59E0B` |
| Platinum TCG | `#8B5CF6` |
| No tier | `#374151` |

---

## КАРТА LAYOUT

### Section 7 — Collector Crypt Deep Dive

```
Row 1: [Text Widget: CC Deep Dive header — full width]
Row 2: [KPI: total plays 4wk] [KPI: unique players 4wk] [KPI: total inflow 4wk]
Row 3: [7.1 Gacha Plays — Bar — 6/12] [7.2 Gacha Revenue — Bar — 6/12]
Row 4: [7.3 Buyback & Net Revenue — Combo — full width]
Row 5: [Text Widget: "$CARDS Token Economy" subheader]
Row 6: [7.4a DEX Volume — Line+Bar — 6/12] [7.4b Price — Line — 6/12]
Row 7: [7.4c Top Holders — H-Bar — full width]
```

### Section 8 — Card Type Composition

```
Row 1: [Text Widget: Card Type header — full width]
Row 2: [8.1 Overall — Donut — 5/12] [8.2 Per Project — H-Stacked Bar — 7/12]
```

### Section 9 — Beezie Deep Dive

```
Row 1: [Text Widget: Beezie header — full width]
Row 2: [9.1 Claw Inflow by Tier — Stacked Bar — 6/12] [9.2 Buyback — Bar — 6/12]
```

---

## CREDIT OPTIMIZATION CHECKLIST

- [ ] Материализовать CC exclusion list (22 адреса) + gacha list как один shared query; ссылаться из 7.1/7.2/7.3
- [ ] Материализовать Beezie machine list из factory event как один query; ссылаться из 9.1
- [ ] Материализовать 8.1 category CTEs; 8.1 и 8.2 оба читают — избежать двойного scan
- [ ] Обернуть 7.1–7.3 и 9.1–9.2 как Incremental Queries (weekly checkpoint) после V2 — Dune даёт до 100x экономии
- [ ] Solana-heavy queries (7.x, Phygitals, 8.1-CC) на **medium** engine; Base/Polygon (Beezie, Courtyard, Upshot) на **small**
- [ ] Все запросы: `block_date`/`evt_block_time` predicate на partition column; `approx_distinct` везде; всегда фильтр `token_mint_address`/`contract_address` до агрегации
- [ ] Прогнать каждый запрос через GPT "keep output identical, minimize Dune credits" (per @Hempanda 11.05)
- [ ] Целевой бюджет: ≤ 1200 credits на полный refresh (V1 был 840)

---

## OPEN ITEMS / DEPENDENCIES

| # | Item | Owner | Status |
|---|------|-------|--------|
| 1 | Подтвердить CC card mint route carries rarity-label hop → 7.1 tiered vs fallback | @Hempanda | BLOCKS 7.1 detail |
| 2 | $CARDS token decimals (для 7.4c balance scaling) | @Hempanda | TODO |
| 3 | Courtyard collection → category mapping (Pokemon/Sport/Marvel/One Piece/Unknown) | @remmez | BLOCKS 8.x Courtyard |
| 4 | Phygitals mint-metadata category source (table/field) | @Hempanda | BLOCKS 8.x Phygitals |
| 5 | Beezie new-system routing: users pay machines directly or via Hub V2? | @Hempanda | TODO |
| 6 | Confirm Beezie factory event column names for dynamic machine list | @Hempanda | TODO |
| 7 | Decision: add Beezie Deep Dive (S9) to V2, or hold for V3? | @ax1ecosystem | DECISION |
| 8 | Decision: confirm Section 8 moves between Market Share and Aftermarket | @ax1ecosystem | DECISION |
| 9 | $PKMN — no token live; keep as stub, re-check each release | — | RESOLVED |

---

## ПОРЯДОК ИНТЕГРАЦИИ

1. Build shared materialized queries first: CC exclusion+gacha list; Beezie machine list (from factory event); S8 category CTEs
2. Build S7 (7.1 fallback live by default, 7.2, 7.3, 7.4.a/b/c) → replace existing Section 7 content
3. Build S8 (8.1, 8.2) → place between Market Share and Aftermarket
4. Build S9 Beezie (9.1, 9.2) if @ax1ecosystem approves item 7
5. Update Market Share / inflow blocks to canonical sources in Cross-project section (esp. Courtyard feeAccrued split, Phygitals pairwise exclusion, Upshot asterisk)
6. Append methodology
7. Run credit optimization before sharing V2 link externally

---

*Rev. 2 — rebuilt on confirmed contracts. CC rarity routing (item 1) unresolved — 7.1 ships as honest aggregate until confirmed. $PKMN resolved: reserved ticker, no live token.*
