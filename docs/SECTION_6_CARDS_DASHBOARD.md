# РАЗДЕЛ 6: Cards Dashboard — Полная Инструкция

> **Дашборд:** `Cards Dune: Tokenized Collectibles Market`
> **Основной дашборд:** https://dune.com/ax1research/base-agentic-ecosystem
> **Новый раздел:** Section 6 (Cards — RWA Tokenized Trading Cards)
> **Дата:** Май 2026

---

## СОДЕРЖАНИЕ

1. [Общий план](#общий-план)
2. [Отслеживаемые контракты](#отслеживаемые-контракты)
3. [Text Widget C: Section Header](#text-widget-c-section-header)
4. [Query C.1: Cards Ecosystem Pulse — Combined KPIs](#query-c1-cards-ecosystem-pulse--combined-kpis)
5. [Query C.2: Cards Projects Leaderboard](#query-c2-cards-projects-leaderboard)
6. [Query C.3: Cards Weekly Activity — Time Series](#query-c3-cards-weekly-activity--time-series)
7. [Query C.4: Beezie — NFT Activity & Volume (Base)](#query-c4-beezie--nft-activity--volume-base)
8. [Query C.5: Courtyard — Market Activity (Polygon)](#query-c5-courtyard--market-activity-polygon)
9. [Query C.6: Upshot — Deposits & Withdrawals (Base)](#query-c6-upshot--deposits--withdrawals-base)
10. [Query C.7: Collector Crypt — Token Trading (Solana)](#query-c7-collector-crypt--token-trading-solana)
11. [Визуализации и оформление](#визуализации-и-оформление)
12. [Карта Layout](#карта-layout)
13. [Цветовая палитра](#цветовая-палитра)
14. [Порядок действий на Dune — Чеклист](#порядок-действий-на-dune--чеклист)

---

## ОБЩИЙ ПЛАН

### Что это за раздел

Section 6 — **Cards Dashboard** — отслеживает ключевых игроков рынка токенизированных физических коллекционных карточек (RWA Cards). Это проекты, которые переносят физические трейдинг-карты (Pokémon, спорт, Marvel и др.) на блокчейн через NFT-токенизацию с хранением в сертифицированных хранилищах.

### Конкурентное преимущество

Ни один существующий Dune дашборд не объединяет **все** крупные cards-проекты в одном месте. Конкуренты делают дашборды по отдельным проектам — мы объединяем Beezie, Courtyard, Collector Crypt, Upshot и Phygitals в **единый** сравнительный дашборд с кросс-чейн аналитикой.

### Что добавляем

| Section | Queries | Widgets | Rows |
|---------|---------|---------|------|
| **6) Cards Dashboard** | 7 queries | 1 text + 6 counters + 8 charts + 2 tables + 2 pies = **19** | 14 рядов |

### Где располагается

Раздел создаётся как **ОТДЕЛЬНЫЙ дашборд** или добавляется **ПОСЛЕ** Section 5 (Tools & Infrastructure), **ПЕРЕД** Methodology footer.

Текущий порядок на дашборде:
1. Ecosystem Pulse (KPIs)
2. Cross-Pollination Index
3. Daily Activity
4. Leaderboard
5. ERC-8004 Registry
6. Virtuals Protocol
7. Base vs Solana
8. Section 5: Tools & Infrastructure
9. Section 3: Base Agentic Gaming
10. Section 4: OWB Compact
11. **→ Section 6: Cards Dashboard** ← НОВОЕ
12. Methodology (footer)

---

## ОТСЛЕЖИВАЕМЫЕ КОНТРАКТЫ

### Каждый проект — свой блокчейн и источник данных

| Project | Chain | Address / Token | Тип данных | Таблица в Dune |
|---------|-------|-----------------|------------|----------------|
| **Beezie** | Base | `0xbb5ec6fd4b61723bd45c399840f1d868840ca16f` | ERC-721 NFT (Beezie Collectibles — CCLT) | `nft.trades` + `base.logs` |
| **Courtyard** | Polygon | `0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD` | ERC-721 NFT (COURTYARD) | `nft.trades` + `polygon.logs` |
| **Collector Crypt** | Solana | `CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp` | SPL Token (CARDS) | `dex_solana.trades` |
| **Upshot** | Base | `0x939dbbcf075de12d9d8df08ef727591ddebbc13b` | USDC deposits/withdrawals | `erc20_base.evt_Transfer` |
| **Phygitals** | Solana | cNFTs (Metaplex Bubblegum) | Compressed NFTs — ограниченная on-chain data | V2 (данных в Dune пока недостаточно) |

### Вспомогательные адреса

| Token | Chain | Address | Роль |
|-------|-------|---------|------|
| **USDC (Base)** | Base | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` | Стейблкоин для Upshot deposits |
| **USDC (Polygon)** | Polygon | `0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359` | Стейблкоин на Polygon |

### Топик события (ERC-721 Transfer)

| Event | Topic0 | Используется для |
|-------|--------|-----------------|
| **Transfer** (ERC-721) | `0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef` | Минты (from=0x0), бёрны (to=0x0), переводы NFT |

### Ключевые метрики из чата команды

| Project | Известные данные | Источник |
|---------|-----------------|----------|
| **Beezie** | $28.2M claw volume, $14.3M gross income за 5 недель на Base (с 16 Jan 2026) | Dune Analytics, caggy.io |
| **Courtyard** | ATH по объёмам (май 2026), 8 queries готовы от Sergey RUA | dune.com/queries/7426512–7426783 |
| **Upshot** | 700 уников, $64.5K deposits, $35K withdrawals (с 22 Feb 2026) | Hempanda query #7425705 |
| **Collector Crypt** | $27M mcap, Solana-based | CoinDesk, dex_solana |
| **Phygitals** | cNFTs on Solana, ограниченная Dune data | docs.phygitals.com |

---

## TEXT WIDGET C: SECTION HEADER (РЯД C-1)

**Как добавить:** Edit dashboard → Add text widget → вставить текст → растянуть на 12 колонок.

**Текст (скопируй как есть):**

```markdown
---

## Cards Dashboard: Tokenized Collectibles Market

Physical trading cards are going on-chain. From Pokémon to sports memorabilia, a new wave of platforms is tokenizing real-world collectibles — storing the originals in certified vaults while their digital twins trade 24/7 on blockchain.

**What we track:**
- **Beezie** (Base) — Claw machine mechanics for physical card packs. $28M+ claw volume in first 5 weeks on Base. NFT-backed physical cards with optional redemption
- **Courtyard** (Polygon) — Pioneer of tokenized trading cards. Vault-and-tokenize model: physical cards stored by Brink's, NFTs tradeable on-chain. ATH volumes in 2026
- **Collector Crypt** (Solana) — Gacha-pack platform for graded Pokémon cards. CARDS token powers the ecosystem with buyback guarantees and marketplace fees
- **Upshot** (Base) — Prediction-card platform where users buy mystery packs tied to real-world events. Cash prizes for correct predictions
- **Phygitals** (Solana) — Compressed NFTs representing physical cards via Metaplex Bubblegum. Data integration coming in V2

**Why this matters:** The tokenized cards market is growing faster than most NFT verticals. These projects prove real demand for **physical-digital hybrid** collectibles with verifiable on-chain provenance.

> Cross-chain coverage: Base + Polygon + Solana. This is the only dashboard tracking all major cards platforms in one place.
```

---

## QUERY C.1: Cards Ecosystem Pulse — Combined KPIs

### Что он делает
Один консолидированный запрос, который выдаёт 6 KPI-каунтеров. Собирает данные из 3 блокчейнов через UNION ALL:
- Beezie NFT trades (Base) из `nft.trades`
- Courtyard NFT trades (Polygon) из `nft.trades`
- Collector Crypt token trades (Solana) из `dex_solana.trades`
- Upshot USDC deposits (Base) из `erc20_base.evt_Transfer`

### Название при сохранении
`Cards Ecosystem Pulse — Combined KPIs (V1)`

### SQL-код

```sql
-- Section 6: Cards Dashboard — Combined KPIs
-- Cross-chain: Base (Beezie, Upshot) + Polygon (Courtyard) + Solana (Collector Crypt)
-- Date range: 2025-01-01+ (Courtyard active earlier)

-- ============================================================
-- 1) Beezie — NFT trades on Base
-- ============================================================
WITH beezie_trades AS (
    SELECT
        'Beezie' AS project,
        'Base' AS chain,
        block_time,
        tx_hash,
        buyer AS user_address,
        amount_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= TIMESTAMP '2026-01-01'
),

-- ============================================================
-- 2) Courtyard — NFT trades on Polygon
-- ============================================================
courtyard_trades AS (
    SELECT
        'Courtyard' AS project,
        'Polygon' AS chain,
        block_time,
        tx_hash,
        buyer AS user_address,
        amount_usd
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= TIMESTAMP '2025-01-01'
),

-- ============================================================
-- 3) Collector Crypt — CARDS token trades on Solana
-- ============================================================
collector_crypt_trades AS (
    SELECT
        'Collector Crypt' AS project,
        'Solana' AS chain,
        block_time,
        tx_id AS tx_hash,
        trader_id AS user_address,
        amount_usd
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= TIMESTAMP '2025-08-01'
),

-- ============================================================
-- 4) Upshot — USDC deposits on Base
-- ============================================================
upshot_txs AS (
    SELECT
        'Upshot' AS project,
        'Base' AS chain,
        evt_block_time AS block_time,
        evt_tx_hash AS tx_hash,
        "from" AS user_address,
        CAST(value AS DOUBLE) / 1e6 AS amount_usd
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-02-01'
),

-- ============================================================
-- Combine all projects
-- ============================================================
all_txs AS (
    SELECT project, chain, block_time, tx_hash, user_address, amount_usd FROM beezie_trades
    UNION ALL
    SELECT project, chain, block_time, tx_hash, user_address, amount_usd FROM courtyard_trades
    UNION ALL
    SELECT project, chain, block_time, tx_hash, CAST(user_address AS VARCHAR) AS user_address, amount_usd FROM collector_crypt_trades
    UNION ALL
    SELECT project, chain, block_time, tx_hash, CAST(user_address AS VARCHAR) AS user_address, amount_usd FROM upshot_txs
),

-- ============================================================
-- KPIs
-- ============================================================
total_kpi AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS total_trades,
        COUNT(DISTINCT user_address) AS unique_users,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS total_volume_usd,
        COUNT(DISTINCT project) AS active_projects
    FROM all_txs
),

this_week AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS week_trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS week_volume
    FROM all_txs
    WHERE block_time >= now() - interval '7' day
),

prev_week AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS prev_trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS prev_volume
    FROM all_txs
    WHERE block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

chain_split AS (
    SELECT
        chain,
        COUNT(DISTINCT tx_hash) AS chain_trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS chain_volume
    FROM all_txs
    GROUP BY 1
)

SELECT
    t.total_trades AS "Total Trades (All-Time)",
    t.unique_users AS "Unique Users (All-Time)",
    t.total_volume_usd AS "Total Volume USD",
    t.active_projects AS "Active Projects",
    tw.week_trades AS "This Week Trades",
    tw.week_volume AS "This Week Volume USD",
    CASE
        WHEN pw.prev_trades > 0
        THEN ROUND(100.0 * (tw.week_trades - pw.prev_trades) / pw.prev_trades, 1)
        ELSE 0
    END AS "WoW Trades Growth %",
    CASE
        WHEN pw.prev_volume > 0
        THEN ROUND(100.0 * (tw.week_volume - pw.prev_volume) / NULLIF(pw.prev_volume, 0), 1)
        ELSE 0
    END AS "WoW Volume Growth %",
    COALESCE(MAX(CASE WHEN cs.chain = 'Base' THEN cs.chain_volume END), 0) AS "Base Volume USD",
    COALESCE(MAX(CASE WHEN cs.chain = 'Polygon' THEN cs.chain_volume END), 0) AS "Polygon Volume USD",
    COALESCE(MAX(CASE WHEN cs.chain = 'Solana' THEN cs.chain_volume END), 0) AS "Solana Volume USD"
FROM total_kpi t
CROSS JOIN this_week tw
CROSS JOIN prev_week pw
CROSS JOIN chain_split cs
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
```

### Визуализация

**6 каунтеров** — каждый из одной колонки результата:

| # | Counter Title | Column | Format |
|---|---------------|--------|--------|
| 1 | Total Trades | `Total Trades (All-Time)` | Number, no decimals |
| 2 | Unique Users | `Unique Users (All-Time)` | Number, no decimals |
| 3 | Total Volume | `Total Volume USD` | `$` prefix, 0 decimals |
| 4 | This Week Volume | `This Week Volume USD` | `$` prefix, 0 decimals |
| 5 | WoW Trades Growth | `WoW Trades Growth %` | `%` suffix, 1 decimal. Green if > 0, red if < 0 |
| 6 | WoW Volume Growth | `WoW Volume Growth %` | `%` suffix, 1 decimal. Green if > 0, red if < 0 |

---

## QUERY C.2: Cards Projects Leaderboard

### Что он делает
Сравнительная таблица всех проектов — объём, юзеры, тренды. Показывает кто лидер по каждому параметру.

### Название при сохранении
`Cards Projects Leaderboard (V1)`

### SQL-код

```sql
-- Section 6: Cards Leaderboard — All Projects Comparison
-- Shows 30d metrics + WoW momentum for each project

-- ============================================================
-- Beezie (Base) — NFT secondary market
-- ============================================================
WITH beezie_30d AS (
    SELECT
        'Beezie' AS project,
        'Base' AS chain,
        COUNT(*) AS trades_30d,
        COUNT(DISTINCT buyer) AS buyers_30d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_30d
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= now() - interval '30' day
),

beezie_7d AS (
    SELECT
        COUNT(*) AS trades_7d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_7d
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= now() - interval '7' day
),

beezie_prev7d AS (
    SELECT
        COUNT(*) AS trades_prev7d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_prev7d
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

-- ============================================================
-- Courtyard (Polygon) — NFT secondary market
-- ============================================================
courtyard_30d AS (
    SELECT
        'Courtyard' AS project,
        'Polygon' AS chain,
        COUNT(*) AS trades_30d,
        COUNT(DISTINCT buyer) AS buyers_30d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_30d
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= now() - interval '30' day
),

courtyard_7d AS (
    SELECT
        COUNT(*) AS trades_7d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_7d
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= now() - interval '7' day
),

courtyard_prev7d AS (
    SELECT
        COUNT(*) AS trades_prev7d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_prev7d
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

-- ============================================================
-- Collector Crypt (Solana) — CARDS token DEX trades
-- ============================================================
cc_30d AS (
    SELECT
        'Collector Crypt' AS project,
        'Solana' AS chain,
        COUNT(*) AS trades_30d,
        COUNT(DISTINCT trader_id) AS buyers_30d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_30d
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= now() - interval '30' day
),

cc_7d AS (
    SELECT
        COUNT(*) AS trades_7d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_7d
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= now() - interval '7' day
),

cc_prev7d AS (
    SELECT
        COUNT(*) AS trades_prev7d,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_prev7d
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= now() - interval '14' day
      AND block_time < now() - interval '7' day
),

-- ============================================================
-- Upshot (Base) — USDC deposits
-- ============================================================
upshot_30d AS (
    SELECT
        'Upshot' AS project,
        'Base' AS chain,
        COUNT(DISTINCT evt_tx_hash) AS trades_30d,
        COUNT(DISTINCT "from") AS buyers_30d,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS volume_30d
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= now() - interval '30' day
),

upshot_7d AS (
    SELECT
        COUNT(DISTINCT evt_tx_hash) AS trades_7d,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS volume_7d
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= now() - interval '7' day
),

upshot_prev7d AS (
    SELECT
        COUNT(DISTINCT evt_tx_hash) AS trades_prev7d,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS volume_prev7d
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= now() - interval '14' day
      AND evt_block_time < now() - interval '7' day
),

-- ============================================================
-- Combine into leaderboard
-- ============================================================
combined AS (
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM beezie_30d
    UNION ALL
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM courtyard_30d
    UNION ALL
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM cc_30d
    UNION ALL
    SELECT project, chain, trades_30d, buyers_30d, volume_30d FROM upshot_30d
),

weekly AS (
    SELECT 'Beezie' AS project, b7.trades_7d, b7.volume_7d, bp.trades_prev7d, bp.volume_prev7d
    FROM beezie_7d b7 CROSS JOIN beezie_prev7d bp
    UNION ALL
    SELECT 'Courtyard', c7.trades_7d, c7.volume_7d, cp.trades_prev7d, cp.volume_prev7d
    FROM courtyard_7d c7 CROSS JOIN courtyard_prev7d cp
    UNION ALL
    SELECT 'Collector Crypt', cc7.trades_7d, cc7.volume_7d, ccp.trades_prev7d, ccp.volume_prev7d
    FROM cc_7d cc7 CROSS JOIN cc_prev7d ccp
    UNION ALL
    SELECT 'Upshot', u7.trades_7d, u7.volume_7d, up.trades_prev7d, up.volume_prev7d
    FROM upshot_7d u7 CROSS JOIN upshot_prev7d up
)

SELECT
    c.project AS "Project",
    c.chain AS "Chain",
    c.trades_30d AS "Trades (30d)",
    c.buyers_30d AS "Users (30d)",
    c.volume_30d AS "Volume USD (30d)",
    w.trades_7d AS "Trades (7d)",
    w.volume_7d AS "Volume USD (7d)",
    CASE
        WHEN w.trades_prev7d > 0
        THEN ROUND(100.0 * (w.trades_7d - w.trades_prev7d) / w.trades_prev7d, 1)
        ELSE NULL
    END AS "WoW Trades %",
    CASE
        WHEN COALESCE(w.volume_prev7d, 0) > 0
        THEN ROUND(100.0 * (w.volume_7d - w.volume_prev7d) / NULLIF(w.volume_prev7d, 0), 1)
        ELSE NULL
    END AS "WoW Volume %",
    ROUND(c.volume_30d / NULLIF(c.buyers_30d, 0), 2) AS "Avg Volume/User"
FROM combined c
LEFT JOIN weekly w ON c.project = w.project
ORDER BY c.volume_30d DESC
```

### Визуализация

**Таблица** — 12 колонок, все строки видны. Настройки:
- Title: `Cards Projects — Head-to-Head Comparison`
- Column formatting: Volume columns with `$` prefix, `%` columns with conditional coloring (green > 0, red < 0)
- Sort by: Volume USD (30d) desc

---

## QUERY C.3: Cards Weekly Activity — Time Series

### Что он делает
Еженедельные объёмы по каждому проекту — stacked bar chart. Показывает общий тренд рынка карточек.

### Название при сохранении
`Cards Weekly Activity — Time Series (V1)`

### SQL-код

```sql
-- Section 6: Cards Weekly Activity — stacked by project
-- Shows weekly volume trend across all card platforms

WITH beezie_weekly AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        'Beezie' AS project,
        COUNT(*) AS trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        COUNT(DISTINCT buyer) AS unique_users
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= TIMESTAMP '2026-01-01'
    GROUP BY 1
),

courtyard_weekly AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        'Courtyard' AS project,
        COUNT(*) AS trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        COUNT(DISTINCT buyer) AS unique_users
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= TIMESTAMP '2025-01-01'
    GROUP BY 1
),

cc_weekly AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        'Collector Crypt' AS project,
        COUNT(*) AS trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        COUNT(DISTINCT trader_id) AS unique_users
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= TIMESTAMP '2025-08-01'
    GROUP BY 1
),

upshot_weekly AS (
    SELECT
        DATE_TRUNC('week', evt_block_time) AS week,
        'Upshot' AS project,
        COUNT(DISTINCT evt_tx_hash) AS trades,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS volume_usd,
        COUNT(DISTINCT "from") AS unique_users
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      AND evt_block_time >= TIMESTAMP '2026-02-01'
    GROUP BY 1
),

combined AS (
    SELECT * FROM beezie_weekly
    UNION ALL
    SELECT * FROM courtyard_weekly
    UNION ALL
    SELECT * FROM cc_weekly
    UNION ALL
    SELECT * FROM upshot_weekly
)

SELECT
    week AS "Week",
    project AS "Project",
    trades AS "Trades",
    volume_usd AS "Volume USD",
    unique_users AS "Unique Users",
    SUM(volume_usd) OVER (PARTITION BY project ORDER BY week) AS "Cumulative Volume USD"
FROM combined
WHERE week < DATE_TRUNC('week', now())
ORDER BY week, project
```

### Визуализация

**Chart C.3a: Stacked Bar — Weekly Volume by Project (12 колонок)**
- Chart type: Bar (stacked)
- X axis: `Week`
- Y axis: `Volume USD`
- Group by: `Project`
- Colors: Beezie=#14B8A6, Courtyard=#6366F1, Collector Crypt=#FB923C, Upshot=#F472B6
- Title: `Cards Market — Weekly Volume by Project (USD)`

**Chart C.3b: Line — Cumulative Volume (6 колонок)**
- Chart type: Line
- X axis: `Week`
- Y axis: `Cumulative Volume USD`
- Group by: `Project`
- Title: `Cumulative Trading Volume (USD)`

**Chart C.3c: Area — Weekly Users (6 колонок)**
- Chart type: Area (stacked)
- X axis: `Week`
- Y axis: `Unique Users`
- Group by: `Project`
- Title: `Weekly Active Users by Project`

---

## QUERY C.4: Beezie — NFT Activity & Volume (Base)

### Что он делает
Глубокий анализ Beezie на Base: NFT минты/переводы/бёрны + торговый объём с вторичного рынка.

### Название при сохранении
`Beezie — NFT Activity & Volume (V1)`

### SQL-код

```sql
-- Section 6: Beezie Deep Dive — NFT Activity on Base
-- Tracks mints, burns, transfers + secondary market volume

-- ============================================================
-- NFT Transfer events (mints/burns/transfers)
-- ============================================================
WITH nft_events AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        tx_hash,
        CASE
            WHEN topic1 = 0x0000000000000000000000000000000000000000000000000000000000000000
            THEN 'mint'
            WHEN topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000
            THEN 'burn'
            ELSE 'transfer'
        END AS event_type,
        VARBINARY_SUBSTRING(topic1, 13, 20) AS from_addr,
        VARBINARY_SUBSTRING(topic2, 13, 20) AS to_addr
    FROM base.logs
    WHERE contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND block_time >= TIMESTAMP '2026-01-01'
),

weekly_events AS (
    SELECT
        week,
        COUNT(*) AS total_events,
        COUNT(CASE WHEN event_type = 'mint' THEN 1 END) AS mints,
        COUNT(CASE WHEN event_type = 'burn' THEN 1 END) AS burns,
        COUNT(CASE WHEN event_type = 'transfer' THEN 1 END) AS transfers,
        COUNT(DISTINCT to_addr) AS unique_receivers
    FROM nft_events
    GROUP BY 1
),

-- ============================================================
-- Secondary market volume from nft.trades
-- ============================================================
weekly_trades AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        COUNT(*) AS secondary_trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS secondary_volume_usd,
        COUNT(DISTINCT buyer) AS unique_buyers,
        COUNT(DISTINCT seller) AS unique_sellers,
        ROUND(AVG(COALESCE(amount_usd, 0)), 2) AS avg_trade_usd
    FROM nft.trades
    WHERE blockchain = 'base'
      AND nft_contract_address = 0xbb5ec6fd4b61723bd45c399840f1d868840ca16f
      AND block_time >= TIMESTAMP '2026-01-01'
    GROUP BY 1
)

SELECT
    COALESCE(e.week, t.week) AS "Week",
    COALESCE(e.mints, 0) AS "Mints",
    COALESCE(e.burns, 0) AS "Burns",
    COALESCE(e.transfers, 0) AS "Transfers",
    COALESCE(e.unique_receivers, 0) AS "Unique Receivers",
    COALESCE(t.secondary_trades, 0) AS "Secondary Trades",
    COALESCE(t.secondary_volume_usd, 0) AS "Secondary Volume USD",
    COALESCE(t.unique_buyers, 0) AS "Unique Buyers",
    COALESCE(t.unique_sellers, 0) AS "Unique Sellers",
    COALESCE(t.avg_trade_usd, 0) AS "Avg Trade USD",
    SUM(COALESCE(e.mints, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Mints",
    SUM(COALESCE(t.secondary_volume_usd, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Volume USD"
FROM weekly_events e
FULL OUTER JOIN weekly_trades t ON e.week = t.week
WHERE COALESCE(e.week, t.week) < DATE_TRUNC('week', now())
ORDER BY 1
```

### Визуализация

**Chart C.4a: Stacked Bar — Mints / Burns / Transfers (8 колонок)**
- Chart type: Bar (stacked)
- X axis: `Week`
- Y axis: `Mints`, `Burns`, `Transfers`
- Colors: Mints=#14B8A6, Burns=#EF4444, Transfers=#64748B
- Title: `Beezie — Weekly NFT Activity (Mints / Burns / Transfers)`

**Chart C.4b: Bar + Line — Volume & Avg Trade (4 колонки)**
- Bar: `Secondary Volume USD` (color: #F59E0B)
- Line: `Avg Trade USD` (color: #0EA5E9)
- Title: `Beezie — Secondary Market Volume`

---

## QUERY C.5: Courtyard — Market Activity (Polygon)

### Что он делает
Courtyard NFT вторичный рынок + минты/бёрны + рост холдеров. Объединяет ключевые метрики из 8 существующих queries Сергея.

### Название при сохранении
`Courtyard — Market Activity (V1)`

### SQL-код

```sql
-- Section 6: Courtyard — NFT Activity on Polygon
-- Tracks mints, burns, secondary trades, holder growth

-- ============================================================
-- NFT Transfer events (mints/burns/transfers)
-- ============================================================
WITH nft_events AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        tx_hash,
        CASE
            WHEN topic1 = 0x0000000000000000000000000000000000000000000000000000000000000000
            THEN 'mint'
            WHEN topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000
            THEN 'burn'
            ELSE 'transfer'
        END AS event_type,
        VARBINARY_SUBSTRING(topic2, 13, 20) AS to_addr
    FROM polygon.logs
    WHERE contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND block_time >= TIMESTAMP '2025-01-01'
),

weekly_events AS (
    SELECT
        week,
        COUNT(*) AS total_events,
        COUNT(CASE WHEN event_type = 'mint' THEN 1 END) AS mints,
        COUNT(CASE WHEN event_type = 'burn' THEN 1 END) AS burns,
        COUNT(CASE WHEN event_type = 'transfer' THEN 1 END) AS transfers,
        COUNT(DISTINCT to_addr) AS unique_receivers
    FROM nft_events
    GROUP BY 1
),

-- ============================================================
-- Secondary market from nft.trades (OpenSea + others)
-- ============================================================
weekly_trades AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        COUNT(*) AS secondary_trades,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS secondary_volume_usd,
        COUNT(DISTINCT buyer) AS unique_buyers,
        COUNT(DISTINCT seller) AS unique_sellers,
        ROUND(AVG(COALESCE(amount_usd, 0)), 2) AS avg_trade_usd
    FROM nft.trades
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND block_time >= TIMESTAMP '2025-01-01'
    GROUP BY 1
),

-- ============================================================
-- Holder growth (new holders per week)
-- ============================================================
first_receive AS (
    SELECT
        VARBINARY_SUBSTRING(topic2, 13, 20) AS holder,
        MIN(DATE_TRUNC('week', block_time)) AS first_week
    FROM polygon.logs
    WHERE contract_address = 0x251BE3A17Af4892035C37ebf5890F4a4D889dcAD
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND topic2 != 0x0000000000000000000000000000000000000000000000000000000000000000
    GROUP BY 1
),

new_holders AS (
    SELECT
        first_week AS week,
        COUNT(*) AS new_holders
    FROM first_receive
    GROUP BY 1
)

SELECT
    COALESCE(e.week, t.week) AS "Week",
    COALESCE(e.mints, 0) AS "Mints",
    COALESCE(e.burns, 0) AS "Burns",
    COALESCE(e.transfers, 0) AS "Transfers",
    COALESCE(t.secondary_trades, 0) AS "Secondary Trades",
    COALESCE(t.secondary_volume_usd, 0) AS "Secondary Volume USD",
    COALESCE(t.unique_buyers, 0) AS "Unique Buyers",
    COALESCE(t.avg_trade_usd, 0) AS "Avg Trade USD",
    COALESCE(h.new_holders, 0) AS "New Holders",
    SUM(COALESCE(h.new_holders, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Holders",
    SUM(COALESCE(t.secondary_volume_usd, 0)) OVER (ORDER BY COALESCE(e.week, t.week)) AS "Cumulative Volume USD"
FROM weekly_events e
FULL OUTER JOIN weekly_trades t ON e.week = t.week
LEFT JOIN new_holders h ON COALESCE(e.week, t.week) = h.week
WHERE COALESCE(e.week, t.week) < DATE_TRUNC('week', now())
ORDER BY 1
```

### Визуализация

**Chart C.5a: Stacked Bar — Mints / Burns / Transfers (8 колонок)**
- Chart type: Bar (stacked)
- X axis: `Week`
- Y axis: `Mints`, `Burns`, `Transfers`
- Colors: Mints=#6366F1, Burns=#EF4444, Transfers=#64748B
- Title: `Courtyard — Weekly NFT Activity`

**Chart C.5b: Line — Cumulative Holders + Volume (4 колонки)**
- Line 1: `Cumulative Holders` (left Y, color: #6366F1)
- Line 2: `Cumulative Volume USD` (right Y, color: #F59E0B)
- Title: `Courtyard — Growth Trajectory`

---

## QUERY C.6: Upshot — Deposits & Withdrawals (Base)

### Что он делает
Анализ депозитов и выводов на Upshot. Основан на запросе Hempanda #7425705, доработан для Cards Dashboard.

### Название при сохранении
`Upshot — Deposits & Withdrawals (V1)`

### SQL-код

```sql
-- Section 6: Upshot — USDC Deposits & Withdrawals on Base
-- Contract: 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
-- Based on Hempanda query #7425705
-- Excludes technical internal address movements

WITH upshot_flows AS (
    SELECT
        DATE_TRUNC('week', evt_block_time) AS week,
        evt_tx_hash AS tx_hash,
        "from" AS sender,
        "to" AS receiver,
        CAST(value AS DOUBLE) / 1e6 AS usdc_amount,
        CASE
            WHEN "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b THEN 'deposit'
            WHEN "from" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b THEN 'withdrawal'
        END AS flow_type
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND (
          "from" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
          OR "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      )
      AND evt_block_time >= TIMESTAMP '2026-02-01'
),

weekly_flows AS (
    SELECT
        week,
        COUNT(DISTINCT tx_hash) AS total_txs,
        COUNT(DISTINCT CASE WHEN flow_type = 'deposit' THEN sender END) AS depositors,
        COUNT(DISTINCT CASE WHEN flow_type = 'withdrawal' THEN receiver END) AS withdrawers,
        ROUND(SUM(CASE WHEN flow_type = 'deposit' THEN usdc_amount ELSE 0 END), 2) AS deposits_usd,
        ROUND(SUM(CASE WHEN flow_type = 'withdrawal' THEN usdc_amount ELSE 0 END), 2) AS withdrawals_usd,
        ROUND(
            SUM(CASE WHEN flow_type = 'deposit' THEN usdc_amount ELSE 0 END)
          - SUM(CASE WHEN flow_type = 'withdrawal' THEN usdc_amount ELSE 0 END),
        2) AS net_flow_usd
    FROM upshot_flows
    GROUP BY 1
)

SELECT
    week AS "Week",
    total_txs AS "Total Txs",
    depositors AS "Unique Depositors",
    withdrawers AS "Unique Withdrawers",
    deposits_usd AS "Deposits USD",
    withdrawals_usd AS "Withdrawals USD",
    net_flow_usd AS "Net Flow USD",
    SUM(deposits_usd) OVER (ORDER BY week) AS "Cumulative Deposits USD",
    SUM(withdrawals_usd) OVER (ORDER BY week) AS "Cumulative Withdrawals USD",
    SUM(net_flow_usd) OVER (ORDER BY week) AS "TVL Proxy USD"
FROM weekly_flows
WHERE week < DATE_TRUNC('week', now())
ORDER BY 1
```

### Визуализация

**Chart C.6a: Bar — Deposits vs Withdrawals (8 колонок)**
- Chart type: Bar (grouped)
- X axis: `Week`
- Y axis: `Deposits USD` (color: #10B981), `Withdrawals USD` (color: #EF4444)
- Title: `Upshot — Weekly Deposits vs Withdrawals`

**Chart C.6b: Line — TVL Proxy (4 колонки)**
- Line: `TVL Proxy USD` (color: #F472B6)
- Title: `Upshot — Cumulative Net Balance (TVL Proxy)`

---

## QUERY C.7: Collector Crypt — Token Trading (Solana)

### Что он делает
CARDS token DEX trading на Solana — объём, трейдеры, динамика.

### Название при сохранении
`Collector Crypt — CARDS Token Trading (V1)`

### SQL-код

```sql
-- Section 6: Collector Crypt — CARDS token trading on Solana
-- Token: CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp
-- Source: dex_solana.trades (NOT dex.trades with blockchain filter)

WITH weekly_trading AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        COUNT(*) AS trades,
        COUNT(DISTINCT trader_id) AS unique_traders,
        ROUND(SUM(COALESCE(amount_usd, 0)), 2) AS volume_usd,
        ROUND(AVG(COALESCE(amount_usd, 0)), 2) AS avg_trade_usd,
        COUNT(CASE WHEN token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp' THEN 1 END) AS buys,
        COUNT(CASE WHEN token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp' THEN 1 END) AS sells
    FROM dex_solana.trades
    WHERE (
        token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
        OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
    )
      AND block_time >= TIMESTAMP '2025-08-01'
    GROUP BY 1
)

SELECT
    week AS "Week",
    trades AS "Total Trades",
    unique_traders AS "Unique Traders",
    volume_usd AS "Volume USD",
    avg_trade_usd AS "Avg Trade USD",
    buys AS "Buys",
    sells AS "Sells",
    ROUND(CAST(buys AS DOUBLE) / NULLIF(sells, 0), 2) AS "Buy/Sell Ratio",
    SUM(volume_usd) OVER (ORDER BY week) AS "Cumulative Volume USD",
    SUM(trades) OVER (ORDER BY week) AS "Cumulative Trades"
FROM weekly_trading
WHERE week < DATE_TRUNC('week', now())
ORDER BY 1
```

### Визуализация

**Chart C.7a: Bar + Line — Volume & Traders (8 колонок)**
- Bar: `Volume USD` (color: #FB923C)
- Line: `Unique Traders` (right Y, color: #0EA5E9)
- Title: `Collector Crypt — Weekly CARDS Trading Volume & Traders`

**Chart C.7b: Stacked Bar — Buys vs Sells (4 колонки)**
- Chart type: Bar (stacked)
- X axis: `Week`
- Y axis: `Buys` (color: #10B981), `Sells` (color: #EF4444)
- Title: `CARDS — Buy vs Sell Pressure`

---

## ОПИСАНИЯ ИНДИКАТОРОВ

### Per-Project Cards (Text Widgets)

Между query результатами можно вставить мини-описания проектов как text widget (4 колонки каждый):

**Beezie Card (4 колонки):**
```markdown
### Beezie
**Chain:** Base | **Type:** Claw + NFT Marketplace
**Contract:** `0xbb5ec6...ca16f`

Physical trading cards tokenized as ERC-721 NFTs. Claw machine mechanic for opening packs. Migrated from Flow to Base in Jan 2026. $28M+ claw volume in first 5 weeks.

[Website](https://beezie.io) | [BaseScan](https://basescan.org/token/0xbb5ec6fd4b61723bd45c399840f1d868840ca16f)
```

**Courtyard Card (4 колонки):**
```markdown
### Courtyard
**Chain:** Polygon | **Type:** Vault & Tokenize
**Contract:** `0x251BE3...dcAD`

Pioneer of tokenized trading cards. Cards stored by Brink's vault. NFTs tradeable on-chain with optional physical redemption. Largest RWA cards platform by volume.

[Website](https://courtyard.io) | [PolygonScan](https://polygonscan.com/address/0x251be3a17af4892035c37ebf5890f4a4d889dcad)
```

**Collector Crypt Card (4 колонки):**
```markdown
### Collector Crypt
**Chain:** Solana | **Type:** Gacha + Token
**Token:** `CARDScc...Yjp`

Tokenized graded Pokémon cards. Gacha pack mechanics with buyback guarantees. CARDS token powers marketplace fees and governance. $27M mcap.

[Website](https://collectorcrypt.com) | [Solscan](https://solscan.io/token/CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp)
```

**Upshot Card (4 колонки, нижний ряд):**
```markdown
### Upshot
**Chain:** Base | **Type:** Prediction Cards
**Contract:** `0x939dbb...3b`

Prediction-card platform: buy mystery packs, reveal cards tied to real-world events, win cash prizes. Runs on Base with USDC deposits. 700+ unique depositors.

[Website](https://upshot.xyz) | [BaseScan](https://basescan.org/address/0x939dbbcf075de12d9d8df08ef727591ddebbc13b)
```

**Phygitals Card (4 колонки, нижний ряд):**
```markdown
### Phygitals
**Chain:** Solana | **Type:** cNFT Vault
**Status:** V2 (limited on-chain data)

Compressed NFTs on Solana via Metaplex Bubblegum. Physical cards stored in PSA/Fanatics vaults. On-chain tracking limited due to cNFT architecture — full integration planned for V2.

[Website](https://phygitals.com) | [Docs](https://docs.phygitals.com)
```

---

## ВИЗУАЛИЗАЦИИ И ОФОРМЛЕНИЕ

### Общие правила

1. **Counters** — всегда с подписями и юнитами (`$`, `%`, `#`)
2. **Bar charts** — stacked для сравнения проектов, grouped для deposits/withdrawals
3. **Line charts** — для cumulative и trend данных
4. **Tables** — для leaderboard с conditional formatting
5. **Pie charts** — для market share breakdown

### Условные обозначения

| Индикатор | Значение |
|-----------|----------|
| WoW Growth > 0 | Зелёный текст / стрелка вверх |
| WoW Growth < 0 | Красный текст / стрелка вниз |
| Volume bars | Всегда с `$` prefix |
| Cumulative lines | Дашированная линия (dashed) |

---

## КАРТА LAYOUT

```
=====================================================================
  SECTION 6: CARDS DASHBOARD
=====================================================================

РЯД C-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — 12 колонок]
          "Cards Dashboard: Tokenized Collectibles Market"

РЯД C-2: [6 КАУНТЕРОВ из Query C.1]
          | Total Trades | Unique Users | Total Volume USD |
          | This Week Volume | WoW Trades % | WoW Volume % |

РЯД C-3: [4 PROJECT CARDS — по 3 колонки каждый]
          | Beezie | Courtyard | Collector Crypt | Upshot |

РЯД C-4: [PHYGITALS CARD — 3 колонки] [ПУСТОЕ — 9 колонок]
          | Phygitals (V2) |

РЯД C-5: [ТАБЛИЦА C.2 — 12 колонок]
          Cards Projects Leaderboard (Head-to-Head)

РЯД C-6: [ГРАФИК C.3a — 12 колонок]
          Weekly Volume by Project (stacked bar)

РЯД C-7: [ГРАФИК C.3b — 6 кол.]  [ГРАФИК C.3c — 6 кол.]
          Cumulative Volume (line)    Weekly Users (area)

РЯД C-8: [ТЕКСТ "Beezie" — 12 колонок]
          ─── Beezie Deep Dive ───

РЯД C-9: [ГРАФИК C.4a — 8 кол.]   [ГРАФИК C.4b — 4 кол.]
          NFT Activity (stacked)       Volume & Avg Trade

РЯД C-10: [ТЕКСТ "Courtyard" — 12 колонок]
           ─── Courtyard Deep Dive ───

РЯД C-11: [ГРАФИК C.5a — 8 кол.]   [ГРАФИК C.5b — 4 кол.]
           NFT Activity (stacked)       Growth (holders+vol)

РЯД C-12: [ТЕКСТ "Upshot" — 12 колонок]
           ─── Upshot Deep Dive ───

РЯД C-13: [ГРАФИК C.6a — 8 кол.]   [ГРАФИК C.6b — 4 кол.]
           Deposits vs Withdrawals      TVL Proxy

РЯД C-14: [ТЕКСТ "Collector Crypt" — 12 колонок]
           ─── Collector Crypt Deep Dive ───

РЯД C-15: [ГРАФИК C.7a — 8 кол.]   [ГРАФИК C.7b — 4 кол.]
           Volume & Traders              Buy vs Sell
```

---

## ЦВЕТОВАЯ ПАЛИТРА

### Cards-specific colors (не пересекаются с основным дашбордом)

| Element | Color | HEX |
|---------|-------|-----|
| **Cards Section / Header** | Fuchsia | `#D946EF` |
| **Beezie** | Teal | `#14B8A6` |
| **Courtyard** | Indigo | `#6366F1` |
| **Collector Crypt** | Light Orange | `#FB923C` |
| **Upshot** | Rose | `#F472B6` |
| **Phygitals** | Light Violet | `#A78BFA` |
| **Combined Trend Line** | Sky Blue | `#0EA5E9` |
| **Mints** | (per-project color) | — |
| **Burns** | Red | `#EF4444` |
| **Transfers / Neutral** | Slate | `#64748B` |
| **Volume / Money** | Amber | `#F59E0B` |
| **Growth / Positive** | Green | `#10B981` |
| **Decline / Negative** | Red | `#EF4444` |
| **Cumulative Lines** | Dark variant of project color | — |
| **Buys** | Emerald | `#22C55E` |
| **Sells** | Red | `#EF4444` |

---

## ПОРЯДОК ДЕЙСТВИЙ НА DUNE — ЧЕКЛИСТ

### Шаг 1: Создание запросов

- [ ] Создать Query C.1 → Сохранить как `Cards Ecosystem Pulse — Combined KPIs (V1)`
- [ ] Создать Query C.2 → Сохранить как `Cards Projects Leaderboard (V1)`
- [ ] Создать Query C.3 → Сохранить как `Cards Weekly Activity — Time Series (V1)`
- [ ] Создать Query C.4 → Сохранить как `Beezie — NFT Activity & Volume (V1)`
- [ ] Создать Query C.5 → Сохранить как `Courtyard — Market Activity (V1)`
- [ ] Создать Query C.6 → Сохранить как `Upshot — Deposits & Withdrawals (V1)`
- [ ] Создать Query C.7 → Сохранить как `Collector Crypt — CARDS Token Trading (V1)`

### Шаг 2: Визуализации

Для каждого query создать визуализации по описанию выше:
- [ ] C.1: 6 каунтеров
- [ ] C.2: 1 таблица (leaderboard)
- [ ] C.3: 3 чарта (stacked bar + cumulative line + area)
- [ ] C.4: 2 чарта (stacked bar + bar+line)
- [ ] C.5: 2 чарта (stacked bar + line)
- [ ] C.6: 2 чарта (grouped bar + line)
- [ ] C.7: 2 чарта (bar+line + stacked bar)

### Шаг 3: Dashboard Layout

- [ ] Добавить text widget Section Header (РЯД C-1)
- [ ] Добавить 6 каунтеров (РЯД C-2)
- [ ] Добавить 5 project cards как text widgets (РЯД C-3, C-4)
- [ ] Добавить таблицу leaderboard (РЯД C-5)
- [ ] Добавить stacked bar weekly volume (РЯД C-6)
- [ ] Добавить cumulative + users charts (РЯД C-7)
- [ ] Добавить Beezie deep dive (РЯД C-8, C-9)
- [ ] Добавить Courtyard deep dive (РЯД C-10, C-11)
- [ ] Добавить Upshot deep dive (РЯД C-12, C-13)
- [ ] Добавить Collector Crypt deep dive (РЯД C-14, C-15)

### Шаг 4: Проверка

- [ ] Все запросы выполняются без ошибок
- [ ] Визуализации отображают данные корректно
- [ ] Цвета соответствуют палитре
- [ ] Layout соответствует карте
- [ ] Text widgets отформатированы корректно
- [ ] Кросс-чейн данные (Base + Polygon + Solana) отображаются в одном месте

### Шаг 5: V2 планы

- [ ] Добавить Phygitals (когда Dune поддержит cNFT данные)
- [ ] Добавить Courtyard internal marketplace volume (p2p)
- [ ] Добавить Courtyard royalty revenue
- [ ] Добавить Beezie claw volume (primary market)
- [ ] Добавить cross-project correlation analysis
- [ ] Добавить Renaiss (BNB), Monster (megaETH) в V2

---

## ССЫЛКИ НА СУЩЕСТВУЮЩИЕ QUERIES КОМАНДЫ

| Query | Author | URL | Статус |
|-------|--------|-----|--------|
| Courtyard Overall KPIs | Сергей RUA | https://dune.com/queries/7426512 | Готов |
| Courtyard Weekly Activity | Сергей RUA | https://dune.com/queries/7426534 | Готов |
| Courtyard External Volume | Сергей RUA | https://dune.com/queries/7426587 | Готов |
| Courtyard Holder Growth | Сергей RUA | https://dune.com/queries/7426635 | Готов |
| Courtyard Top 20 Holders | Сергей RUA | https://dune.com/queries/7426680 | Готов |
| Courtyard Daily Active | Сергей RUA | https://dune.com/queries/7426737 | Готов |
| Courtyard Marketplace Vol | Сергей RUA | https://dune.com/queries/7426759 | Готов |
| Courtyard Royalty Revenue | Сергей RUA | https://dune.com/queries/7426783 | Готов |
| Upshot Deposits/Withdrawals | Hempanda | https://dune.com/queries/7425705 | Готов |

> **Важно:** Queries от Сергея и Hempanda можно использовать параллельно с нашими собственными. Наши queries оптимизированы для единого Cards Dashboard с кросс-чейн сравнением.
