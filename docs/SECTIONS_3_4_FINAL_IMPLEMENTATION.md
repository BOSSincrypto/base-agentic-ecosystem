# РАЗДЕЛЫ 3 & 4: Финальная Реализация — Код + Инструкции

> **Дашборд:** `Base Agentic: The Birth of AI Economy`
> **URL:** https://dune.com/ax1research/base-agentic-ecosystem
> **Разделы:** Section 3 (Base Agentic Gaming) + Section 4 (OWB / Clash of Coins — Compact)
> **Дата:** Апрель 2026

---

## СОДЕРЖАНИЕ

1. [Общий план](#общий-план)
2. [Section 3: Base Agentic Gaming](#section-3-base-agentic-gaming)
   - Text Widget S3
   - Query 3.1 — Ecosystem Pulse
   - Query 3.2 — Projects Comparison
   - Визуализации и оформление
3. [Section 4: OWB / Clash of Coins — Compact](#section-4-owb--clash-of-coins--compact)
   - Text Widget S4
   - Query 4.1 — Key Metrics (Compact)
   - Query 4.2 — Bot Activity Distribution
   - Визуализации и оформление
4. [Обновление Table of Contents](#обновление-table-of-contents)
5. [Обновление Methodology (Footer)](#обновление-methodology-footer)
6. [Порядок действий на Dune — Чеклист](#порядок-действий-на-dune--чеклист)

---

## ОБЩИЙ ПЛАН

### Что добавляем

| Section | Queries | Widgets | Rows |
|---------|---------|---------|------|
| **3) Base Agentic Gaming** | 2 queries | 1 text + 5 counters + 3 charts + 1 table + 1 bar + 1 pie = **12** | 6 рядов |
| **4) OWB Compact** | 2 queries | 1 text + 5 counters + 1 chart = **7** | 3 ряда |
| **Total** | **4 queries** | **19 widgets** | **9 рядов** |

### Где располагаются

Оба раздела добавляются **ПОСЛЕ** существующих секций (после Base vs Solana), **ПЕРЕД** Methodology footer.

Текущий порядок на дашборде:
1. Ecosystem Pulse (KPIs)
2. Cross-Pollination Index
3. Daily Activity
4. Leaderboard
5. ERC-8004 Registry
6. Virtuals Protocol
7. Base vs Solana
8. **→ Section 3: Base Agentic Gaming** ← НОВОЕ
9. **→ Section 4: OWB Compact** ← НОВОЕ
10. Methodology (footer)

---

## ЦВЕТОВАЯ ПАЛИТРА

| Element | Color | HEX |
|---------|-------|-----|
| Agentic Gaming | Pink/Magenta | `#EC4899` |
| OWB Brand | Orange | `#F97316` |
| Bot/Agent Metrics | Cyan | `#06B6D4` |
| Revenue/MRR | Emerald | `#22C55E` |
| Growth/Positive | Green | `#10B981` |
| Decline/Negative | Red | `#EF4444` |
| Volume/Money | Amber | `#F59E0B` |
| Secondary Lines | Slate | `#64748B` |
| Cumulative Lines | Dark Pink | `#BE185D` |

---

## КАРТА LAYOUT (НОВЫЕ СЕКЦИИ)

```
=====================================================================
  SECTION 3: BASE AGENTIC GAMING
=====================================================================

РЯД S3-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — 12 колонок]
          "Base Agentic Gaming: Where AI Agents Become Players"

РЯД S3-2: [5 КАУНТЕРОВ из Query 3.1]
          | Total Gaming Txs | Unique Players | Active Projects |
          | This Week Txs | WoW Growth % |

РЯД S3-3: [ГРАФИК 3.1a — 12 колонок]
          Daily Agentic Gaming Transactions (bars + 7d MA line)

РЯД S3-4: [ГРАФИК 3.1b — 6 кол.]  [ГРАФИК 3.1c — 6 кол.]
          Daily Unique Players (area)    Cumulative Gaming Txs (line)

РЯД S3-5: [ТАБЛИЦА 3.2 — 12 колонок]
          Agentic Gaming Projects Comparison

РЯД S3-6: [ГРАФИК 3.2a — 8 кол.]  [ГРАФИК 3.2b — 4 кол.]
          Gaming Txs by Project (bar)    Agentic Gaming Tx Share (pie)

=====================================================================
  SECTION 4: CLASH OF COINS (OWB) — COMPACT
=====================================================================

РЯД S4-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — 12 колонок]
          "Clash of Coins (OWB): Agentic Economy Snapshot"

РЯД S4-2: [5 КАУНТЕРОВ из Query 4.1]
          | MRR Proxy (USD) | Total Bots | Monthly Active Bots |
          | Total Txs (30d) | WoW Growth % |

РЯД S4-3: [ГРАФИК 4.2 — 12 колонок]
          Bot Activity Distribution (horizontal bar)
```

---

---

# SECTION 3: BASE AGENTIC GAMING

---

## Text Widget S3: Section Header (РЯД S3-1)

**Как добавить:** Edit dashboard → Add text widget → вставить текст → растянуть на 12 колонок.

**Текст (скопируй как есть):**

```markdown
---

## Base Agentic Gaming: Where AI Agents Become Players

A new category is emerging on Base: games built **for** AI agents, not just humans. These are arenas where autonomous agents compete, survive, and earn — using real tokens and verifiable on-chain logic.

**What we track:**
- **Survival games** — agents pay to stay alive, dead agents fund the living (Last AI Standing)
- **Battle arenas** — agents fight in on-chain competitions for ETH prizes (Agent Royale)
- **Agentic tournaments** — the first $1M AI agent tournament on Base (Clash of Coins)
- **Agent-gated experiences** — NFTs and assets only AI agents can mint or earn

This is the **GameAI era** — where the game itself becomes a proving ground for machine intelligence. Projects here are in early/launch stage. The moment new agentic gaming contracts deploy on Base, they will appear in this section.

> "GameFi was mechanics. GameAI is intelligence." — OWB Studio Manifesto
```

---

## QUERY 3.1: Base Agentic Gaming — Ecosystem Pulse & Daily Activity

### Что он делает
Отслеживает совокупную активность всех agentic gaming проектов на Base: транзакции, уникальные игроки, ежедневная динамика с 7-дневными скользящими средними, кумулятивный рост. Показывает KPI-каунтеры + три графика.

### На какие вопросы отвечает
- Сколько всего транзакций и игроков в agentic gaming на Base?
- Какой тренд — растёт или стагнирует?
- Какой проект генерирует больше всего активности?
- Какова недельная динамика (WoW)?

### Название запроса при сохранении
`Base Agentic Gaming - Ecosystem Pulse`

### SQL-код

```sql
-- Base Agentic Gaming: Ecosystem Pulse & Daily Activity
-- Tracks all known agentic gaming contracts on Base
-- Uses base.transactions for tx counts + unique addresses

WITH gaming_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0x88beBFeA498619D4eA891E707c47C43E2D43E62d, 'Last AI Standing'),
        (0xF5178A7562B580309F48a4dc8aCDDAf15587eb07, 'Agent Royale'),
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'Clash of Coins (OWB)'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'CoC Rewards Claim')
    ) AS t(address, name)
),

-- Daily raw metrics per project
daily_raw AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        gc.name AS project,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT t."from") AS daily_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1, 2
),

-- All-time totals
all_time AS (
    SELECT
        SUM(daily_txs) AS total_txs,
        SUM(daily_players) AS total_players_raw
    FROM daily_raw
),

-- Unique players (deduplicated across projects)
unique_players_total AS (
    SELECT COUNT(DISTINCT t."from") AS unique_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
),

-- Active projects count
active_projects AS (
    SELECT COUNT(DISTINCT gc.name) AS active_count
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= NOW() - INTERVAL '30' day
      AND t.success = true
),

-- Current 7 days
current_week AS (
    SELECT
        COUNT(*) AS week_txs,
        COUNT(DISTINCT t."from") AS week_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= NOW() - INTERVAL '7' day
      AND t.success = true
),

-- Previous 7 days
prev_week AS (
    SELECT
        COUNT(*) AS prev_txs,
        COUNT(DISTINCT t."from") AS prev_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= NOW() - INTERVAL '14' day
      AND t.block_time < NOW() - INTERVAL '7' day
      AND t.success = true
),

-- Date spine for continuous chart
date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2026-01-01', CURRENT_DATE, INTERVAL '1' day)) AS t(day)
),

-- Daily filled (with zeros for missing days)
daily_agg AS (
    SELECT
        ds.day,
        COALESCE(SUM(dr.daily_txs), 0) AS daily_txs,
        COALESCE(SUM(dr.daily_players), 0) AS daily_players
    FROM date_spine ds
    LEFT JOIN daily_raw dr ON ds.day = dr.day
    GROUP BY 1
),

-- With moving averages
with_ma AS (
    SELECT
        day,
        daily_txs,
        daily_players,
        ROUND(AVG(daily_txs) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS txs_7d_ma,
        ROUND(AVG(daily_players) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS players_7d_ma,
        SUM(daily_txs) OVER (ORDER BY day) AS cumulative_txs,
        SUM(daily_players) OVER (ORDER BY day) AS cumulative_players
    FROM daily_agg
)

SELECT
    wm.day,
    wm.daily_txs AS "Daily Gaming Txs",
    wm.daily_players AS "Daily Unique Players",
    wm.txs_7d_ma AS "Txs 7d MA",
    wm.players_7d_ma AS "Players 7d MA",
    wm.cumulative_txs AS "Cumulative Gaming Txs",
    wm.cumulative_players AS "Cumulative Players",
    -- KPI values (same on every row, for counter widgets)
    at.total_txs AS "Total Gaming Txs",
    up.unique_players AS "Unique Players All-Time",
    ap.active_count AS "Active Projects (30d)",
    cw.week_txs AS "This Week Txs",
    CASE
        WHEN pw.prev_txs > 0
        THEN ROUND(100.0 * (cw.week_txs - pw.prev_txs) / pw.prev_txs, 1)
        ELSE 0
    END AS "WoW Growth %"
FROM with_ma wm
CROSS JOIN all_time at
CROSS JOIN unique_players_total up
CROSS JOIN active_projects ap
CROSS JOIN current_week cw
CROSS JOIN prev_week pw
WHERE wm.day < CURRENT_DATE
  AND wm.day >= DATE '2026-01-01'
ORDER BY wm.day ASC
```

### Визуализации из Query 3.1

#### 5 Каунтеров (РЯД S3-2)

Из этого запроса создаём **5 Counter-визуализаций**. Используем последнюю строку результата.

| # | Заголовок | Колонка | Цвет | Ширина |
|---|-----------|---------|------|--------|
| 1 | **Total Agentic Gaming Txs** | `Total Gaming Txs` | Pink `#EC4899` | 2-3 колонки |
| 2 | **Unique Players** | `Unique Players All-Time` | Cyan `#06B6D4` | 2-3 колонки |
| 3 | **Active Projects (30d)** | `Active Projects (30d)` | Emerald `#10B981` | 2-3 колонки |
| 4 | **This Week Txs** | `This Week Txs` | Pink `#EC4899` | 2-3 колонки |
| 5 | **WoW Growth** | `WoW Growth %` | Green `#10B981` (>0) / Red `#EF4444` (<0) | 2-3 колонки |

**Как создать каждый каунтер:**
1. Открой запрос → Run
2. Нажми **New visualization** → **Counter**
3. В поле **Column** выбери нужную колонку
4. В **Title** впиши название
5. Для WoW Growth поставь **Suffix** = `%`
6. Повтори для каждого каунтера (5 раз из одного запроса)

#### График 3.1a: Daily Gaming Activity (РЯД S3-3 — 12 колонок)

1. Тип: **Bar Chart** с наложением Line
2. **X-axis:** `day`
3. **Y-axis (бары):** `Daily Gaming Txs` — Pink `#EC4899`
4. **Y-axis (линия):** `Txs 7d MA` — тёмно-розовый `#BE185D`, пунктирная
5. **Stacking:** OFF (одна серия)
6. **Ширина:** 12 колонок (полная ширина)
7. **Заголовок:** `Daily Agentic Gaming Transactions on Base`

#### График 3.1b: Daily Unique Players (РЯД S3-4, 6 колонок слева)

1. Тип: **Area Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Daily Unique Players` — Cyan `#06B6D4`
4. **Ширина:** 6 колонок
5. **Заголовок:** `Daily Unique Players`

#### График 3.1c: Cumulative Gaming Txs (РЯД S3-4, 6 колонок справа)

1. Тип: **Line Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Cumulative Gaming Txs` — Dark Pink `#BE185D`
4. **Ширина:** 6 колонок
5. **Заголовок:** `Cumulative Agentic Gaming Transactions`

---

## QUERY 3.2: Base Agentic Gaming — Projects Comparison

### Что он делает
Сравнительная таблица всех agentic gaming проектов на Base: транзакции за 30 дней, уникальные игроки, WoW-динамика, средний размер транзакции, доля от общей активности.

### На какие вопросы отвечает
- Какой agentic gaming проект самый активный?
- У кого больше уникальных игроков?
- Кто растёт быстрее?
- Какова доля каждого проекта в общей активности?

### Название запроса при сохранении
`Base Agentic Gaming - Projects Comparison`

### SQL-код

```sql
-- Base Agentic Gaming: Projects Comparison & Leaderboard
-- Compares all tracked agentic gaming projects on Base

WITH gaming_contracts AS (
    SELECT address, name, category FROM (
        VALUES
        (0x88beBFeA498619D4eA891E707c47C43E2D43E62d, 'Last AI Standing', 'Survival'),
        (0xF5178A7562B580309F48a4dc8aCDDAf15587eb07, 'Agent Royale', 'Battle Arena'),
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'Clash of Coins (OWB)', 'Tournament'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'CoC Rewards Claim', 'Rewards')
    ) AS t(address, name, category)
),

-- 30-day metrics per project
metrics_30d AS (
    SELECT
        gc.name AS project,
        gc.category,
        COUNT(*) AS txs_30d,
        COUNT(DISTINCT t."from") AS players_30d,
        ROUND(SUM(t.value / 1e18), 4) AS eth_volume_30d,
        ROUND(AVG(t.value / 1e18), 6) AS avg_tx_eth,
        MIN(t.block_time) AS first_seen,
        MAX(t.block_time) AS last_active
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= NOW() - INTERVAL '30' day
      AND t.success = true
    GROUP BY 1, 2
),

-- 7-day metrics
metrics_7d AS (
    SELECT
        gc.name AS project,
        COUNT(*) AS txs_7d,
        COUNT(DISTINCT t."from") AS players_7d
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= NOW() - INTERVAL '7' day
      AND t.success = true
    GROUP BY 1
),

-- Previous 7 days
metrics_prev_7d AS (
    SELECT
        gc.name AS project,
        COUNT(*) AS txs_prev_7d,
        COUNT(DISTINCT t."from") AS players_prev_7d
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= NOW() - INTERVAL '14' day
      AND t.block_time < NOW() - INTERVAL '7' day
      AND t.success = true
    GROUP BY 1
),

-- Total ecosystem txs for share calculation
total_ecosystem AS (
    SELECT SUM(txs_30d) AS total_txs FROM metrics_30d
),

-- Combine everything
combined AS (
    SELECT
        m.project,
        m.category,
        m.txs_30d,
        m.players_30d,
        m.eth_volume_30d,
        m.avg_tx_eth,
        COALESCE(m7.txs_7d, 0) AS txs_7d,
        COALESCE(m7.players_7d, 0) AS players_7d,
        CASE
            WHEN COALESCE(mp.txs_prev_7d, 0) > 0
            THEN ROUND(100.0 * (COALESCE(m7.txs_7d, 0) - mp.txs_prev_7d) / mp.txs_prev_7d, 1)
            ELSE NULL
        END AS wow_txs_pct,
        CASE
            WHEN COALESCE(mp.players_prev_7d, 0) > 0
            THEN ROUND(100.0 * (COALESCE(m7.players_7d, 0) - mp.players_prev_7d) / mp.players_prev_7d, 1)
            ELSE NULL
        END AS wow_players_pct,
        ROUND(100.0 * m.txs_30d / NULLIF(te.total_txs, 0), 1) AS ecosystem_share_pct,
        m.first_seen,
        m.last_active
    FROM metrics_30d m
    LEFT JOIN metrics_7d m7 ON m.project = m7.project
    LEFT JOIN metrics_prev_7d mp ON m.project = mp.project
    CROSS JOIN total_ecosystem te
)

SELECT
    ROW_NUMBER() OVER (ORDER BY txs_30d DESC) AS "#",
    project AS "Project",
    category AS "Type",
    txs_30d AS "Txs (30d)",
    players_30d AS "Players (30d)",
    eth_volume_30d AS "ETH Vol (30d)",
    txs_7d AS "Txs (7d)",
    players_7d AS "Players (7d)",
    wow_txs_pct AS "WoW Txs %",
    wow_players_pct AS "WoW Players %",
    ecosystem_share_pct AS "Ecosystem Share %",
    avg_tx_eth AS "Avg Tx (ETH)",
    first_seen AS "First Seen",
    last_active AS "Last Active"
FROM combined
ORDER BY txs_30d DESC
```

### Визуализации из Query 3.2

#### Таблица 3.2: Projects Comparison (РЯД S3-5 — 12 колонок)

1. Тип: **Table**
2. **Условное форматирование:**
   - `WoW Txs %`: зелёный если >0, красный если <0
   - `WoW Players %`: зелёный если >0, красный если <0
   - `Ecosystem Share %`: градиент от светлого к тёмному
3. Скрой колонки `First Seen`, `Last Active` (слишком детально для overview)
4. **Ширина:** 12 колонок
5. **Заголовок:** `Agentic Gaming Projects on Base — 30-Day Comparison`

#### График 3.2a: Transaction Breakdown by Project (РЯД S3-6, 8 колонок)

1. Тип: **Bar Chart** (горизонтальный)
2. **Y-axis:** `Project`
3. **X-axis:** `Txs (30d)` — Pink `#EC4899`
4. **Показать значения** на каждом баре
5. **Ширина:** 8 колонок
6. **Заголовок:** `Gaming Transactions by Project (30d)`

#### График 3.2b: Ecosystem Share Pie (РЯД S3-6, 4 колонки)

1. Тип: **Pie Chart**
2. **Labels:** `Project`
3. **Values:** `Txs (30d)`
4. **Цвета:**
   - Last AI Standing: `#EC4899`
   - Agent Royale: `#F97316`
   - Clash of Coins: `#06B6D4`
   - CoC Rewards: `#8B5CF6`
5. **Показать %** на каждом сегменте
6. **Ширина:** 4 колонки
7. **Заголовок:** `Agentic Gaming Tx Share`

---

---

# SECTION 4: OWB / CLASH OF COINS — COMPACT

> **Важно:** Используется компактная версия (2 queries, 7 widgets, 3 ряда).
> Это согласованное решение — вместо 19+ виджетов оставляем 7 ключевых.
> Полные запросы сохранены в репозитории и могут быть возвращены.

---

## Text Widget S4: Section Header (РЯД S4-1)

**Как добавить:** Edit dashboard → Add text widget → вставить текст → растянуть на 12 колонок.

**Текст (скопируй как есть):**

```markdown
---

## Clash of Coins (OWB): Agentic Economy Snapshot

**OWB** is the first large-scale GameAI project on Base — 30K+ DAU, $1M agentic tournament, Agentic-as-a-Service platform. Below: 5 key metrics + bot composition analysis.

Contracts: [OWB Token](https://basescan.org/address/0xEF5997c2cf2f6c138196f8a6203afc335206b3c1) · [ClaimRewards](https://basescan.org/address/0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40) · [Aerodrome Pool](https://basescan.org/address/0x995985c9027e8a90c823a5e0a9112fea72d1f4dd) · [NFT Sales](https://basescan.org/address/0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b)
```

---

## QUERY 4.1: Clash of Coins — Key Metrics (Compact)

### Что он делает
Один консолидированный запрос, который выдаёт все 5 KPI-каунтеров для Section 4. Объединяет MRR proxy, bot census и transaction telemetry в один результат.

### На какие вопросы отвечает
- Сколько OWB «зарабатывает» ежемесячно (MRR proxy)?
- Сколько ботов/агентов в экосистеме?
- Какова транзакционная активность за 30 дней?
- Растёт ли активность WoW?

### Название запроса при сохранении
`OWB Clash - Key Metrics (Compact)`

### SQL-код

```sql
-- OWB Clash of Coins: Consolidated Key Metrics (Compact Section 4)
-- Outputs 5 KPI values for counter widgets
-- MRR Proxy + Total Bots + Monthly Active Bots + Txs 30d + WoW Growth

-- NOTE: oCOIN removed per team feedback — unknown/unverified
WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40)
    ) AS t(address)
),

-- 1) MRR Proxy: DEX volume last full month
mrr_proxy AS (
    SELECT
        ROUND(SUM(amount_usd), 2) AS mrr_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= DATE_TRUNC('month', NOW()) - INTERVAL '1' month
      AND block_time < DATE_TRUNC('month', NOW())
      AND amount_usd > 0
),

-- 2) Total Bots All-Time: unique addresses interacting with OWB contracts
total_bots AS (
    SELECT COUNT(DISTINCT t."from") AS total_bots_alltime
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE '2026-01-01'
),

-- 3) Monthly Active Bots: unique addresses last 30d
monthly_active AS (
    SELECT COUNT(DISTINCT t."from") AS monthly_active_bots
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= NOW() - INTERVAL '30' day
),

-- 4) Total Txs 30d
txs_30d AS (
    SELECT COUNT(*) AS total_txs_30d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= NOW() - INTERVAL '30' day
),

-- 5) WoW Growth: current 7d vs previous 7d
wow_current AS (
    SELECT COUNT(*) AS txs_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= NOW() - INTERVAL '7' day
),
wow_prev AS (
    SELECT COUNT(*) AS txs_prev_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= NOW() - INTERVAL '14' day
      AND t.block_time < NOW() - INTERVAL '7' day
)

SELECT
    mrr.mrr_usd AS "MRR Proxy (USD)",
    tb.total_bots_alltime AS "Total Bots (All-Time)",
    ma.monthly_active_bots AS "Monthly Active Bots",
    t30.total_txs_30d AS "Total Txs (30d)",
    CASE
        WHEN wp.txs_prev_7d > 0
        THEN ROUND(100.0 * (wc.txs_7d - wp.txs_prev_7d) / wp.txs_prev_7d, 1)
        ELSE 0
    END AS "WoW Growth %"
FROM mrr_proxy mrr
CROSS JOIN total_bots tb
CROSS JOIN monthly_active ma
CROSS JOIN txs_30d t30
CROSS JOIN wow_current wc
CROSS JOIN wow_prev wp
```

### Визуализации: 5 Каунтеров (РЯД S4-2)

Из единственной строки результата создаём **5 Counter-визуализаций**:

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **MRR Proxy (USD)** | `MRR Proxy (USD)` | USD, 0 десятичных | Emerald `#22C55E` | 2-3 кол. |
| 2 | **Total Bots** | `Total Bots (All-Time)` | Number | Orange `#F97316` | 2-3 кол. |
| 3 | **Monthly Active Bots** | `Monthly Active Bots` | Number | Cyan `#06B6D4` | 2-3 кол. |
| 4 | **Total Txs (30d)** | `Total Txs (30d)` | Number | Pink `#EC4899` | 2-3 кол. |
| 5 | **WoW Growth** | `WoW Growth %` | Percentage (1 дес.) | Green `#10B981` (>0) / Red `#EF4444` (<0) | 2-3 кол. |

**Как создать каунтер в Dune:**
1. Открой запрос `OWB Clash - Key Metrics (Compact)` → Run
2. Нажми **New visualization** → выбери **Counter**
3. В поле **Column** выбери нужную колонку (напр. `MRR Proxy (USD)`)
4. В **Title** впиши название
5. В **Prefix** поставь `$` для USD-метрик
6. В **Suffix** поставь `%` для WoW Growth
7. Повтори для каждого каунтера (5 раз из одного запроса)

---

## QUERY 4.2: OWB — Bot Activity Distribution

### Что он делает
Распределение ботов по частоте активности за 30 дней. Показывает, кто «одноразовый», кто «казуальный», а кто «whale bot».

### На какие вопросы отвечает
- Какая доля ботов — одноразовые?
- Сколько power users и whale bots?
- Какой процент аудитории регулярно взаимодействует?

### Название запроса при сохранении
`OWB Clash - Bot Activity Distribution`

### SQL-код

```sql
-- OWB Clash of Coins: Bot Activity Distribution (30d Frequency Cohorts)
-- Who are the most active agents?

-- NOTE: oCOIN removed per team feedback — unknown/unverified
WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40)
    ) AS t(address)
),

bot_frequency AS (
    SELECT
        t."from" AS bot_address,
        COUNT(*) AS total_interactions
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= NOW() - INTERVAL '30' day
    GROUP BY 1
)

SELECT
    CASE
        WHEN total_interactions = 1 THEN '1 tx (one-time)'
        WHEN total_interactions BETWEEN 2 AND 5 THEN '2-5 txs (casual)'
        WHEN total_interactions BETWEEN 6 AND 20 THEN '6-20 txs (regular)'
        WHEN total_interactions BETWEEN 21 AND 100 THEN '21-100 txs (power user)'
        ELSE '100+ txs (whale bot)'
    END AS "Activity Cohort",
    CASE
        WHEN total_interactions = 1 THEN 1
        WHEN total_interactions BETWEEN 2 AND 5 THEN 2
        WHEN total_interactions BETWEEN 6 AND 20 THEN 3
        WHEN total_interactions BETWEEN 21 AND 100 THEN 4
        ELSE 5
    END AS sort_order,
    COUNT(*) AS "Number of Bots",
    SUM(total_interactions) AS "Total Interactions",
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS "% of All Bots",
    ROUND(AVG(CAST(total_interactions AS DOUBLE)), 1) AS "Avg Txs in Cohort"
FROM bot_frequency
GROUP BY 1, 2
ORDER BY sort_order
```

### Визуализация: Horizontal Bar Chart (РЯД S4-3 — 12 колонок)

1. Открой запрос → Run → **New visualization** → **Bar Chart**
2. **Orientation:** Horizontal
3. **Y-axis:** `Activity Cohort`
4. **X-axis:** `Number of Bots`
5. **Цвет баров:** Cyan `#06B6D4`
6. **Data Labels:** включи, чтобы показать `% of All Bots` рядом с каждым баром
7. **Ширина на дашборде:** 12 колонок (полная ширина)
8. **Заголовок:** `Bot Activity Distribution (30d) — Who Are The Most Active Agents?`
9. **Описание:** `How many times did each bot interact with OWB contracts in the last 30 days?`

---

---

# ОБНОВЛЕНИЕ TABLE OF CONTENTS

Обнови оглавление (text widget в самом верху дашборда), добавив 2 новые строки:

```markdown
| Section | What You'll Find |
|---------|-----------------|
| **Cross-Pollination Index** | Network effect: Power Users (3+ projects), Avg Projects per User, Single-Project % |
| **Ecosystem Pulse** | 6 KPIs: Total Txs, Unique Addresses, ERC-8004 Agents, Weekly dynamics, Infra vs Consumer |
| **Daily Activity** | Daily transaction trends across all tracked projects (area chart) |
| **Leaderboard** | Top projects ranked by Activity Score (55% Txs + 45% Users) with WoW momentum |
| **ERC-8004 Registry** | Agent identity registrations: daily growth, creator concentration, total agents |
| **Virtuals Protocol** | Deep dive: token economics, trading activity, agent token health |
| **Base vs Solana** | Head-to-head: DEX volume, traders, avg trade size, growth dynamics |
| **Base Agentic Gaming** | Emerging agentic gaming on Base: daily activity, players, project comparison |
| **OWB Agentic Gaming** | OWB deep dive: MRR proxy, bot census, activity distribution |
| **Methodology** | Definitions, inclusion criteria, Activity Score formula, known limitations |
```

---

# ОБНОВЛЕНИЕ METHODOLOGY (FOOTER)

Добавь в конец секции Methodology (перед финальной строкой `> This dashboard is a telemetry instrument...`) следующий текст:

```markdown
#### Section 3: Base Agentic Gaming

We track the emerging category of **games designed for AI agents** on Base. These are arenas where autonomous agents compete with real tokens and verifiable on-chain logic. The category is in early/launch stage — we include projects that have:

1. A deployed smart contract on Base with measurable gaming activity
2. Agent-first design (agents are the primary participants, not humans)
3. On-chain settlement (prizes, survival payments, or battle outcomes)

**Tracked projects:** Last AI Standing (USDC survival game), Agent Royale (ETH battle competition), Clash of Coins (first $1M agentic tournament).

#### Section 4: OWB Agentic Gaming (Compact)

OWB (Clash of Coins) metrics are tracked across two primary on-chain data sources:

| Data Source | What We Capture | Table |
|-------------|----------------|-------|
| Direct transactions to OWB contracts | Tx counts, addresses, bot frequency | `base.transactions` |
| DEX trading activity | Volume (USD) as MRR proxy | `dex.trades` |

**MRR Proxy:** Monthly Recurring Revenue is approximated as DEX trading volume for the last full calendar month. This is a proxy — actual subscription revenue may include off-chain components not captured on-chain.

**Bot Census:** Each unique wallet address that interacts with any OWB contract is counted as one "bot." This includes human wallets — we cannot distinguish between human users and AI agents on-chain. The term "bot" is used in the gaming context of OWB's agentic tournament design.

**Known limitations:**
- Off-chain game activity (gameplay sessions, AI inference, matchmaking) is not captured
- Subscription payments may occur off-chain
- "Bot" count includes human wallets — no on-chain distinction possible
- MRR proxy is a lower bound — actual revenue likely higher due to off-chain monetization
```

---

---

# ПОРЯДОК ДЕЙСТВИЙ НА DUNE — ЧЕКЛИСТ

## Шаг 1: Создать Query 3.1

1. На Dune нажми **New** → **Query**
2. Вставь SQL-код Query 3.1 (см. выше)
3. Нажми **Run** — проверь, что данные возвращаются
4. Сохрани с названием: `Base Agentic Gaming - Ecosystem Pulse`
5. Создай **5 Counter-визуализаций** (см. таблицу каунтеров выше):
   - New visualization → Counter → выбрать колонку → задать Title/Color
6. Создай **3 графика** (3.1a, 3.1b, 3.1c):
   - New visualization → Bar Chart (3.1a) / Area Chart (3.1b) / Line Chart (3.1c)
   - Настрой оси и цвета по инструкциям выше

## Шаг 2: Создать Query 3.2

1. **New** → **Query** → вставь SQL Query 3.2
2. **Run** → проверь
3. Сохрани: `Base Agentic Gaming - Projects Comparison`
4. Создай **Table** визуализацию
5. Создай **Horizontal Bar** (3.2a) и **Pie Chart** (3.2b)

## Шаг 3: Создать Query 4.1

1. **New** → **Query** → вставь SQL Query 4.1
2. **Run** → проверь
3. Сохрани: `OWB Clash - Key Metrics (Compact)`
4. Создай **5 Counter-визуализаций** (см. таблицу каунтеров)

## Шаг 4: Создать Query 4.2

1. **New** → **Query** → вставь SQL Query 4.2
2. **Run** → проверь
3. Сохрани: `OWB Clash - Bot Activity Distribution`
4. Создай **Horizontal Bar Chart** визуализацию

## Шаг 5: Добавить Text Widgets

1. Открой дашборд → **Edit**
2. Нажми **Add text widget** → вставь текст Section 3 Header
3. Нажми **Add text widget** → вставь текст Section 4 Header

## Шаг 6: Расположить виджеты

1. В **Edit** mode перетащи виджеты по карте layout:
   - Замени placeholder "Base Agentic Gaming — Coming Soon..." на новые виджеты Section 3
   - Замени placeholder "OWB Agentic Gaming — Coming Soon..." на новые виджеты Section 4
2. Убедись что всё между секцией "Base vs Solana" и "Methodology"

## Шаг 7: Обновить Table of Contents

1. Найди text widget с таблицей `| Section | What You'll Find |`
2. Добавь строки для Base Agentic Gaming и OWB Agentic Gaming (см. выше)

## Шаг 8: Обновить Methodology

1. Найди Methodology footer (последний text widget)
2. Добавь новые секции перед закрывающей строкой (см. текст выше)

## Шаг 9: Финальная проверка

- [ ] Все 4 queries работают без ошибок
- [ ] 10 каунтеров отображают корректные цифры
- [ ] 4 графика (bar+line, area, line, horizontal bar) отрисовываются
- [ ] 1 таблица показывает все проекты
- [ ] 1 pie chart показывает распределение
- [ ] Цветовая палитра соответствует спецификации
- [ ] Table of Contents обновлён
- [ ] Methodology обновлена
- [ ] Placeholders "Coming Soon..." удалены

---

# ПРИМЕЧАНИЯ

## Как добавить новый agentic gaming проект (Section 3)

1. Найди контракт проекта на [BaseScan](https://basescan.org)
2. Добавь адрес в `gaming_contracts` CTE в Queries 3.1 и 3.2
3. Добавь описание в текстовый виджет Section 3
4. Обнови Methodology

## Отслеживаемые контракты

### Section 3 — Base Agentic Gaming

| Project | Contract | Type |
|---------|----------|------|
| Last AI Standing | `0x88beBFeA498619D4eA891E707c47C43E2D43E62d` | Game Contract |
| Agent Royale ($ROYAL) | `0xF5178A7562B580309F48a4dc8aCDDAf15587eb07` | Token |
| Clash of Coins (OWB) | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | Token |
| Clash of Coins Rewards | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | ClaimRewards |

### Section 4 — OWB Ecosystem (Compact)

| Contract | Address | Purpose |
|----------|---------|---------|
| OWB Token (ERC-20) | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | Core token |
| ClaimRewards | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | Rewards claim |
| Aerodrome Pool | `0x995985c9027e8a90c823a5e0a9112fea72d1f4dd` | Main DEX liquidity |
| NFT Sales (Web) | `0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b` | Web CoC NFT sales |
| NFT Sales (Base App) | `0xf46A1D3eAA84558887169CF2CEE343491364c8BA` | Base app NFT sales |

## Если запрос выдаёт ошибку

1. **Адреса:** DuneSQL использует `0x` varbinary. Если ошибка — попробуй `FROM_HEX('...')`
2. **Таблицы:** `base.transactions` для прямых tx, `dex.trades` для DEX, `tokens.transfers` (с `WHERE blockchain = 'base'`) для ERC20
3. **Производительность:** Убедись что есть фильтр по дате
4. **WoW:** Используем rolling 7d vs previous 7d (не calendar week) для корректного сравнения

## Полные запросы (для возможного расширения)

Если в будущем понадобится развернуть Section 4 обратно до полной версии, все SQL-запросы доступны в:
- `docs/SECTIONS_3_4_AGENTIC_GAMING_DASHBOARD.md` — полная инструкция (19+ виджетов)
- `queries/owb-gaming-dashboard/` — SQL файлы отдельных запросов

---

*Документ создан: Апрель 2026*
*Версия: Compact (Section 3 full + Section 4 trimmed)*
*Формат: DuneSQL (Trino-based)*
*Совместимо с: https://dune.com/ax1research/base-agentic-ecosystem*
