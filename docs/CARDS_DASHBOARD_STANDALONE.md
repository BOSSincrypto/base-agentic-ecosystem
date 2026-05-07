# CARDS DASHBOARD — Отдельный Дашборд (Standalone)

> **Название дашборда:** `Cards Market: Where Physical Trading Cards Meet Blockchain`
> **URL (предлагаемый):** `dune.com/ax1research/cards-market`
> **Платформа:** Dune Analytics (DuneSQL / Trino)
> **Чейны:** Base · Polygon · Solana (кросс-чейн)
> **Поддерживается:** [AX1 Community](https://twitter.com/AX1ecosystem)
> **Дата:** Май 2026

---

## СОДЕРЖАНИЕ

1. [Обзор и философия](#обзор-и-философия)
2. [Отслеживаемые проекты и адреса](#отслеживаемые-проекты-и-адреса)
3. [Collector Crypt — Gacha-архитектура](#collector-crypt--gacha-архитектура)
4. [Структура дашборда](#структура-дашборда)
5. [Text Widget C.H: Dashboard Header](#text-widget-ch-dashboard-header)
6. [Text Widget C.S1: Market Pulse Section](#text-widget-cs1-market-pulse-section)
7. [Query C.1: KPI Counters — Market at a Glance](#query-c1-kpi-counters--market-at-a-glance)
8. [Text Widget C.S2: Capital Flow Section](#text-widget-cs2-capital-flow-section)
9. [Query C.2: Weekly Volume — The Capital Race](#query-c2-weekly-volume--the-capital-race)
10. [Query C.3: Market Share — Who Controls the Ecosystem?](#query-c3-market-share--who-controls-the-ecosystem)
11. [Text Widget C.S3: Aftermarket Section](#text-widget-cs3-aftermarket-section)
12. [Query C.4: Secondary Market — The Aftermarket](#query-c4-secondary-market--the-aftermarket)
13. [Text Widget C.S4: Deep Dive Section](#text-widget-cs4-deep-dive-section)
14. [Query C.5: Card Types — What's in the Pack?](#query-c5-card-types--whats-in-the-pack)
15. [Query C.6: Collector Crypt Gacha — Inside the Machine](#query-c6-collector-crypt-gacha--inside-the-machine)
16. [Text Widget C.F: Methodology & Sources](#text-widget-cf-methodology--sources)
17. [Описания индикаторов](#описания-индикаторов)
18. [Визуализации и оформление](#визуализации-и-оформление)
19. [Карта Layout](#карта-layout)
20. [Цветовая палитра](#цветовая-палитра)
21. [Порядок действий на Dune — Чеклист](#порядок-действий-на-dune--чеклист)
22. [V2 Roadmap](#v2-roadmap)
23. [Известные ограничения](#известные-ограничения)

---

## ОБЗОР И ФИЛОСОФИЯ

### Что это

Отдельный Dune дашборд, посвящённый рынку **токенизированных коллекционных карточек** (RWA Cards / Gacha). Физические трейдинг-карты (Pokémon, спорт, аниме) токенизируются на блокчейне как NFT с хранением в сертифицированных хранилищах (PSA, Brink's, Fanatics). Пользователи могут покупать «паки» (gacha), торговать на вторичке и реднуть физические карты.

### Зачем отдельный дашборд

Аналогия: дашборд **Virtuals Protocol** от AX1 стал де-факто стандартом для маркет-шера AI-агентов — сам Virtuals репостит данные. Задача: **создать аналогичный стандарт для Cards-рынка** — единое место, где видна доля каждого проекта, совокупные объёмы, динамика.

### Ключевые принципы

1. **Простота** — минимум запросов, максимум ясности
2. **Достоверность** — только проверяемые on-chain данные
3. **Market share** — прозрачная доля каждого проекта
4. **Масс-маркет** — понятно людям без крипто-бэкграунда
5. **Кросс-чейн** — все проекты на одном графике (Base + Polygon + Solana)
6. **Визуальный нарратив** — каждый виджет рассказывает часть единой истории рынка

### Конкурентные дашборды

| Дашборд | URL | Покрытие | Слабость |
|---------|-----|----------|----------|
| Phygitals Dashboard | `dune.com/unit_tx/phygitals-dashboard` | Только Phygitals (Solana) | Один проект, один чейн |
| Pokemon TCG RWA SOL | `dune.com/zkayape/pokemontcgsol` | CC + Phygitals + Emporium | Только Solana, нет Base/Polygon |
| Sergey RUA — Courtyard | `dune.com/queries/7426512–7426783` | Только Courtyard (Polygon) | Один проект |
| Hempanda — Upshot | `dune.com/queries/7425705` | Только Upshot (Base) | Один проект |

**Наше преимущество:** ни один дашборд не объединяет ВСЕ проекты в одном месте с кросс-чейн маркет-шером. Это первый и единственный **aggregate view** всего рынка токенизированных карт.

---

## ОТСЛЕЖИВАЕМЫЕ ПРОЕКТЫ И АДРЕСА

| # | Project | Chain | Тип | Primary Address / Token | Источник данных |
|---|---------|-------|-----|------------------------|-----------------|
| 1 | **Beezie** | Base | NFT Claw Machine | `0xbb5ec6fd4b61723bd45c399840f1d868840ca16f` | `nft.trades` (blockchain='base') |
| 2 | **Courtyard** | Polygon | NFT Marketplace | `0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD` | `nft.trades` (blockchain='polygon') |
| 3 | **Collector Crypt** | Solana | Gacha + Token | Gacha: `GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3` | `tokens_solana.transfers` |
| 4 | **Upshot** | Base | Prediction Cards | `0x939dbbcf075de12d9d8df08ef727591ddebbc13b` | `erc20_base.evt_Transfer` |
| 5 | **Phygitals** | Solana | Pack Opening | cNFTs (Metaplex Bubblegum) | V2 — требуется идентификация wallets |

### Вспомогательные адреса

| Token | Chain | Address |
|-------|-------|---------|
| USDC (Base) | Base | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` |
| USDC (Polygon) | Polygon | `0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359` |
| USDC (Solana) | Solana | `EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v` |
| CARDS token | Solana | `CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp` |

---

## COLLECTOR CRYPT — GACHA-АРХИТЕКТУРА

Данные из команды (Sergey RUA, cont_2.md). Collector Crypt использует gacha-механику на Solana.

### Как работает gacha

1. Пользователь платит USDC → gacha-контракт (`GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3`)
2. VRF выбирает случайный пул редкости (Low → Legend)
3. Карта переводится из пула редкости → кошелёк пользователя
4. Пользователь может держать, торговать на вторичке или реднуть физическую карту

### Кошельки пулов редкости

| Rarity | Wallet 1 | Wallet 2 |
|--------|----------|----------|
| **Low** | `Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu` | `Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN` |
| **Mid** | `Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney` | `miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt` |
| **High** | `HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns` | `HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb` |
| **Epic** | `EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF` | `epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn` |
| **Legend** | `LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf` | — |
| **One** | `onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs` | — |
| **Sport** | `SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD` | — |

### Внутренние адреса (исключаются из аналитики)

| Адрес | Роль |
|-------|------|
| `DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd` | Fee wallet |
| `cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi` | CC internal |
| `GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3` | Gacha contract |

### Существующие публичные queries

| Query | URL | Описание | Движок |
|-------|-----|----------|--------|
| Plays by Rarity | Giedi (public) | Gacha-играх по редкости/день | Нужен medium (таймаут на small) |
| Monthly Retention | `dune.com/queries/7432781` | Ретеншн игроков | С 01.2026 из-за таймаута |
| Key Metrics | `dune.com/queries/7433053` | USDC P&L (spend, outflows, revenue, fees) | С 01.2026 |

---

## СТРУКТУРА ДАШБОРДА

Дашборд разделён на **4 тематических секции** с text-разделителями, плюс заголовок и футер. Каждая секция рассказывает свою часть истории рынка.

| Секция | Нарратив | Виджеты |
|--------|----------|---------|
| **Header** | Что такое рынок токенизированных карт и зачем за ним следить | 1 text widget |
| **Market Pulse** | Мгновенный снимок здоровья рынка: объём, пользователи, лидер, динамика | 1 text + 4 counters |
| **Capital Flow** | Куда текут деньги? Недельная динамика + общие доли рынка | 1 text + 2 charts |
| **Aftermarket** | Вторичный рынок: кто торгует после покупки паков? | 1 text + 1 chart |
| **Deep Dive** | Нишевые данные: типы карт + детальная механика gacha CC | 1 text + 2 charts |
| **Footer** | Методология, источники, определения, ограничения | 1 text widget |

**Итого: 6 queries · 6 text widgets · 4 counters · 5 charts = 21 виджет в 12 рядах**

---

## TEXT WIDGET C.H: DASHBOARD HEADER

**Ряд C-1:** Full width (12 колонок). Первое, что видит пользователь.

**Как добавить:** Edit dashboard → Add text widget → вставить текст → растянуть на 12 колонок.

**Текст (скопируй как есть):**

```markdown
# Cards Market: Where Physical Trading Cards Meet Blockchain

**The first cross-chain dashboard for tokenized collectible cards.** Physical Pokémon, sports, and anime trading cards — graded, vaulted, and tokenized as NFTs across Base, Polygon, and Solana. Each digital token is backed 1:1 by a real card stored in certified vaults (PSA, Brink's, Fanatics).

This is not speculation — it's a new asset class being built in real time.

**How the card market works:**
- **Buy Packs / Play the Machine** — Users pay USDC to open randomized packs (gacha) or operate claw machines, receiving NFT cards of varying rarity
- **Trade on the Secondary Market** — Cards trade freely on OpenSea, MagicEden, or native marketplaces just like any NFT
- **Redeem for Physical** — At any time, burn the NFT and receive the actual graded card shipped to your door
- **Buyback Floor** — Some projects guarantee instant buyback at 85–90% of fair market value, creating a price floor

**Four projects. Three chains. One market.**

| Project | Chain | Mechanic | What It Does |
|---------|-------|----------|-------------|
| **Beezie** | Base | NFT Claw Machine | Physical cards from digital claw grabs — gamified, social, viral |
| **Courtyard** | Polygon | NFT Marketplace | Premium graded cards tokenized and traded — the "blue chip" approach |
| **Collector Crypt** | Solana | Gacha Packs | Randomized card packs with 7 rarity tiers (Low → Legend) — pure gacha |
| **Upshot** | Base | Prediction Market | Card-backed prediction positions with USDC deposits |

> Built by [AX1 Research](https://twitter.com/AX1ecosystem) — the team behind the [Base Agentic Ecosystem](https://dune.com/ax1research/base-agentic-ecosystem) dashboard. Data: 2026 YTD | On-chain USDC inflows + NFT trades | Updated weekly
```

---

## TEXT WIDGET C.S1: MARKET PULSE SECTION

**Ряд C-2:** Full width (12 колонок). Разделитель перед KPI-каунтерами.

**Текст (скопируй как есть):**

```markdown
---

## Market Pulse: The Vital Signs

Four numbers that tell you everything about the health of the tokenized cards market. Total capital committed, unique participants, the current market leader, and week-over-week momentum — all derived from on-chain data across three blockchains.

> Think of these as the EKG of a market being born. Green means growing. Flat means consolidating. Red means we have a problem.
```

---

## QUERY C.1: KPI COUNTERS — MARKET AT A GLANCE

### Что он делает

Один консолидированный запрос для **4 ключевых цифр** в верхней части дашборда. Агрегирует данные со всех 4 проектов + вычисляет WoW-динамику для NFT-рынков (Base + Polygon).

### Описание для дашборда

> **Dashboard description:** The heartbeat of the tokenized cards market in four numbers — total capital inflows, active participants, who's winning, and whether the market is accelerating or cooling down. Cross-chain: Base + Polygon + Solana.

### Название при сохранении

`Cards Market - KPI Counters (V1)`

### SQL-код

**Файл:** `queries/cards-dashboard/05_kpi_counters.sql`

```sql
-- Q5: Combined KPI Counters
-- 4 key numbers for the top of the dashboard
-- Columns: total_volume_usd, unique_users, top_project, wow_growth_pct

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
        COALESCE(SUM(amount_usd), 0) AS vol,
        approx_distinct(buyer)       AS users
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= DATE '2026-01-01'
),

cc_vol AS (
    SELECT
        COALESCE(SUM(amount_usd), 0)   AS vol,
        approx_distinct(from_owner)    AS users
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner = 'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'
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

this_week AS (
    SELECT COALESCE(SUM(amount_usd), 0) AS vol
    FROM nft.trades
    WHERE blockchain IN ('base', 'polygon')
      AND nft_contract_address IN (
          0xbb5ec6fd4b61723bd45c399840f1d868840ca16f,
          0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      )
      AND block_time >= NOW() - INTERVAL '7' DAY
),

prev_week AS (
    SELECT COALESCE(SUM(amount_usd), 0) AS vol
    FROM nft.trades
    WHERE blockchain IN ('base', 'polygon')
      AND nft_contract_address IN (
          0xbb5ec6fd4b61723bd45c399840f1d868840ca16f,
          0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      )
      AND block_time >= NOW() - INTERVAL '14' DAY
      AND block_time <  NOW() - INTERVAL '7' DAY
),

totals AS (
    SELECT
        (SELECT vol FROM beezie_vol)
      + (SELECT vol FROM courtyard_vol)
      + (SELECT vol FROM cc_vol)
      + (SELECT vol FROM upshot_vol) AS total_volume,
        (SELECT users FROM beezie_vol)
      + (SELECT users FROM courtyard_vol)
      + (SELECT users FROM cc_vol)
      + (SELECT users FROM upshot_vol) AS total_users
),

top AS (
    SELECT project, vol FROM (
        VALUES
            ('Beezie',          (SELECT vol FROM beezie_vol)),
            ('Courtyard',       (SELECT vol FROM courtyard_vol)),
            ('Collector Crypt', (SELECT vol FROM cc_vol)),
            ('Upshot',          (SELECT vol FROM upshot_vol))
    ) AS t(project, vol)
    ORDER BY vol DESC
    LIMIT 1
)

SELECT
    ROUND((SELECT total_volume FROM totals), 0)  AS total_volume_usd,
    (SELECT total_users FROM totals)              AS unique_users,
    (SELECT project FROM top)                     AS top_project,
    ROUND(
        100.0 * ((SELECT vol FROM this_week) - (SELECT vol FROM prev_week))
        / NULLIF((SELECT vol FROM prev_week), 0)
    , 1)                                          AS wow_growth_pct
```

### Как оформить: 4 Counter Widgets (РЯД C-3)

Из одного запроса создаём **4 отдельных Counter визуализации**. Каждый каунтер — отдельный виджет по 3 колонки (3+3+3+3 = 12).

**Визуализация C.1a — "Total Market Volume" (Counter, 3 колонки)**

| Параметр | Значение |
|----------|----------|
| Тип | **Counter** |
| Column | `total_volume_usd` |
| Title | `Total Market Volume` |
| Description | `All USDC inflows across 4 projects and 3 chains since Jan 2026` |
| Prefix | `$` |
| Suffix | — |
| Decimals | 0 |
| Color | Amber `#F59E0B` |

**Как создать в Dune:**
1. Открой сохранённый запрос → Add visualization → **Counter**
2. Column: `total_volume_usd`
3. Row: 1
4. Title: `Total Market Volume`
5. Prefix: `$`
6. Цвет: `#F59E0B`

---

**Визуализация C.1b — "Unique Collectors" (Counter, 3 колонки)**

| Параметр | Значение |
|----------|----------|
| Тип | **Counter** |
| Column | `unique_users` |
| Title | `Unique Collectors` |
| Description | `Distinct wallet addresses that bought, traded, or deposited across all projects` |
| Prefix | — |
| Suffix | — |
| Decimals | 0 |
| Color | Purple `#8B5CF6` |

**Как создать в Dune:**
1. Add visualization → **Counter**
2. Column: `unique_users`
3. Title: `Unique Collectors`
4. Цвет: `#8B5CF6`

---

**Визуализация C.1c — "Market Leader" (Counter, 3 колонки)**

| Параметр | Значение |
|----------|----------|
| Тип | **Counter** |
| Column | `top_project` |
| Title | `Market Leader` |
| Description | `Project with the highest total volume YTD — the current king of the cards market` |
| Prefix | — |
| Suffix | — |
| Type | String |
| Color | Green `#10B981` |

**Как создать в Dune:**
1. Add visualization → **Counter**
2. Column: `top_project`
3. Title: `Market Leader`
4. Цвет: `#10B981`

---

**Визуализация C.1d — "Weekly Momentum" (Counter, 3 колонки)**

| Параметр | Значение |
|----------|----------|
| Тип | **Counter** |
| Column | `wow_growth_pct` |
| Title | `Weekly Momentum` |
| Description | `Week-over-week volume change for NFT markets (Base + Polygon). Green = growing, Red = cooling` |
| Prefix | — |
| Suffix | `%` |
| Decimals | 1 |
| Color | Green `#10B981` if positive, Red `#EF4444` if negative |

**Как создать в Dune:**
1. Add visualization → **Counter**
2. Column: `wow_growth_pct`
3. Title: `Weekly Momentum`
4. Suffix: `%`
5. Цвет: зависит от значения. Если число положительное → зелёный `#10B981`. Если отрицательное → красный `#EF4444`

---

## TEXT WIDGET C.S2: CAPITAL FLOW SECTION

**Ряд C-4:** Full width (12 колонок). Разделитель перед основными графиками.

**Текст (скопируй как есть):**

```markdown
---

## Capital Flow: Where the Money Goes

Every dollar entering the tokenized cards market leaves a trace on-chain. The charts below reveal two things: **velocity** (how much capital flows in each week) and **dominance** (who captures the largest share of that capital).

The stacked bars show weekly inflows by project — think of it as the scoreboard of a race that resets every Monday. The pie chart shows the cumulative result: after all the weekly races, who's actually winning the war?

**Reading the colors:** Each project is colored by its home chain — **blue family for Base**, **purple for Polygon**, **green for Solana**. When you see a color dominating, you're seeing a chain dominating.
```

---

## QUERY C.2: WEEKLY VOLUME — THE CAPITAL RACE

### Что он делает

Главный график дашборда (HERO CHART). Показывает **недельные объёмы входящих USDC** по каждому проекту. Stacked bars наглядно показывают, кто забирает наибольшую долю каждую неделю. Из этого же запроса можно создать 100% Stacked Area (market share % over time).

### Описание для дашборда

> **Dashboard description:** The weekly spending race across all four projects. Each bar represents one week of capital inflows in USD. Watch which colors grow and shrink — that's market share shifting in real time. Beezie and Courtyard trade via NFT marketplaces, Collector Crypt via gacha packs (Solana USDC), Upshot via USDC deposits.

### Название при сохранении

`Cards Market - Weekly Volume: The Capital Race (V1)`

### SQL-код

**Файл:** `queries/cards-dashboard/01_weekly_volume_by_project.sql`

```sql
-- Q1: Weekly Primary Volume by Project
-- Hero chart: stacked bar showing weekly volume in USD for each project
-- Also use for: 100% stacked area (market share % over time)
-- Viz 1: Stacked Bar (X: week, Y: volume_usd, Group: project)
-- Viz 2: 100% Stacked Area (normalized market share %)

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
        date_trunc('week', block_time)    AS week,
        'Courtyard'                       AS project,
        'Polygon'                         AS chain,
        COALESCE(SUM(amount_usd), 0)      AS volume_usd
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= DATE '2026-01-01'
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
      AND to_owner = 'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'
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

combined AS (
    SELECT * FROM beezie
    UNION ALL SELECT * FROM courtyard
    UNION ALL SELECT * FROM collector_crypt
    UNION ALL SELECT * FROM upshot
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

### Как оформить: 2 визуализации (РЯДЫ C-5, C-6)

**Визуализация C.2a — "The Capital Race: Weekly Inflows by Project" (Stacked Bar, РЯД C-5, 12 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Stacked Bar Chart** |
| X-axis | `week` (Date) |
| Y-axis | `volume_usd` (USD) |
| Group By | `project` |
| Stacking | Normal (stacked, not 100%) |
| Высота | 400px |
| Заголовок | `The Capital Race: Weekly Inflows by Project` |
| Описание | `Total USDC entering the cards market each week, broken down by project. Beezie & Courtyard = NFT trade volume. Collector Crypt = gacha pack purchases. Upshot = USDC deposits. Incomplete current week excluded.` |

**Цвета по проектам (chain-grouping):**

| Project | Chain | Color | HEX |
|---------|-------|-------|-----|
| Beezie | Base | Electric Blue | `#3B82F6` |
| Upshot | Base | Sky Blue | `#60A5FA` |
| Courtyard | Polygon | Royal Purple | `#8B5CF6` |
| Collector Crypt | Solana | Emerald Green | `#10B981` |

**Как создать в Dune:**
1. Открой запрос → New visualization → **Bar Chart**
2. X-axis: `week`
3. Y-axis: `volume_usd`
4. Group by: `project`
5. Stacking: **Stacked**
6. Назначь цвета каждому проекту по таблице выше
7. Title: `The Capital Race: Weekly Inflows by Project`
8. Y-axis label: `Volume (USD)`

---

**Визуализация C.2b — "Market Share Drift: Who's Gaining Ground?" (100% Stacked Area, РЯД C-6, 12 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **100% Stacked Area Chart** |
| X-axis | `week` (Date) |
| Y-axis | `volume_usd` (normalized to 100%) |
| Group By | `project` |
| Stacking | **Percent** (100%) |
| Высота | 300px |
| Заголовок | `Market Share Drift: Who's Gaining Ground?` |
| Описание | `Same data as above, but normalized to 100%. Watch the bands widen and narrow — that's market share shifting. A band growing from 20% to 40% means that project doubled its relative dominance, regardless of absolute volume.` |

**Цвета:** Те же, что и C.2a (chain-grouping).

**Как создать в Dune:**
1. Из того же запроса → New visualization → **Area Chart**
2. X-axis: `week`
3. Y-axis: `volume_usd`
4. Group by: `project`
5. Stacking: **Percent (100%)**
6. Назначь те же цвета
7. Title: `Market Share Drift: Who's Gaining Ground?`
8. Y-axis label: `Share (%)`

---

## QUERY C.3: MARKET SHARE — WHO CONTROLS THE ECOSYSTEM?

### Что он делает

Pie/donut chart с **кумулятивной долей** каждого проекта от общего объёма рынка. В отличие от weekly chart, показывает итоговую картину «кто в сумме забрал больше всех».

### Описание для дашборда

> **Dashboard description:** The grand total: which project has captured the most capital since January 2026? This pie chart slices the entire market by cumulative volume. A project owning 50%+ of this pie is the de facto market leader — and every other project is fighting for the remaining half.

### Название при сохранении

`Cards Market - Market Dominance Map (V1)`

### SQL-код

**Файл:** `queries/cards-dashboard/02_market_share_total.sql`

```sql
-- Q2: Market Share — Total Volume by Project
-- Pie chart: each project's share of total gacha/cards market
-- Color by chain grouping (Base=blue, Polygon=purple, Solana=green)

WITH beezie AS (
    SELECT
        'Beezie'  AS project,
        'Base'    AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= DATE '2026-01-01'
),

courtyard AS (
    SELECT
        'Courtyard'  AS project,
        'Polygon'    AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= DATE '2026-01-01'
),

collector_crypt AS (
    SELECT
        'Collector Crypt'  AS project,
        'Solana'           AS chain,
        COALESCE(SUM(amount_usd), 0) AS total_volume_usd
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND to_owner = 'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND from_owner NOT IN (
          'Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu',
          'Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN',
          'Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney',
          'miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt',
          'HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns',
          'HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb',
          'EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF',
          'epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn',
          'LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf',
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'
      )
),

upshot AS (
    SELECT
        'Upshot'  AS project,
        'Base'    AS chain,
        COALESCE(SUM(CAST(value AS DOUBLE) / 1e6), 0) AS total_volume_usd
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-01-01'
)

SELECT
    project,
    chain,
    ROUND(total_volume_usd, 2)              AS total_volume_usd,
    project || ' (' || chain || ')'         AS label
FROM (
    SELECT * FROM beezie
    UNION ALL SELECT * FROM courtyard
    UNION ALL SELECT * FROM collector_crypt
    UNION ALL SELECT * FROM upshot
)
ORDER BY total_volume_usd DESC
```

### Как оформить: Pie Chart (РЯД C-6, правая часть — или отдельный ряд)

**Визуализация C.3a — "Market Dominance: Who Controls the Ecosystem?" (Donut Pie, РЯД C-7, 12 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Pie Chart** (Donut) |
| Values | `total_volume_usd` |
| Labels | `label` (e.g., "Beezie (Base)") |
| Высота | 350px |
| Заголовок | `Market Dominance: Who Controls the Ecosystem?` |
| Описание | `Cumulative volume since Jan 2026. The label shows project name and home chain. A single slice >50% means one project dominates the entire market — that's either healthy leadership or dangerous concentration.` |

**Цвета:**

| Slice | Color | HEX |
|-------|-------|-----|
| Beezie (Base) | Electric Blue | `#3B82F6` |
| Courtyard (Polygon) | Royal Purple | `#8B5CF6` |
| Collector Crypt (Solana) | Emerald Green | `#10B981` |
| Upshot (Base) | Sky Blue | `#60A5FA` |

**Как создать в Dune:**
1. Открой запрос → New visualization → **Pie Chart**
2. Values: `total_volume_usd`
3. Labels: `label`
4. Donut: **Yes**
5. Назначь цвета по таблице
6. Title: `Market Dominance: Who Controls the Ecosystem?`
7. Show percentages: **Yes**

---

## TEXT WIDGET C.S3: AFTERMARKET SECTION

**Ряд C-8:** Full width (12 колонок). Разделитель перед Secondary Market.

**Текст (скопируй как есть):**

```markdown
---

## The Aftermarket: Life After the Pack

Primary sales tell you who's buying packs. Secondary sales tell you who's **staying**. When collectors trade cards among themselves — on OpenSea, MagicEden, or via the CARDS token on DEXes — it signals genuine demand beyond the initial gacha thrill.

**How to read this:** Beezie and Courtyard secondary = NFT peer-to-peer trades. Collector Crypt secondary = CARDS token DEX volume on Solana (each CARDS token is a proxy for card value). A project with high primary but low secondary has users who buy but don't trade — that could mean they're holding... or leaving.
```

---

## QUERY C.4: SECONDARY MARKET — THE AFTERMARKET

### Что он делает

Отслеживает объём **вторичных продаж** — торговлю между пользователями после первичной покупки. Beezie и Courtyard — через `nft.trades` (OpenSea, MagicEden, Blur). Collector Crypt — через DEX-торговлю токеном CARDS на Solana.

### Описание для дашборда

> **Dashboard description:** Secondary market health check. NFT trades (Beezie on Base, Courtyard on Polygon) and CARDS token DEX volume (Collector Crypt on Solana). High secondary volume = active collector community. Low secondary = either diamond hands or fading interest. Upshot excluded — its secondary market is not yet tokenized as tradable NFTs.

### Название при сохранении

`Cards Market - Aftermarket: Secondary Trading Volume (V1)`

### SQL-код

**Файл:** `queries/cards-dashboard/03_secondary_market_volume.sql`

```sql
-- Q3: Secondary Market Volume by Project
-- Tracks NFT secondary sales via nft.trades (OpenSea, MagicEden, Blur, etc.)
-- Collector Crypt secondary = CARDS token DEX volume (dex_solana.trades)

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
        date_trunc('week', block_time)  AS week,
        'Courtyard'                     AS project,
        'Polygon'                       AS chain,
        COALESCE(SUM(amount_usd), 0)    AS volume_usd,
        COUNT(*)                        AS trades,
        approx_distinct(buyer)          AS unique_buyers
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= DATE '2026-01-01'
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

combined AS (
    SELECT * FROM beezie_secondary
    UNION ALL SELECT * FROM courtyard_secondary
    UNION ALL SELECT * FROM collector_crypt_dex
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

### Как оформить: Stacked Bar + Table (РЯД C-9)

**Визуализация C.4a — "The Aftermarket: Weekly Secondary Trading Volume" (Stacked Bar, РЯД C-9, 8 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Stacked Bar Chart** |
| X-axis | `week` (Date) |
| Y-axis | `volume_usd` (USD) |
| Group By | `project` |
| Stacking | Normal (stacked) |
| Высота | 350px |
| Заголовок | `The Aftermarket: Weekly Secondary Volume` |
| Описание | `Peer-to-peer card trades on NFT marketplaces (Beezie, Courtyard) and CARDS token DEX swaps (Collector Crypt). Upshot excluded — no secondary NFT market. Incomplete weeks excluded.` |

**Цвета:** Те же (chain-grouping): Beezie `#3B82F6`, Courtyard `#8B5CF6`, CC `#10B981`

**Как создать в Dune:**
1. Открой запрос → New visualization → **Bar Chart**
2. X-axis: `week`
3. Y-axis: `volume_usd`
4. Group by: `project`
5. Stacking: **Stacked**
6. Title: `The Aftermarket: Weekly Secondary Volume`

---

**Визуализация C.4b — "Aftermarket Activity Table" (Table, РЯД C-9, 4 колонки)**

| Параметр | Значение |
|----------|----------|
| Тип | **Table** |
| Заголовок | `Aftermarket Activity` |
| Описание | `Detailed breakdown: trades, unique buyers, and volume per project per week` |

| Колонка | Формат |
|---------|--------|
| `week` | Date (YYYY-MM-DD) |
| `project` | String |
| `chain` | String |
| `volume_usd` | USD ($), 2 дес. |
| `trades` | Number |
| `unique_buyers` | Number |

Сортировка: `week` DESC.

**Как создать в Dune:**
1. Из того же запроса → New visualization → **Table**
2. Настрой форматы колонок
3. Сортировка: `week` DESC

---

## TEXT WIDGET C.S4: DEEP DIVE SECTION

**Ряд C-10:** Full width (12 колонок). Разделитель перед Deep Dive.

**Текст (скопируй как есть):**

```markdown
---

## Deep Dive: Inside the Cards and the Machine

Two questions that define the future of this market:

**1. What are people actually collecting?** The card type distribution reveals whether this market is driven by nostalgia (Pokémon) or utility (Sports). Today, the split is stark — and it tells us where the growth ceiling is.

**2. How does the gacha machine actually work?** Collector Crypt's rarity distribution is the heartbeat of their entire economy. Seven rarity tiers — from Low (most common) to One (literally unique) — each with dedicated on-chain wallets. The chart below shows how many cards flow from each rarity pool to players every week. When Legend and One distributions spike, something special is happening.
```

---

## QUERY C.5: CARD TYPES — WHAT'S IN THE PACK?

### Что он делает

Показывает распределение **типов карт** в экосистеме Collector Crypt. V1 использует данные из rarity pool wallets: Sport wallet = Sports карты, все остальные = Pokémon / TCG. V2 добавит кросс-проектный анализ через NFT metadata.

### Описание для дашборда

> **Dashboard description:** What's inside the packs? Collector Crypt's rarity pools reveal the split between Pokémon/TCG and Sport cards. Currently, the market is overwhelmingly Pokémon — but the Sport wallet is growing. When Sport share rises, it signals diversification beyond the nostalgia-driven Pokémon core.

### Название при сохранении

`Cards Market - What's in the Pack? Card Types (V1)`

### SQL-код

**Файл:** `queries/cards-dashboard/04_niche_card_types.sql`

```sql
-- Q4: Card Types Distribution (Niche Interest)
-- V1: Based on Collector Crypt rarity pool distributions
-- Sport wallet = Sport cards; all other rarity wallets = Pokemon / TCG
-- V2: Add cross-project type analysis via NFT metadata

WITH cc_distributions AS (
    SELECT
        CASE from_owner
            WHEN 'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'  THEN 'Sport'
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
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'
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
          'onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',
          'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
          'DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd',
          'cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi',
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'
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

### Как оформить: Pie Chart (РЯД C-11, левая часть)

**Визуализация C.5a — "What's in the Pack? Card Type Distribution" (Donut Pie, РЯД C-11, 6 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Pie Chart** (Donut) |
| Values | `cards_distributed` |
| Labels | `card_type` |
| Высота | 300px |
| Заголовок | `What's in the Pack? Card Type Distribution` |
| Описание | `Cards distributed from Collector Crypt rarity pools, classified by type. Sport wallet → Sport cards. All other rarity pools → Pokémon/TCG. V2 will add cross-project metadata analysis.` |

**Цвета:**

| Slice | Color | HEX | Why |
|-------|-------|-----|-----|
| Pokemon / TCG | Gold/Amber | `#F59E0B` | Pokémon's brand color association |
| Sport | Cyan | `#06B6D4` | Sports broadcasting feel |

**Как создать в Dune:**
1. Открой запрос → New visualization → **Pie Chart**
2. Values: `cards_distributed`
3. Labels: `card_type`
4. Donut: **Yes**
5. Pokemon / TCG: `#F59E0B`, Sport: `#06B6D4`
6. Title: `What's in the Pack? Card Type Distribution`
7. Show percentages: **Yes**

---

## QUERY C.6: COLLECTOR CRYPT GACHA — INSIDE THE MACHINE

### Что он делает

Самый детальный график на дашборде. Показывает **еженедельное распределение карт по тирам редкости** из gacha-контракта Collector Crypt на Solana. 7 тиров: Low → Mid → High → Epic → Legend → One → Sport. Каждый тир имеет выделенные on-chain кошельки.

### Описание для дашборда

> **Dashboard description:** Peer inside Collector Crypt's gacha engine. Every card distributed from a rarity pool to a player is a data point. Seven tiers of rarity — from **Low** (most common, cheapest floor) to **One** (literally a single unique card) — each tracked from dedicated on-chain wallets. When Legend and One distributions spike, it means high-value cards are entering circulation. Unique players show community breadth. Adapted from Giedi's public query. Recommended: medium engine (Solana transfers are heavy).

### Название при сохранении

`Cards Market - Inside the Machine: CC Gacha Rarity Distribution (V1)`

### SQL-код

**Файл:** `queries/cards-dashboard/06_collector_crypt_gacha_plays.sql`

```sql
-- Q6: Collector Crypt — Gacha Plays by Rarity (weekly)
-- Adapted from Giedi's public query (cont_2.md context)
-- Shows card distributions from rarity pools to players
-- Recommended: medium engine (Solana token transfers are heavy)

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
            ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs',   'One'),
            ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',  'Sport')
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
            ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs'),
            ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'),
            ('DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd'),
            ('cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'),
            ('GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3')
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

### Как оформить: Stacked Bar (РЯД C-11, правая часть + РЯД C-12)

**Визуализация C.6a — "Inside the Machine: Gacha Rarity Distribution" (Stacked Bar, РЯД C-11, 6 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Stacked Bar Chart** |
| X-axis | `week` (Date) |
| Y-axis | `cards_distributed` |
| Group By | `rarity` |
| Stacking | Normal (stacked) |
| Высота | 350px |
| Заголовок | `Inside the Machine: Gacha Rarity Distribution` |
| Описание | `Weekly cards distributed from each rarity tier. Low = most common. One = literally unique. The taller the bar, the more active the gacha economy. Watch for Legend/One spikes — those are rare drops entering the market.` |

**Цвета по тирам редкости (от холодных к горячим):**

| Rarity | Color | HEX | Мотивация |
|--------|-------|-----|-----------|
| Low | Slate Gray | `#94A3B8` | Common, unexciting |
| Mid | Cool Blue | `#60A5FA` | Stepping up |
| High | Teal | `#14B8A6` | Getting interesting |
| Epic | Purple | `#A78BFA` | Rare and desirable |
| Legend | Gold | `#F59E0B` | Legendary — gold standard |
| One | Hot Red | `#EF4444` | Unique — maximum rarity, maximum heat |
| Sport | Cyan | `#06B6D4` | Distinct category |

**Как создать в Dune:**
1. Открой запрос → New visualization → **Bar Chart**
2. X-axis: `week`
3. Y-axis: `cards_distributed`
4. Group by: `rarity`
5. Stacking: **Stacked**
6. Назначь цвета по таблице выше
7. Title: `Inside the Machine: Gacha Rarity Distribution`
8. Sort legend order: Low, Mid, High, Epic, Legend, One, Sport (от common к rare)

---

**Визуализация C.6b — "Gacha Players: Weekly Unique Participants" (Line Chart, РЯД C-12, 12 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Line Chart** |
| X-axis | `week` (Date) |
| Y-axis | `unique_players` |
| Group By | `rarity` |
| Высота | 250px |
| Заголовок | `Gacha Players: Weekly Unique Participants by Rarity` |
| Описание | `How many distinct wallets receive cards from each rarity tier each week? Rising lines = growing community. Converging lines = players are spreading across tiers (healthy). Only Low rising = new players entering at the bottom (growth phase).` |

**Цвета:** Те же, что и C.6a.

**Как создать в Dune:**
1. Из того же запроса → New visualization → **Line Chart**
2. X-axis: `week`
3. Y-axis: `unique_players`
4. Group by: `rarity`
5. Title: `Gacha Players: Weekly Unique Participants by Rarity`

---

## TEXT WIDGET C.F: METHODOLOGY & SOURCES

**Ряд C-13:** Full width (12 колонок). Последний виджет.

**Текст (скопируй как есть):**

```markdown
---

### Methodology, Data Sources & Definitions

#### What this dashboard tracks

This is an **aggregate market view** — the first dashboard to combine all major tokenized card projects across multiple blockchains into a single cross-chain comparison. Each project is tracked through its native on-chain data source (see table below).

| Project | Data Source | What's Measured | Chain |
|---------|-----------|----------------|-------|
| **Beezie** | `nft.trades` (Dune Spellbook) | NFT trade volume in USD | Base |
| **Courtyard** | `nft.trades` (Dune Spellbook) | NFT trade volume in USD | Polygon |
| **Collector Crypt** | `tokens_solana.transfers` | USDC inflows to gacha contract | Solana |
| **Upshot** | `erc20_base.evt_Transfer` | USDC deposits to contract | Base |
| **Collector Crypt (secondary)** | `dex_solana.trades` | CARDS token DEX volume | Solana |

#### Key definitions

- **Primary volume** — Capital entering the project for the first time: pack purchases, claw machine plays, USDC deposits
- **Secondary volume** — Peer-to-peer trading after initial purchase: NFT marketplace trades, CARDS token DEX swaps
- **Market share** — A project's cumulative primary volume as a percentage of total market volume
- **WoW (Week-over-Week)** — Percentage change in weekly NFT market volume (Base + Polygon) compared to the prior week
- **Gacha** — Japanese term for randomized prize mechanisms (like capsule toy machines). In crypto: pay USDC → receive a random NFT card of varying rarity
- **Rarity tiers** — Collector Crypt uses 7 tiers: Low, Mid, High, Epic, Legend, One, Sport. Each tier has dedicated on-chain wallets that distribute cards to players

#### Known limitations

| Limitation | Impact |
|------------|--------|
| **Beezie primary vs secondary not separated** | `nft.trades` captures all trades — we cannot distinguish first sale from resale without marketplace-specific filtering. Shown as one combined number |
| **Collector Crypt USDC only** | Gacha inflows tracked via USDC transfers to the gacha contract. If CC accepts other tokens in the future, they won't be captured until added |
| **Upshot: deposits only** | We track USDC flowing INTO the Upshot contract. Withdrawals and P&L are not yet tracked (V2) |
| **Phygitals: V2** | Compressed NFTs (Metaplex Bubblegum) require wallet identification before tracking can begin |
| **Cross-chain USD normalization** | All values shown in USD. NFT trades use Dune Spellbook's `amount_usd` (marketplace-reported). Solana USDC = 1:1 by definition |
| **WoW growth covers NFT markets only** | Solana gacha and Upshot deposits are not included in the WoW calculation due to different data structures |

#### Date range

All queries filter from **January 1, 2026** onward to minimize Dune credit consumption while capturing the full active period of all tracked projects.

#### Gacha contract internal addresses

Collector Crypt's gacha architecture uses dedicated wallets for each rarity tier. Transfers between these wallets, the fee wallet, and the gacha contract itself are excluded from all calculations to avoid double-counting internal fund movements. See the "Collector Crypt — Gacha Architecture" section above for the full address list.

> Built by [AX1 Research](https://twitter.com/AX1ecosystem) | Source code: [GitHub](https://github.com/BOSSincrypto/base-agentic-ecosystem) | Questions? [@AX1ecosystem](https://twitter.com/AX1ecosystem)
```

---

## ОПИСАНИЯ ИНДИКАТОРОВ

Краткие описания для каждого индикатора — использовать в **Description** поле виджетов на Dune.

### Query C.1: KPI Counters — Market at a Glance
> **Dashboard description:** The heartbeat of the tokenized cards market in four numbers — total capital inflows, active participants, who's winning, and whether the market is accelerating or cooling down. Cross-chain: Base + Polygon + Solana.

### Query C.2: Weekly Volume — The Capital Race
> **Dashboard description:** The weekly spending race across all four projects. Each bar represents one week of capital inflows in USD. Watch which colors grow and shrink — that's market share shifting in real time. Beezie and Courtyard trade via NFT marketplaces, Collector Crypt via gacha packs (Solana USDC), Upshot via USDC deposits.

### Query C.3: Market Share — Market Dominance Map
> **Dashboard description:** The grand total: which project has captured the most capital since January 2026? This pie chart slices the entire market by cumulative volume. A project owning 50%+ of this pie is the de facto market leader.

### Query C.4: Secondary Market — The Aftermarket
> **Dashboard description:** Secondary market health check. NFT trades (Beezie on Base, Courtyard on Polygon) and CARDS token DEX volume (Collector Crypt on Solana). High secondary volume = active collector community. Low secondary = either diamond hands or fading interest.

### Query C.5: Card Types — What's in the Pack?
> **Dashboard description:** What's inside the packs? Collector Crypt's rarity pools reveal the split between Pokémon/TCG and Sport cards. When Sport share rises, it signals diversification beyond the nostalgia-driven Pokémon core.

### Query C.6: Gacha Rarity — Inside the Machine
> **Dashboard description:** Peer inside Collector Crypt's gacha engine. Seven tiers of rarity — from Low (most common) to One (literally unique). When Legend and One distributions spike, high-value cards are entering circulation.

---

## ВИЗУАЛИЗАЦИИ И ОФОРМЛЕНИЕ

### Все визуализации дашборда

| # | ID | Тип | Источник | Заголовок | Ряд |
|---|------|-----|----------|-----------|-----|
| 1 | C.H | Text Widget | — | Cards Market: Where Physical Trading Cards Meet Blockchain | C-1 |
| 2 | C.S1 | Text Widget | — | Market Pulse: The Vital Signs | C-2 |
| 3 | C.1a | Counter | Query C.1 | Total Market Volume | C-3 |
| 4 | C.1b | Counter | Query C.1 | Unique Collectors | C-3 |
| 5 | C.1c | Counter | Query C.1 | Market Leader | C-3 |
| 6 | C.1d | Counter | Query C.1 | Weekly Momentum | C-3 |
| 7 | C.S2 | Text Widget | — | Capital Flow: Where the Money Goes | C-4 |
| 8 | C.2a | Stacked Bar | Query C.2 | The Capital Race: Weekly Inflows by Project | C-5 |
| 9 | C.2b | 100% Area | Query C.2 | Market Share Drift: Who's Gaining Ground? | C-6 |
| 10 | C.3a | Donut Pie | Query C.3 | Market Dominance: Who Controls the Ecosystem? | C-7 |
| 11 | C.S3 | Text Widget | — | The Aftermarket: Life After the Pack | C-8 |
| 12 | C.4a | Stacked Bar | Query C.4 | The Aftermarket: Weekly Secondary Volume | C-9 |
| 13 | C.4b | Table | Query C.4 | Aftermarket Activity | C-9 |
| 14 | C.S4 | Text Widget | — | Deep Dive: Inside the Cards and the Machine | C-10 |
| 15 | C.5a | Donut Pie | Query C.5 | What's in the Pack? Card Type Distribution | C-11 |
| 16 | C.6a | Stacked Bar | Query C.6 | Inside the Machine: Gacha Rarity Distribution | C-11 |
| 17 | C.6b | Line Chart | Query C.6 | Gacha Players: Weekly Unique Participants by Rarity | C-12 |
| 18 | C.F | Text Widget | — | Methodology, Data Sources & Definitions | C-13 |

**Итого: 6 queries · 6 text widgets · 4 counters · 3 stacked bars · 1 area · 2 pies · 1 line · 1 table = 18 виджетов в 13 рядах**

---

## КАРТА LAYOUT

```
=====================================================================
  CARDS MARKET: WHERE PHYSICAL TRADING CARDS MEET BLOCKCHAIN
=====================================================================

РЯД C-1:  [TEXT WIDGET C.H — 12 колонок]
          "Cards Market: Where Physical Trading Cards Meet Blockchain"
          Полное описание рынка, как работает gacha, 4 проекта, 3 чейна

---------------------------------------------------------------------

РЯД C-2:  [TEXT WIDGET C.S1 — 12 колонок]
          "Market Pulse: The Vital Signs"

РЯД C-3:  [4 КАУНТЕРА из Query C.1]
          | Total Market Volume | Unique Collectors | Market Leader | Weekly Momentum |
          |   3 кол, Amber     |   3 кол, Purple   |  3 кол, Green |   3 кол, Green  |

---------------------------------------------------------------------

РЯД C-4:  [TEXT WIDGET C.S2 — 12 колонок]
          "Capital Flow: Where the Money Goes"

РЯД C-5:  [CHART C.2a — 12 колонок]
          "The Capital Race: Weekly Inflows by Project"
          Stacked Bar (X: week, Y: volume_usd, Group: project)

РЯД C-6:  [CHART C.2b — 12 колонок]
          "Market Share Drift: Who's Gaining Ground?"
          100% Stacked Area (normalized market share %)

РЯД C-7:  [CHART C.3a — 12 колонок]
          "Market Dominance: Who Controls the Ecosystem?"
          Donut Pie (project shares of total volume)

---------------------------------------------------------------------

РЯД C-8:  [TEXT WIDGET C.S3 — 12 колонок]
          "The Aftermarket: Life After the Pack"

РЯД C-9:  [CHART C.4a — 8 колонок]         [TABLE C.4b — 4 колонки]
          "The Aftermarket: Weekly           "Aftermarket Activity"
           Secondary Volume"                  (detailed table)
          Stacked Bar

---------------------------------------------------------------------

РЯД C-10: [TEXT WIDGET C.S4 — 12 колонок]
          "Deep Dive: Inside the Cards and the Machine"

РЯД C-11: [CHART C.5a — 6 колонок]         [CHART C.6a — 6 колонок]
          "What's in the Pack?               "Inside the Machine: Gacha
           Card Type Distribution"            Rarity Distribution"
          Donut Pie                           Stacked Bar

РЯД C-12: [CHART C.6b — 12 колонок]
          "Gacha Players: Weekly Unique Participants by Rarity"
          Line Chart

---------------------------------------------------------------------

РЯД C-13: [TEXT WIDGET C.F — 12 колонок]
          "Methodology, Data Sources & Definitions"
```

---

## ЦВЕТОВАЯ ПАЛИТРА

### Тема: Chain-Grouping

Каждый проект окрашен в семейство цветов своей домашней цепочки. Это создаёт интуитивную визуальную связь: когда ты видишь, какой цвет доминирует на графике — ты сразу видишь, какой чейн доминирует.

### Цвета проектов (основные)

| Project | Chain | Color Name | HEX | Мотивация |
|---------|-------|------------|-----|-----------|
| **Beezie** | Base | Electric Blue | `#3B82F6` | Base brand — primary blue |
| **Upshot** | Base | Sky Blue | `#60A5FA` | Base family — lighter shade for distinction |
| **Courtyard** | Polygon | Royal Purple | `#8B5CF6` | Polygon brand association |
| **Collector Crypt** | Solana | Emerald Green | `#10B981` | Solana green family |

### Цвета тиров редкости (Gacha)

| Rarity | Color Name | HEX | Мотивация |
|--------|------------|-----|-----------|
| Low | Slate Gray | `#94A3B8` | Common, subdued |
| Mid | Cool Blue | `#60A5FA` | Stepping up in value |
| High | Teal | `#14B8A6` | Getting interesting |
| Epic | Soft Purple | `#A78BFA` | Rare and desirable |
| Legend | Gold | `#F59E0B` | Legendary — gold standard |
| One | Hot Red | `#EF4444` | Maximum rarity, maximum heat |
| Sport | Cyan | `#06B6D4` | Distinct sport category |

### Цвета типов карт

| Type | Color | HEX |
|------|-------|-----|
| Pokemon / TCG | Amber/Gold | `#F59E0B` |
| Sport | Cyan | `#06B6D4` |

### Утилитарные цвета

| Element | Color | HEX |
|---------|-------|-----|
| Volume / Money (counters) | Amber | `#F59E0B` |
| Growth / Positive | Green | `#10B981` |
| Decline / Negative | Red | `#EF4444` |
| Users / Community | Purple | `#8B5CF6` |
| Neutral / Muted | Slate | `#64748B` |

---

## ПОРЯДОК ДЕЙСТВИЙ НА DUNE — ЧЕКЛИСТ

### Фаза 1: Создание дашборда

- [ ] **1.1** Зайди на https://dune.com → New → Dashboard
- [ ] **1.2** Назови: `Cards Market: Where Physical Trading Cards Meet Blockchain`
- [ ] **1.3** Поставь **Public**

### Фаза 2: Создание запросов

- [ ] **2.1** New Query → Вставь SQL из Query C.1 → Run → Сохрани как `Cards Market - KPI Counters (V1)`
- [ ] **2.2** Создай **4 Counter визуализации** из Query C.1:
  - [ ] C.1a: Total Market Volume (col: `total_volume_usd`, prefix: `$`, цвет: `#F59E0B`)
  - [ ] C.1b: Unique Collectors (col: `unique_users`, цвет: `#8B5CF6`)
  - [ ] C.1c: Market Leader (col: `top_project`, цвет: `#10B981`)
  - [ ] C.1d: Weekly Momentum (col: `wow_growth_pct`, suffix: `%`, цвет: `#10B981`)
- [ ] **2.3** New Query → SQL из Query C.2 → Run → Сохрани как `Cards Market - Weekly Volume: The Capital Race (V1)`
- [ ] **2.4** Создай **2 визуализации** из Query C.2:
  - [ ] C.2a: Stacked Bar — "The Capital Race: Weekly Inflows by Project"
  - [ ] C.2b: 100% Stacked Area — "Market Share Drift: Who's Gaining Ground?"
- [ ] **2.5** New Query → SQL из Query C.3 → Run → Сохрани как `Cards Market - Market Dominance Map (V1)`
- [ ] **2.6** Создай **1 визуализацию**:
  - [ ] C.3a: Donut Pie — "Market Dominance: Who Controls the Ecosystem?"
- [ ] **2.7** New Query → SQL из Query C.4 → Run → Сохрани как `Cards Market - Aftermarket: Secondary Trading Volume (V1)`
- [ ] **2.8** Создай **2 визуализации** из Query C.4:
  - [ ] C.4a: Stacked Bar — "The Aftermarket: Weekly Secondary Volume"
  - [ ] C.4b: Table — "Aftermarket Activity"
- [ ] **2.9** New Query → SQL из Query C.5 → Run → Сохрани как `Cards Market - What's in the Pack? Card Types (V1)`
- [ ] **2.10** Создай **1 визуализацию**:
  - [ ] C.5a: Donut Pie — "What's in the Pack? Card Type Distribution"
- [ ] **2.11** New Query → SQL из Query C.6 → Run → Сохрани как `Cards Market - Inside the Machine: CC Gacha Rarity Distribution (V1)`
- [ ] **2.12** Создай **2 визуализации** из Query C.6:
  - [ ] C.6a: Stacked Bar — "Inside the Machine: Gacha Rarity Distribution"
  - [ ] C.6b: Line Chart — "Gacha Players: Weekly Unique Participants by Rarity"

### Фаза 3: Размещение виджетов на дашборде

- [ ] **3.1** Открой дашборд → Edit
- [ ] **3.2** Добавь Text Widget C.H (Row C-1): Header → 12 колонок
- [ ] **3.3** Добавь Text Widget C.S1 (Row C-2): Market Pulse → 12 колонок
- [ ] **3.4** Добавь 4 каунтера (Row C-3): C.1a + C.1b + C.1c + C.1d → по 3 колонки каждый
- [ ] **3.5** Добавь Text Widget C.S2 (Row C-4): Capital Flow → 12 колонок
- [ ] **3.6** Добавь Stacked Bar C.2a (Row C-5): Weekly Volume → 12 колонок
- [ ] **3.7** Добавь 100% Area C.2b (Row C-6): Market Share Drift → 12 колонок
- [ ] **3.8** Добавь Donut Pie C.3a (Row C-7): Market Dominance → 12 колонок
- [ ] **3.9** Добавь Text Widget C.S3 (Row C-8): Aftermarket → 12 колонок
- [ ] **3.10** Добавь Stacked Bar C.4a (Row C-9 left, 8 кол.) + Table C.4b (right, 4 кол.)
- [ ] **3.11** Добавь Text Widget C.S4 (Row C-10): Deep Dive → 12 колонок
- [ ] **3.12** Добавь Donut Pie C.5a (Row C-11 left, 6 кол.) + Stacked Bar C.6a (right, 6 кол.)
- [ ] **3.13** Добавь Line Chart C.6b (Row C-12): Gacha Players → 12 колонок
- [ ] **3.14** Добавь Text Widget C.F (Row C-13): Methodology → 12 колонок

### Фаза 4: Финальная проверка

- [ ] **4.1** Проверь все каунтеры: формат, цвет, prefix/suffix
- [ ] **4.2** Проверь все графики: цвета по chain-grouping, правильные оси
- [ ] **4.3** Проверь все text widgets: markdown рендерится корректно
- [ ] **4.4** Проверь порядок виджетов соответствует Layout карте выше
- [ ] **4.5** Проверь Beezie показывает данные (NFT trades на Base)
- [ ] **4.6** Проверь Courtyard показывает данные (NFT trades на Polygon)
- [ ] **4.7** Проверь Collector Crypt показывает gacha USDC inflows (Solana)
- [ ] **4.8** Проверь Upshot показывает USDC deposits (Base)
- [ ] **4.9** Проверь CC gacha rarity chart показывает все 7 тиров
- [ ] **4.10** Сохрани дашборд → убедись что Public

---

## V2 ROADMAP

Запланированные расширения после успешного запуска V1:

| # | Feature | Описание | Статус |
|---|---------|----------|--------|
| 1 | **Phygitals** | Добавить Phygitals (Solana cNFTs) как 5-й проект | Требуется идентификация wallet addresses |
| 2 | **Buyback Tracking** | Отслеживание buyback-программ (CC outflows, Beezie redemptions) | Нужны данные о buyback-механике каждого проекта |
| 3 | **Cohort Analysis** | Ретеншн пользователей по когортам первого взаимодействия | Уже есть base query от Giedi (Monthly Retention) |
| 4 | **CARDS Token Deep Dive** | Отдельная секция: price, holders, liquidity, concentration | DEX data доступна через `dex_solana.trades` |
| 5 | **Cross-Project Type Analysis** | Распределение типов карт через NFT metadata (не только CC Sport wallet) | Требуется исследование metadata-структуры |
| 6 | **Revenue / P&L** | Доходы проектов: fees, spreads, buyback margins | Есть base query (Key Metrics #7433053) |
| 7 | **Beezie Primary vs Secondary** | Разделить первичные продажи и вторичку для Beezie | Требуется marketplace-specific фильтрация |

---

## ИЗВЕСТНЫЕ ОГРАНИЧЕНИЯ

| Ограничение | Пояснение | Влияние |
|-------------|-----------|---------|
| **Beezie: primary + secondary объединены** | `nft.trades` не разделяет первичные и вторичные продажи без marketplace-фильтра | Volume может быть завышен для primary |
| **CC: только USDC gacha inflows** | Если CC начнёт принимать другие токены — нужно добавить | Возможен undercount |
| **Upshot: только deposits** | Withdrawals и P&L не трекаются в V1 | Неполная картина для Upshot |
| **Phygitals: отложен** | cNFTs через Metaplex Bubblegum требуют отдельного подхода | 5-й проект отсутствует |
| **WoW: только NFT рынки** | Solana gacha и Upshot не в WoW-расчёте | WoW не отражает полную картину |
| **Dune engine: medium рекомендуется** | Query C.6 (gacha) тяжёлый по Solana transfers | Таймаут на small engine |
