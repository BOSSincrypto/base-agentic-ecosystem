# CARDS DASHBOARD — Отдельный Дашборд (Standalone)

> **Дашборд:** `Cards: Tokenized Collectibles Market`
> **URL (предлагаемый):** `dune.com/ax1research/cards-market`
> **Платформа:** Dune Analytics (DuneSQL / Trino)
> **Чейны:** Base · Polygon · Solana (кросс-чейн)
> **Дата:** Май 2026

---

## СОДЕРЖАНИЕ

1. [Обзор и философия](#обзор-и-философия)
2. [Отслеживаемые проекты](#отслеживаемые-проекты)
3. [Collector Crypt — Gacha-архитектура](#collector-crypt--gacha-архитектура)
4. [Структура дашборда](#структура-дашборда)
5. [Text Widget: Header](#text-widget-header)
6. [Query 1: Weekly Volume by Project](#query-1-weekly-volume-by-project)
7. [Query 2: Market Share — Total](#query-2-market-share--total)
8. [Query 3: Secondary Market Volume](#query-3-secondary-market-volume)
9. [Query 4: Card Types Distribution](#query-4-card-types-distribution)
10. [Query 5: KPI Counters](#query-5-kpi-counters)
11. [Query 6: Collector Crypt — Gacha Plays by Rarity](#query-6-collector-crypt--gacha-plays-by-rarity)
12. [Визуализации и оформление](#визуализации-и-оформление)
13. [Карта Layout](#карта-layout)
14. [Цветовая палитра](#цветовая-палитра)
15. [Порядок действий — Чеклист](#порядок-действий--чеклист)
16. [V2 Roadmap](#v2-roadmap)
17. [Text Widget: Footer / Methodology](#text-widget-footer--methodology)

---

## ОБЗОР И ФИЛОСОФИЯ

### Что это

Отдельный Dune дашборд, посвящённый рынку **токенизированных коллекционных карточек** (RWA Cards / Gacha). Физические трейдинг-карты (Pokémon, спорт, аниме) токенизируются на блокчейне как NFT с хранением в сертифицированных хранилищах. Пользователи могут покупать «паки» (gacha), торговать на вторичке и реднуть физические карты.

### Зачем отдельный дашборд

Аналогия: дашборд **Virtuals Protocol** от AX1 стал де-факто стандартом для маркет-шера AI-агентов — сам Virtuals репостит данные. Задача: **создать аналогичный стандарт для Cards-рынка** — единое место, где видна доля каждого проекта, совокупные объёмы, динамика.

### Ключевые принципы (из обсуждения команды)

1. **Простота** — минимум запросов, максимум ясности
2. **Достоверность** — только проверяемые on-chain данные
3. **Market share** — прозрачная доля каждого проекта
4. **Масс-маркет** — понятно людям без крипто-бэкграунда
5. **Кросс-чейн** — все проекты на одном графике (Base + Polygon + Solana)

### Конкурентные дашборды (reference)

| Дашборд | URL | Покрытие |
|---------|-----|----------|
| Phygitals Dashboard | `dune.com/unit_tx/phygitals-dashboard` | Только Phygitals (Solana) |
| Pokemon TCG RWA SOL | `dune.com/zkayape/pokemontcgsol` | Collector Crypt + Phygitals + Emporium |
| Sergey RUA — Courtyard | `dune.com/queries/7426512–7426783` | Только Courtyard (Polygon) |
| Hempanda — Upshot | `dune.com/queries/7425705` | Только Upshot (Base) |

**Наше преимущество:** ни один дашборд не объединяет ВСЕ проекты в одном месте с кросс-чейн маркет-шером.

---

## ОТСЛЕЖИВАЕМЫЕ ПРОЕКТЫ

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

Новые данные из команды (Sergey RUA, cont_2.md). Collector Crypt использует gacha-механику на Solana.

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

Базовая структура из обсуждения команды (Hempanda, AX1, Sergey RUA):

| # | Widget | Тип | Описание |
|---|--------|-----|----------|
| H | **Header** | Text | Что такое gacha-рынок, как работает, почему важно |
| K | **KPI Counters** | 4× Counter | Total Volume · Unique Users · #1 Project · WoW Growth |
| 1 | **Weekly Volume** | Stacked Bar | Недельные объёмы по проектам (USDC inflow) — **HERO CHART** |
| 2 | **Market Share** | Pie Chart | Доля рынка по проектам (цвета по чейнам) |
| 3 | **Secondary Market** | Stacked Bar | Вторичка через OpenSea/MagicEden (nft.trades) |
| 4 | **Card Types** | Pie Chart | Типы карт (Pokémon, Sport, etc.) |
| 5 | **CC Gacha Plays** | Stacked Bar | Collector Crypt: играх по редкости (бонус) |
| F | **Footer** | Text | Методология, sources, V2 roadmap |

**Всего: 6 queries + 2 text widgets + 4 counters = 12 widgets, ~7 рядов**

---

## TEXT WIDGET: HEADER

Вставить как Text Widget в первый ряд дашборда (Full Width):

```markdown
# Cards: Tokenized Collectibles Market

Real World Asset (RWA) trading cards — Pokémon, sports, anime — tokenized on-chain. Each NFT is backed 1:1 by a physical card stored in certified vaults (PSA, Brink's, Fanatics).

**How the gacha market works:**
- 🎰 **Primary** — Users buy packs / play claw machines → receive random NFT cards
- 🔄 **Secondary** — Users trade cards on OpenSea, MagicEden, or native marketplaces
- 💵 **Buyback** — Some projects offer instant buyback at 85–90% fair market value
- 📦 **Redeem** — Claim the physical card shipped to your door

**Projects tracked:** Beezie (Base) · Courtyard (Polygon) · Collector Crypt (Solana) · Upshot (Base)
**Chains:** Base · Polygon · Solana | **Data:** On-chain USDC inflows + NFT trades

*Dashboard by [AX1 Research](https://twitter.com/AX1ecosystem) — the same team behind the [Base Agentic Ecosystem](https://dune.com/ax1research/base-agentic-ecosystem) dashboard*
```

---

## QUERY 1: WEEKLY VOLUME BY PROJECT

**Файл:** `queries/cards-dashboard/01_weekly_volume_by_project.sql`
**Назначение:** Главный график — недельные объёмы входящих средств по каждому проекту
**Визуализация:** Stacked Bar Chart (X: week, Y: volume_usd, Stack: project)
**Дополнительно:** 100% Stacked Area (normalized market share % over time)

### Что отслеживает по каждому проекту

| Project | Метрика | Источник |
|---------|---------|----------|
| Beezie | NFT trade volume (USD) | `nft.trades` Base |
| Courtyard | NFT trade volume (USD) | `nft.trades` Polygon |
| Collector Crypt | USDC gacha inflow | `tokens_solana.transfers` → Gacha wallet |
| Upshot | USDC deposits | `erc20_base.evt_Transfer` → Contract |

### SQL

```sql
-- Q1: Weekly Primary Volume by Project
-- Hero chart: stacked bar showing weekly volume in USD for each project
-- Also use for: 100% stacked area (market share % over time)

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
WHERE week < date_trunc('week', NOW())  -- exclude incomplete current week
ORDER BY week, project
```

### Настройка визуализации

**Viz 1 — Stacked Bar Chart:**
- Chart type: Bar
- X axis: `week`
- Y axis: `volume_usd`
- Group by: `project`
- Stacking: Stacked
- Colors: см. цветовую палитру

**Viz 2 — 100% Stacked Area (Market Share %):**
- Chart type: Area
- X axis: `week`
- Y axis: `volume_usd`
- Group by: `project`
- Stacking: Percent (normalized)
- Colors: см. цветовую палитру

---

## QUERY 2: MARKET SHARE — TOTAL

**Файл:** `queries/cards-dashboard/02_market_share_total.sql`
**Назначение:** Pie chart — общая доля рынка каждого проекта
**Визуализация:** Pie Chart (label: project + chain, value: total_volume_usd)

### SQL

```sql
-- Q2: Market Share — Total Volume by Project
-- Pie chart: shows each project's share of total gacha/cards market
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
    ROUND(total_volume_usd, 2)  AS total_volume_usd,
    project || ' (' || chain || ')' AS label
FROM (
    SELECT * FROM beezie
    UNION ALL SELECT * FROM courtyard
    UNION ALL SELECT * FROM collector_crypt
    UNION ALL SELECT * FROM upshot
)
ORDER BY total_volume_usd DESC
```

### Настройка визуализации

**Pie Chart:**
- Label: `label` (показывает "Beezie (Base)", "Courtyard (Polygon)" и т.д.)
- Value: `total_volume_usd`
- Colors: по цветовой палитре (чейн-группировка)

---

## QUERY 3: SECONDARY MARKET VOLUME

**Файл:** `queries/cards-dashboard/03_secondary_market_volume.sql`
**Назначение:** Вторичный рынок — объёмы торгов NFT на OpenSea / MagicEden
**Визуализация:** Stacked Bar Chart (X: week, Y: volume_usd, Stack: project)

### SQL

```sql
-- Q3: Secondary Market Volume by Project
-- Tracks NFT secondary sales via nft.trades (OpenSea, MagicEden, Blur, etc.)
-- Note: Collector Crypt secondary is token-based (dex_solana.trades), not NFT

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

### Настройка визуализации

**Stacked Bar Chart:**
- X axis: `week`
- Y axis: `volume_usd`
- Group by: `project`
- Stacking: Stacked

---

## QUERY 4: CARD TYPES DISTRIBUTION

**Файл:** `queries/cards-dashboard/04_niche_card_types.sql`
**Назначение:** Типы карт (Pokémon, Sport и др.) — распределение по нише
**Визуализация:** Pie Chart
**Примечание:** V1 использует данные Collector Crypt (доступны rarity wallets). Кросс-проектная типизация — V2.

### SQL

```sql
-- Q4: Card Types Distribution (Niche Interest)
-- V1: Based on Collector Crypt rarity pool distributions
-- Sport wallet distributions = Sport cards, others = Pokémon/TCG
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
    ROUND(100.0 * cards_distributed / NULLIF(SUM(cards_distributed) OVER (), 0), 1) AS pct
FROM cc_distributions
ORDER BY cards_distributed DESC
```

### Настройка визуализации

**Pie Chart:**
- Label: `card_type`
- Value: `cards_distributed`
- Title: "Card Types — Collector Crypt (V1)"

---

## QUERY 5: KPI COUNTERS

**Файл:** `queries/cards-dashboard/05_kpi_counters.sql`
**Назначение:** 4 KPI-каунтера для верхней части дашборда
**Визуализация:** 4 × Counter Widget

### SQL

```sql
-- Q5: Combined KPI Counters
-- 4 key numbers for the top of the dashboard
-- Columns: total_volume, unique_users, top_project, wow_growth_pct

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
        COALESCE(SUM(amount_usd), 0)        AS vol,
        approx_distinct(from_owner)          AS users
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

-- WoW: compare last 7d vs previous 7d total volume
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

### Настройка визуализации

Создать 4 Counter виджета из одного запроса:

| Counter | Column | Title | Prefix/Suffix |
|---------|--------|-------|---------------|
| 1 | `total_volume_usd` | Total Market Volume | `$` prefix |
| 2 | `unique_users` | Unique Participants | — |
| 3 | `top_project` | #1 Project | — |
| 4 | `wow_growth_pct` | WoW Growth | `%` suffix |

---

## QUERY 6: COLLECTOR CRYPT — GACHA PLAYS BY RARITY

**Файл:** `queries/cards-dashboard/06_collector_crypt_gacha_plays.sql`
**Назначение:** Бонусный deep-dive — gacha-машина CC по уровням редкости
**Визуализация:** Stacked Bar (X: week, Y: cards_distributed, Stack: rarity)
**Движок:** Рекомендуется medium (Solana queries тяжёлые)
**Источник:** Адаптация запроса Giedi (из cont_2.md)

### SQL

```sql
-- Q6: Collector Crypt — Gacha Plays by Rarity (weekly)
-- Adapted from Giedi's public query (cont_2.md)
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

### Настройка визуализации

**Stacked Bar Chart:**
- X axis: `week`
- Y axis: `cards_distributed`
- Group by: `rarity`
- Stacking: Stacked
- Colors: Low=#94A3B8, Mid=#3B82F6, High=#8B5CF6, Epic=#F59E0B, Legend=#EF4444, One=#EC4899, Sport=#10B981

**Table (дополнительно):**
- Columns: week, rarity, plays, unique_players, cards_distributed

---

## ВИЗУАЛИЗАЦИИ И ОФОРМЛЕНИЕ

### Сводная таблица виджетов

| # | Widget | Query | Chart Type | Width |
|---|--------|-------|------------|-------|
| H | Header | — | Text Widget | Full |
| K1 | Total Volume | Q5 | Counter | 1/4 |
| K2 | Unique Users | Q5 | Counter | 1/4 |
| K3 | #1 Project | Q5 | Counter | 1/4 |
| K4 | WoW Growth | Q5 | Counter | 1/4 |
| 1a | Weekly Volume | Q1 | Stacked Bar | 2/3 |
| 2a | Market Share | Q2 | Pie Chart | 1/3 |
| 1b | Market Share % | Q1 | 100% Stacked Area | Full |
| 3a | Secondary Market | Q3 | Stacked Bar | 2/3 |
| 4a | Card Types | Q4 | Pie Chart | 1/3 |
| 5a | CC Gacha Plays | Q6 | Stacked Bar | Full |
| F | Footer | — | Text Widget | Full |

---

## КАРТА LAYOUT

```
┌─────────────────────────────────────────────────────────────────┐
│ ROW 1: HEADER TEXT WIDGET (Full Width)                          │
│ What is gacha market, how it works, projects tracked            │
├────────────┬────────────┬────────────┬──────────────────────────┤
│ ROW 2:     │            │            │                          │
│ K1: Total  │ K2: Unique │ K3: #1     │ K4: WoW                  │
│ Volume $   │ Users      │ Project    │ Growth %                 │
├────────────┴────────────┴────────────┼──────────────────────────┤
│ ROW 3-4: Q1 — Weekly Volume          │ Q2 — Market Share        │
│ Stacked Bar Chart (2/3)              │ Pie Chart (1/3)          │
│ ████████████████████████             │     ████████             │
│ ████████████████████████             │   ██████████             │
├──────────────────────────────────────┴──────────────────────────┤
│ ROW 5-6: Q1 — Market Share % Over Time (Full Width)            │
│ 100% Stacked Area                                               │
│ ████████████████████████████████████████████████████████████    │
├──────────────────────────────────────┬──────────────────────────┤
│ ROW 7-8: Q3 — Secondary Market      │ Q4 — Card Types          │
│ Stacked Bar Chart (2/3)              │ Pie Chart (1/3)          │
│ ████████████████████████             │     ████████             │
├──────────────────────────────────────┴──────────────────────────┤
│ ROW 9-10: Q6 — Collector Crypt Gacha Plays by Rarity           │
│ Stacked Bar Chart (Full Width)                                  │
│ ████████████████████████████████████████████████████████████    │
├─────────────────────────────────────────────────────────────────┤
│ ROW 11: FOOTER TEXT WIDGET (Full Width)                         │
│ Methodology, data sources, V2 roadmap                           │
└─────────────────────────────────────────────────────────────────┘
```

---

## ЦВЕТОВАЯ ПАЛИТРА

### По проектам (группировка по чейну)

| Project | Chain | Primary Color | HEX |
|---------|-------|---------------|-----|
| **Beezie** | Base | Blue | `#3B82F6` |
| **Upshot** | Base | Light Blue | `#60A5FA` |
| **Courtyard** | Polygon | Purple | `#8B5CF6` |
| **Collector Crypt** | Solana | Green | `#10B981` |
| **Phygitals** (V2) | Solana | Light Green | `#34D399` |

> **Принцип:** проекты на одном чейне = похожие оттенки одного цвета.
> Визуально видна доля чейна в сумме (Hempanda).

### По редкости (CC Gacha)

| Rarity | Color | HEX |
|--------|-------|-----|
| Low | Gray | `#94A3B8` |
| Mid | Blue | `#3B82F6` |
| High | Purple | `#8B5CF6` |
| Epic | Amber | `#F59E0B` |
| Legend | Red | `#EF4444` |
| One | Pink | `#EC4899` |
| Sport | Green | `#10B981` |

### Общие элементы

| Element | HEX |
|---------|-----|
| Background | Dashboard default (dark) |
| Growth/Positive | `#10B981` (Green) |
| Decline/Negative | `#EF4444` (Red) |
| Volume/Money | `#F59E0B` (Amber) |

---

## ПОРЯДОК ДЕЙСТВИЙ — ЧЕКЛИСТ

### Создание дашборда на Dune

- [ ] 1. Создать новый дашборд: **Cards: Tokenized Collectibles Market**
- [ ] 2. Настроить URL slug: `cards-market`
- [ ] 3. Добавить Header Text Widget (Row 1) — скопировать текст из раздела выше
- [ ] 4. Создать Query 5 (KPI Counters) → 4 Counter виджета (Row 2)
- [ ] 5. Создать Query 1 (Weekly Volume) → Stacked Bar (Row 3-4, 2/3 width)
- [ ] 6. Создать Query 2 (Market Share) → Pie Chart (Row 3-4, 1/3 width)
- [ ] 7. Создать доп. визуализацию из Q1 → 100% Stacked Area (Row 5-6, Full)
- [ ] 8. Создать Query 3 (Secondary Market) → Stacked Bar (Row 7-8, 2/3 width)
- [ ] 9. Создать Query 4 (Card Types) → Pie Chart (Row 7-8, 1/3 width)
- [ ] 10. Создать Query 6 (CC Gacha Plays) → Stacked Bar (Row 9-10, Full)
- [ ] 11. Добавить Footer Text Widget (Row 11)
- [ ] 12. Применить цветовую палитру ко всем графикам
- [ ] 13. Проверить все запросы на small engine, пометить heavy queries (Q6) для medium

### Проверка

- [ ] Все 6 запросов выполняются без ошибок
- [ ] Stacked bars показывают все проекты
- [ ] Pie chart показывает market share с правильными цветами по чейнам
- [ ] KPI counters отображают актуальные данные
- [ ] Footer содержит методологию и V2 roadmap

---

## V2 ROADMAP

Из обсуждения команды — задачи для следующих итераций:

| # | Feature | Описание | Сложность |
|---|---------|----------|-----------|
| 1 | **Phygitals** | Добавить данные Phygitals (требуется идентификация payment wallets) | Medium |
| 2 | **Buybacks** | Трекинг buyback-операций по проектам (обратный выкуп карт) | Medium |
| 3 | **Cohort Analysis** | Когорты покупателей по среднему чеку (киты vs retail) | Hard |
| 4 | **Token Valuations** | Undervalued проекты в gacha-нише (CARDS token vs volume) | Medium |
| 5 | **Cross-project Types** | NFT metadata parsing для типов карт по всем проектам | Hard |
| 6 | **Monthly Retention** | Ретеншн игроков (адаптация dune.com/queries/7432781) | Medium |
| 7 | **P&L / Key Metrics** | Revenue-метрики (адаптация dune.com/queries/7433053) | Medium |
| 8 | **Materialization** | Материализация тяжёлых Solana-запросов для production | Medium |
| 9 | **BNB Chain** | Добавить проекты на BNB Chain (упомянуто Hempanda) | Easy |

### Ссылки на существующие queries для V2

| Query | Author | URL | Что делает |
|-------|--------|-----|-----------|
| Monthly Retention | Sergey RUA | `dune.com/queries/7432781` | Ретеншн CC игроков |
| Key Metrics (P&L) | Sergey RUA | `dune.com/queries/7433053` | USDC spend/outflows/revenue CC |
| Courtyard Queries (8 шт.) | Sergey RUA | `dune.com/queries/7426512–7426783` | Полная аналитика Courtyard |
| Upshot Activity | Hempanda | `dune.com/queries/7425705` | Upshot deposits/withdrawals |

---

## TEXT WIDGET: FOOTER / METHODOLOGY

```markdown
---

### Methodology

**Data sources:** On-chain data from Dune Analytics (DuneSQL). Cross-chain: Base · Polygon · Solana.

**Volume definition:**
- **Beezie / Courtyard:** NFT trade volume from `nft.trades` (includes primary + secondary on tracked marketplaces)
- **Collector Crypt:** USDC inflow to gacha contract (primary market spend)
- **Upshot:** USDC deposits to prediction card contract

**Limitations:**
- Off-chain payments (credit cards, Apple Pay) not captured
- Phygitals (Solana cNFTs) not yet included — planned for V2
- Collector Crypt secondary market tracked via CARDS token DEX volume (separate chart)
- Some marketplace volume may be missing if not indexed by Dune Spellbook

**V2 planned:** Phygitals · Buybacks · Cohort analysis · Token valuations · BNB Chain

*Built by [AX1 Research](https://twitter.com/AX1ecosystem) · [GitHub](https://github.com/BOSSincrypto/base-agentic-ecosystem)*
```
