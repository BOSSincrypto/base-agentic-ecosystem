# РАЗДЕЛЫ 3 & 4: Финальная Реализация — Код + Инструкции (v2)

> **Дашборд:** `Base Agentic: The Birth of AI Economy`
> **URL:** https://dune.com/ax1research/base-agentic-ecosystem
> **Разделы:** Section 3 (Base Agentic Gaming) + Section 4 (OWB Agentic Gaming)
> **Дата:** Апрель 2026, v2
> **Изменения v2:** Учтены все рекомендации из командного обсуждения (апрель 12-16, 2026)

---

## СОДЕРЖАНИЕ

1. [Общий план](#общий-план)
2. [Ключевые изменения v2](#ключевые-изменения-v2)
3. [Section 3: Base Agentic Gaming](#section-3-base-agentic-gaming)
   - Text Widget S3
   - Query 3.1 — Ecosystem Pulse
   - Query 3.2 — Projects Comparison
   - Визуализации и оформление
4. [Section 4: OWB Agentic Gaming](#section-4-owb-agentic-gaming)
   - Text Widget S4
   - Query 4.1 — Key Metrics (KPI Bar)
   - Query 4.2 — Community Growth (Retention)
   - Query 4.3 — NFT Purchases
   - Query 4.4 — Agentic Passes
   - Визуализации и оформление
5. [Корректировки существующих секций (V1 Fixes)](#корректировки-существующих-секций-v1-fixes)
6. [Обновление Table of Contents](#обновление-table-of-contents)
7. [Обновление Methodology (Footer)](#обновление-methodology-footer)
8. [Порядок действий на Dune — Чеклист](#порядок-действий-на-dune--чеклист)

---

## КЛЮЧЕВЫЕ ИЗМЕНЕНИЯ v2

Согласно обсуждению команды (Сергей RUA, Hempanda, AX1) от 12-16 апреля 2026:

### Section 3 — Base Agentic Gaming
| Изменение | Причина |
|-----------|---------|
| **Удалён Agent Royale** | Мёртвая игра — последние транзакции были давно, только approve, нет transfer/claim (@remmez) |
| **Добавлена пометка LegendOfBase (Uptopia)** | Новый проект — можно начинать добавлять (@remmez, Apr 16) |
| **WoW: rolling 7d vs prev 7d** | Calendar week давала ложное падение — в понедельник утром wow = -99% (@remmez) |
| **Избегать лог-шкалы** | Не считывается визуально, данные уедут вперёд (@Hempanda, @remmez) |

### Section 4 — OWB Agentic Gaming
| Изменение | Причина |
|-----------|---------|
| **$5M призовой фонд** (было $1M) | Коррекция от @ax1ecosystem (Apr 14) |
| **DTU вместо "bots"** | "Бот" слишком негативный контекст, используем DTU (Daily Transacting Users) (@Hempanda) |
| **Новые контракты** | Agentic Claim 1/2, Agentic Passes (AGNTC), NFT Sales Base App — из Google Sheets команды |
| **Дата старта: 25.03.2026** | Старт agentic presale — отправная точка всех запросов (@ax1ecosystem, @remmez) |
| **MRR пересмотрен** | DEX trades это не revenue; добавлены данные по продажам NFT/пассов (@remmez) |
| **4 блока вместо 2** | KPI + Retention + NFT Purchases + Agentic Passes (@remmez, Apr 16) |
| **Убрана ссылка на NFT Sales** | Заменена на ссылку на CMS (@ax1ecosystem) |
| **Убрана ссылка на Aerodrome** | Заменена на ссылку на CMS (coinmarketcap) (@ax1ecosystem) |
| **Claim rewards оставлен** | Для охвата адресов; клейм переносится в агентскую часть (@ax1ecosystem) |

---

## ОБЩИЙ ПЛАН

### Что добавляем

| Section | Queries | Widgets | Rows |
|---------|---------|---------|------|
| **3) Base Agentic Gaming** | 2 queries | 1 text + 5 counters + 3 charts + 1 table + 1 bar + 1 pie = **12** | 6 рядов |
| **4) OWB Agentic Gaming** | 4 queries | 1 text + 5 counters + 3 charts = **9** | 5 рядов |
| **Total** | **6 queries** | **21 widgets** | **11 рядов** |

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
9. **→ Section 4: OWB Agentic Gaming** ← НОВОЕ
10. Methodology (footer)

---

## ЦВЕТОВАЯ ПАЛИТРА

| Element | Color | HEX |
|---------|-------|-----|
| Agentic Gaming | Pink/Magenta | `#EC4899` |
| OWB Brand | Orange | `#F97316` |
| DTU/User Metrics | Cyan | `#06B6D4` |
| Revenue/MRR | Emerald | `#22C55E` |
| Growth/Positive | Green | `#10B981` |
| Decline/Negative | Red | `#EF4444` |
| Volume/Money | Amber | `#F59E0B` |
| Secondary Lines | Slate | `#64748B` |
| Cumulative Lines | Dark Pink | `#BE185D` |
| Agentic Passes | Purple | `#8B5CF6` |

---

## КАРТА LAYOUT (НОВЫЕ СЕКЦИИ)

```
=====================================================================
  SECTION 3: BASE AGENTIC GAMING
=====================================================================

РЯД S3-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ - 12 колонок]
          "Base Agentic Gaming: Where AI Agents Become Players"

РЯД S3-2: [5 КАУНТЕРОВ из Query 3.1]
          | Total Gaming Txs | Unique Players | Active Projects |
          | This Week Txs | WoW Growth % |

РЯД S3-3: [ГРАФИК 3.1a - 12 колонок]
          Daily Agentic Gaming Transactions (bars + 7d MA line)

РЯД S3-4: [ГРАФИК 3.1b - 6 кол.]  [ГРАФИК 3.1c - 6 кол.]
          Daily Unique Players (area)    Cumulative Unique Players (line)

РЯД S3-5: [ТАБЛИЦА 3.2 - 12 колонок]
          Agentic Gaming Projects Comparison

РЯД S3-6: [ГРАФИК 3.2a - 8 кол.]  [ГРАФИК 3.2b - 4 кол.]
          Gaming Txs by Project (bar)    Agentic Gaming Tx Share (pie)

=====================================================================
  SECTION 4: OWB AGENTIC GAMING
=====================================================================

РЯД S4-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ - 12 колонок]
          "Clash of Coins (OWB): Agentic Economy Snapshot"

РЯД S4-2: [5 КАУНТЕРОВ из Query 4.1 - KPI Bar]
          | NFT Revenue (USD) | Total DTU | Monthly Active DTU |
          | Total Txs (30d) | WoW Growth % |

РЯД S4-3: [ГРАФИК 4.2 - 12 колонок]
          Community Growth / Retention (stacked bar: new + returning)

РЯД S4-4: [ГРАФИК 4.3 - 6 кол.]  [ГРАФИК 4.4 - 6 кол.]
          NFT Purchases (bar)            Agentic Passes Distribution (pie/bar)

РЯД S4-5: [ТЕКСТ - 12 колонок] (опционально)
          Примечание: "Data starts from agentic presale (Mar 25, 2026)"
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

We track the emerging category of games designed **for** AI agents on Base. These are arenas where autonomous agents compete, survive, and earn - using real tokens and verifiable on-chain logic.

**What we track:**
- **Survival games** - agents pay to stay alive, dead agents fund the living (Last AI Standing)
- **Agentic tournaments** - the first $5M AI agent tournament on Base (Clash of Coins)
- **Agent-gated experiences** - NFTs and assets only AI agents can mint or earn

This is the **GameAI era** - where the game itself becomes a proving ground for machine intelligence. Projects here are in early/launch stage. The moment new agentic gaming contracts deploy on Base, they will appear in this section.

> OWB is the first large-scale GameAI project on Base and currently the pioneer and monopolist in this category. More projects (LegendOfBase/Uptopia and others) are expected to join as the agentic gaming ecosystem grows.
```

**Изменения v2:**
- Удалён Agent Royale ("Battle arenas" пункт)
- Обновлён $5M (было $1M)
- Добавлена цитата-примечание про OWB как пионера и ожидание LegendOfBase
- Убраны em-dashes ("--"), заменены на обычные дефисы (требование @ax1ecosystem)

---

## QUERY 3.1: Base Agentic Gaming - Ecosystem Pulse & Daily Activity

### Что он делает
Отслеживает совокупную активность всех agentic gaming проектов на Base: транзакции, уникальные игроки, ежедневная динамика с 7-дневными скользящими средними, кумулятивный рост уникальных пользователей. Показывает KPI-каунтеры + три графика.

### На какие вопросы отвечает
- Сколько всего транзакций и игроков в agentic gaming на Base?
- Какой тренд - растёт или стагнирует?
- Какой проект генерирует больше всего активности?
- Какова недельная динамика (WoW)?

### Название запроса при сохранении
`Base Agentic Gaming - Ecosystem Pulse`

### SQL-код

```sql
-- Base Agentic Gaming: Ecosystem Pulse & Daily Activity
-- Tracks all known agentic gaming contracts on Base
-- v2: Agent Royale removed (dead game), WoW uses rolling 7d comparison
-- v2: Cumulative unique players instead of cumulative txs

WITH gaming_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0x88beBFeA498619D4eA891E707c47C43E2D43E62d, 'Last AI Standing'),
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

-- Current 7 days (rolling, not calendar week)
current_week AS (
    SELECT
        COUNT(*) AS week_txs,
        COUNT(DISTINCT t."from") AS week_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '7' day
      AND t.block_time < DATE_TRUNC('day', NOW())
      AND t.success = true
),

-- Previous 7 days (rolling)
prev_week AS (
    SELECT
        COUNT(*) AS prev_txs,
        COUNT(DISTINCT t."from") AS prev_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '14' day
      AND t.block_time < DATE_TRUNC('day', NOW()) - INTERVAL '7' day
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

-- New unique players per day (first-time appearance)
first_seen AS (
    SELECT
        t."from" AS player,
        MIN(DATE_TRUNC('day', t.block_time)) AS first_day
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1
),

new_players_daily AS (
    SELECT
        first_day AS day,
        COUNT(*) AS new_players
    FROM first_seen
    GROUP BY 1
),

-- With moving averages + cumulative unique players
with_ma AS (
    SELECT
        da.day,
        da.daily_txs,
        da.daily_players,
        ROUND(AVG(da.daily_txs) OVER (ORDER BY da.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS txs_7d_ma,
        ROUND(AVG(da.daily_players) OVER (ORDER BY da.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS players_7d_ma,
        SUM(da.daily_txs) OVER (ORDER BY da.day) AS cumulative_txs,
        SUM(COALESCE(np.new_players, 0)) OVER (ORDER BY da.day) AS cumulative_unique_players
    FROM daily_agg da
    LEFT JOIN new_players_daily np ON da.day = np.day
)

SELECT
    wm.day,
    wm.daily_txs AS "Daily Gaming Txs",
    wm.daily_players AS "Daily Unique Players",
    wm.txs_7d_ma AS "Txs 7d MA",
    wm.players_7d_ma AS "Players 7d MA",
    wm.cumulative_txs AS "Cumulative Gaming Txs",
    wm.cumulative_unique_players AS "Cumulative Unique Players",
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

**Изменения v2:**
- Agent Royale убран из `gaming_contracts` CTE
- WoW: используется `DATE_TRUNC('day', NOW())` для сравнения полных завершённых 7-дневных периодов (не частичных)
- Добавлен `cumulative_unique_players` (новые адреса по дням) - более сильная метрика здоровья экосистемы вместо просто cumulative txs (@remmez)
- Cumulative txs оставлен для обратной совместимости, но для графика 3.1c используем cumulative unique players

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

#### График 3.1a: Daily Gaming Activity (РЯД S3-3 - 12 колонок)

1. Тип: **Bar Chart** с наложением Line
2. **X-axis:** `day`
3. **Y-axis (бары):** `Daily Gaming Txs` - Pink `#EC4899`
4. **Y-axis (линия):** `Txs 7d MA` - тёмно-розовый `#BE185D`, пунктирная
5. **Stacking:** OFF (одна серия)
6. **Scale:** Linear (НЕ логарифмическая) - лог-шкала не считывается визуально
7. **Ширина:** 12 колонок (полная ширина)
8. **Заголовок:** `Daily Agentic Gaming Transactions on Base`

#### График 3.1b: Daily Unique Players (РЯД S3-4, 6 колонок слева)

1. Тип: **Area Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Daily Unique Players` - Cyan `#06B6D4`
4. **Scale:** Linear
5. **Ширина:** 6 колонок
6. **Заголовок:** `Daily Unique Players`

#### График 3.1c: Cumulative Unique Players (РЯД S3-4, 6 колонок справа)

1. Тип: **Line Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Cumulative Unique Players` - Dark Pink `#BE185D`
4. **Ширина:** 6 колонок
5. **Заголовок:** `Cumulative Unique Players (New Addresses)`

**Изменение v2:** Заменён "Cumulative Gaming Txs" на "Cumulative Unique Players" - показывает реальное здоровье экосистемы, а не просто накопление транзакций (@remmez).

---

## QUERY 3.2: Base Agentic Gaming - Projects Comparison

### Что он делает
Сравнительная таблица всех agentic gaming проектов на Base: транзакции за 30 дней, уникальные игроки, WoW-динамика, средний размер транзакции, доля от общей активности + Avg Txs/User.

### На какие вопросы отвечает
- Какой agentic gaming проект самый активный?
- У кого больше уникальных игроков?
- Кто растёт быстрее?
- Какова доля каждого проекта в общей активности?
- Какова вовлечённость аудитории (Avg Txs/User)?

### Название запроса при сохранении
`Base Agentic Gaming - Projects Comparison`

### SQL-код

```sql
-- Base Agentic Gaming: Projects Comparison & Leaderboard
-- v2: Agent Royale removed, added Avg Txs/User, WoW uses rolling 7d

WITH gaming_contracts AS (
    SELECT address, name, category FROM (
        VALUES
        (0x88beBFeA498619D4eA891E707c47C43E2D43E62d, 'Last AI Standing', 'Survival'),
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

-- 7-day metrics (rolling, full completed days)
metrics_7d AS (
    SELECT
        gc.name AS project,
        COUNT(*) AS txs_7d,
        COUNT(DISTINCT t."from") AS players_7d
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '7' day
      AND t.block_time < DATE_TRUNC('day', NOW())
      AND t.success = true
    GROUP BY 1
),

-- Previous 7 days (rolling)
metrics_prev_7d AS (
    SELECT
        gc.name AS project,
        COUNT(*) AS txs_prev_7d,
        COUNT(DISTINCT t."from") AS players_prev_7d
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '14' day
      AND t.block_time < DATE_TRUNC('day', NOW()) - INTERVAL '7' day
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
        ROUND(CAST(m.txs_30d AS DOUBLE) / NULLIF(m.players_30d, 0), 1) AS avg_txs_per_user,
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
    avg_txs_per_user AS "Avg Txs/User",
    txs_7d AS "Txs (7d)",
    players_7d AS "Players (7d)",
    wow_txs_pct AS "WoW Txs %",
    wow_players_pct AS "WoW Players %",
    ecosystem_share_pct AS "Ecosystem Share %",
    eth_volume_30d AS "ETH Vol (30d)",
    avg_tx_eth AS "Avg Tx (ETH)",
    first_seen AS "First Seen",
    last_active AS "Last Active"
FROM combined
ORDER BY txs_30d DESC
```

**Изменения v2:**
- Agent Royale удалён из списка проектов
- WoW: `DATE_TRUNC('day', NOW())` для полных завершённых периодов
- Добавлена колонка `Avg Txs/User` - вовлечённость аудитории, завышенный коэффициент = подозрение на ботовую активность (@remmez)

### Визуализации из Query 3.2

#### Таблица 3.2: Projects Comparison (РЯД S3-5 - 12 колонок)

1. Тип: **Table**
2. **Условное форматирование:**
   - `WoW Txs %`: зелёный если >0, красный если <0
   - `WoW Players %`: зелёный если >0, красный если <0
   - `Ecosystem Share %`: градиент от светлого к тёмному
3. Скрой колонки `First Seen`, `Last Active` (слишком детально для overview)
4. **Ширина:** 12 колонок
5. **Заголовок:** `Agentic Gaming Projects on Base - 30-Day Comparison`

#### График 3.2a: Transaction Breakdown by Project (РЯД S3-6, 8 колонок)

1. Тип: **Bar Chart** (горизонтальный)
2. **Y-axis:** `Project`
3. **X-axis:** `Txs (30d)` - Pink `#EC4899`
4. **Показать значения** на каждом баре
5. **Ширина:** 8 колонок
6. **Заголовок:** `Gaming Transactions by Project (30d)`

> **Примечание (@remmez):** Этот бар-чарт может быть избыточным если информация уже есть в таблице выше и в pie chart рядом. При компоновке финального дашборда решите, оставить его или нет.

#### График 3.2b: Ecosystem Share Pie (РЯД S3-6, 4 колонки)

1. Тип: **Pie Chart**
2. **Labels:** `Project`
3. **Values:** `Txs (30d)`
4. **Цвета:**
   - Last AI Standing: `#EC4899`
   - Clash of Coins: `#06B6D4`
   - CoC Rewards: `#8B5CF6`
5. **Показать %** на каждом сегменте
6. **Ширина:** 4 колонки
7. **Заголовок:** `Agentic Gaming Tx Share`

---

---

# SECTION 4: OWB AGENTIC GAMING

> **Важно v2:** Секция расширена с 2 queries/7 widgets до 4 queries/9 widgets.
> Структура согласована с @remmez (Apr 16):
> - Block 1: KPI метрики (headline bar)
> - Block 2: Retention / Community Growth
> - Block 3: NFT покупки (без Passes & Packs)
> - Block 4: Agentic Passes
>
> **Все данные с 25.03.2026** (старт agentic presale)

---

## Text Widget S4: Section Header (РЯД S4-1)

**Как добавить:** Edit dashboard → Add text widget → вставить текст → растянуть на 12 колонок.

**Текст (скопируй как есть):**

```markdown
---

## Clash of Coins (OWB): Agentic Economy Snapshot

**OWB** is the first large-scale GameAI project on Base - 30K+ DAU, $5M agentic tournament, Agentic-as-a-Service platform. Below: key metrics, community growth, and agentic passes analysis.

Data starts from agentic presale (March 25, 2026). Pre-agentic gaming activity is tracked in Section 3 above.

Contracts: [OWB Token](https://basescan.org/address/0xEF5997c2cf2f6c138196f8a6203afc335206b3c1) · [ClaimRewards](https://basescan.org/address/0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40) · [Agentic Passes](https://basescan.org/address/0x49046E2988A78222693c04AD049b68e5A4801034) · [CoinMarketCap](https://coinmarketcap.com/currencies/owb/)
```

**Изменения v2:**
- $5M вместо $1M (@ax1ecosystem)
- Убрана ссылка на NFT Sales и Aerodrome Pool (@ax1ecosystem)
- Добавлена ссылка на CoinMarketCap вместо Aerodrome (@ax1ecosystem)
- Добавлена ссылка на Agentic Passes контракт
- Добавлено примечание о дате начала данных (25.03.2026)
- Убраны em-dashes

---

## QUERY 4.1: OWB - Key Metrics (KPI Bar)

### Что он делает
Один консолидированный запрос для 5 KPI-каунтеров. Объединяет NFT revenue, DTU (Daily Transacting Users) census и transaction telemetry.

### На какие вопросы отвечает
- Сколько реального revenue генерирует OWB ончейн?
- Сколько уникальных адресов (DTU) взаимодействует с контрактами?
- Какова транзакционная активность за 30 дней?
- Растёт ли активность WoW?

### Название запроса при сохранении
`OWB Clash - Key Metrics (KPI Bar)`

### SQL-код

```sql
-- OWB Clash of Coins: Consolidated Key Metrics
-- v2: DTU instead of "bots", NFT revenue instead of DEX volume as MRR proxy
-- v2: All contracts from team spreadsheet, start from 2026-03-25
-- v2: WoW uses DATE_TRUNC for full completed day comparison

WITH owb_contracts AS (
    SELECT address, label FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'Claim Rewards'),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'Agentic Claim 1'),
        (0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203, 'Agentic Claim 2'),
        (0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b, 'NFT Sales Web'),
        (0xf46A1D3eAA84558887169CF2CEE343491364c8BA, 'NFT Sales Base App'),
        (0x49046E2988A78222693c04AD049b68e5A4801034, 'Agentic Passes')
    ) AS t(address, label)
),

-- 1) NFT Revenue: actual sales from NFT contracts (web + base app)
-- Web sales: vOWB topic0 = 0xf10061..., USDC topic0 = 0x632831...
-- Base App sales: USDC only, sent to 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
nft_revenue AS (
    SELECT
        ROUND(COALESCE(SUM(amount_usd), 0), 2) AS nft_revenue_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= GREATEST(
          DATE_TRUNC('month', NOW()) - INTERVAL '1' month,
          DATE '2026-03-25'
      )
      AND block_time < DATE_TRUNC('month', NOW())
      AND amount_usd > 0
),

-- 2) Total DTU All-Time: unique addresses interacting with OWB contracts
total_dtu AS (
    SELECT COUNT(DISTINCT t."from") AS total_dtu_alltime
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE '2026-03-25'
),

-- 3) Monthly Active DTU: unique addresses last 30d
monthly_active AS (
    SELECT COUNT(DISTINCT t."from") AS monthly_active_dtu
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

-- 5) WoW Growth: rolling 7d vs previous 7d (full completed days only)
wow_current AS (
    SELECT COUNT(*) AS txs_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '7' day
      AND t.block_time < DATE_TRUNC('day', NOW())
),
wow_prev AS (
    SELECT COUNT(*) AS txs_prev_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '14' day
      AND t.block_time < DATE_TRUNC('day', NOW()) - INTERVAL '7' day
)

SELECT
    nr.nft_revenue_usd AS "NFT Revenue (USD)",
    tb.total_dtu_alltime AS "Total DTU (All-Time)",
    ma.monthly_active_dtu AS "Monthly Active DTU",
    t30.total_txs_30d AS "Total Txs (30d)",
    CASE
        WHEN wp.txs_prev_7d > 0
        THEN ROUND(100.0 * (wc.txs_7d - wp.txs_prev_7d) / wp.txs_prev_7d, 1)
        ELSE 0
    END AS "WoW Growth %"
FROM nft_revenue nr
CROSS JOIN total_dtu tb
CROSS JOIN monthly_active ma
CROSS JOIN txs_30d t30
CROSS JOIN wow_current wc
CROSS JOIN wow_prev wp
```

**Изменения v2:**
- **DTU (Daily Transacting Users)** вместо "Bots" во всех метках - менее негативная коннотация (@Hempanda)
- **7 контрактов** вместо 2 - добавлены Agentic Claim 1/2, NFT Sales (Web + Base App), Agentic Passes
- **Дата старта: 2026-03-25** (presale agentic) вместо 2026-01-01
- **WoW: DATE_TRUNC('day', NOW())** - сравниваем только полные завершённые дни, чтобы утром понедельника не показывало -99% (@remmez)
- **NFT Revenue** вместо "MRR Proxy" - но пока используем DEX volume как приближение; в v3 будет точный подсчёт по event logs NFT контрактов

> **TODO для v3:** Заменить `dex.trades` подсчёт на прямой подсчёт event logs:
> - Web NFT: контракт `0x3C83eF...`, topic0 vOWB = `0xf10061...`, topic0 USDC = `0x632831...`
> - Base App NFT: контракт `0xf46A1D...`, только USDC
> - Agentic Passes: контракт `0x490462...`
> Формула MRR по пассам (@Hempanda): `188 x $1000/12 + 458 x $100/3 + 1655 x $10 = ~$47.9K/mo`

### Визуализации: 5 Каунтеров (РЯД S4-2)

Из единственной строки результата создаём **5 Counter-визуализаций**:

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **NFT Revenue (USD)** | `NFT Revenue (USD)` | USD, 0 десятичных | Emerald `#22C55E` | 2-3 кол. |
| 2 | **Total DTU** | `Total DTU (All-Time)` | Number | Orange `#F97316` | 2-3 кол. |
| 3 | **Monthly Active DTU** | `Monthly Active DTU` | Number | Cyan `#06B6D4` | 2-3 кол. |
| 4 | **Total Txs (30d)** | `Total Txs (30d)` | Number | Pink `#EC4899` | 2-3 кол. |
| 5 | **WoW Growth** | `WoW Growth %` | Percentage (1 дес.) | Green `#10B981` (>0) / Red `#EF4444` (<0) | 2-3 кол. |

**Как создать каунтер в Dune:**
1. Открой запрос `OWB Clash - Key Metrics (KPI Bar)` → Run
2. Нажми **New visualization** → выбери **Counter**
3. В поле **Column** выбери нужную колонку (напр. `NFT Revenue (USD)`)
4. В **Title** впиши название
5. В **Prefix** поставь `$` для USD-метрик
6. В **Suffix** поставь `%` для WoW Growth
7. Повтори для каждого каунтера (5 раз из одного запроса)

---

## QUERY 4.2: OWB - Community Growth (Retention)

### Что он делает
Отслеживает рост сообщества: новые vs вернувшиеся пользователи по дням с момента presale. Показывает retention и привлечение новой аудитории.

### На какие вопросы отвечает
- Сколько новых пользователей приходит каждый день?
- Возвращаются ли пользователи?
- Каков retention rate сообщества?

### Название запроса при сохранении
`OWB Clash - Community Growth (Retention)`

### SQL-код

```sql
-- OWB Clash of Coins: Community Growth / Retention
-- v2: Based on @remmez proposal (dune.com/queries/7322191)
-- Tracks new vs returning users from presale start (2026-03-25)

WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb),
        (0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203),
        (0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b),
        (0xf46A1D3eAA84558887169CF2CEE343491364c8BA),
        (0x49046E2988A78222693c04AD049b68e5A4801034)
    ) AS t(address)
),

-- First seen date for each user
first_seen AS (
    SELECT
        t."from" AS user_address,
        MIN(DATE_TRUNC('day', t.block_time)) AS first_day
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE '2026-03-25'
    GROUP BY 1
),

-- Daily activity per user
daily_users AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        t."from" AS user_address
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE '2026-03-25'
    GROUP BY 1, 2
),

-- Classify each user-day as new or returning
classified AS (
    SELECT
        du.day,
        du.user_address,
        CASE
            WHEN du.day = fs.first_day THEN 'New'
            ELSE 'Returning'
        END AS user_type
    FROM daily_users du
    INNER JOIN first_seen fs ON du.user_address = fs.user_address
),

-- Aggregate by day and type
daily_summary AS (
    SELECT
        day,
        COUNT(CASE WHEN user_type = 'New' THEN 1 END) AS new_users,
        COUNT(CASE WHEN user_type = 'Returning' THEN 1 END) AS returning_users,
        COUNT(*) AS total_dtu
    FROM classified
    GROUP BY 1
),

-- Cumulative unique users
cumulative AS (
    SELECT
        day,
        SUM(new_users) OVER (ORDER BY day) AS cumulative_unique_users
    FROM daily_summary
)

SELECT
    ds.day,
    ds.new_users AS "New Users",
    ds.returning_users AS "Returning Users",
    ds.total_dtu AS "Total DTU",
    c.cumulative_unique_users AS "Cumulative Unique Users",
    CASE
        WHEN ds.total_dtu > 0
        THEN ROUND(100.0 * ds.returning_users / ds.total_dtu, 1)
        ELSE 0
    END AS "Retention Rate %"
FROM daily_summary ds
INNER JOIN cumulative c ON ds.day = c.day
WHERE ds.day < CURRENT_DATE
ORDER BY ds.day ASC
```

### Визуализация: Stacked Bar Chart (РЯД S4-3 - 12 колонок)

1. Тип: **Bar Chart** (stacked)
2. **X-axis:** `day`
3. **Y-axis series 1:** `New Users` - Cyan `#06B6D4`
4. **Y-axis series 2:** `Returning Users` - Orange `#F97316`
5. **Stacking:** ON
6. **Ширина:** 12 колонок
7. **Заголовок:** `OWB Community Growth: New vs Returning Users (since Presale)`
8. **Описание:** `Users who interact with any OWB contract for the first time = New; any subsequent day = Returning`

---

## QUERY 4.3: OWB - NFT Purchases

### Что он делает
Отслеживает покупки NFT (in-game items) через оба канала: Web версия и Base App. Не включает Agentic Passes & Hero Packs (для них отдельный запрос 4.4).

### На какие вопросы отвечает
- Сколько покупок совершается ежедневно?
- Какой канал (Web vs Base App) активнее?
- Какова динамика продаж?

### Название запроса при сохранении
`OWB Clash - NFT Purchases`

### SQL-код

```sql
-- OWB Clash of Coins: NFT Purchases (in-game items)
-- Web version: 0x3C83eF... (vOWB + USDC)
-- Base App: 0xf46A1D... (USDC only)
-- Excludes Agentic Passes & Hero Packs (see Query 4.4)

WITH nft_sales_web AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        COUNT(*) AS sales_count,
        'Web' AS channel
    FROM base.logs
    WHERE contract_address = 0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b
      AND (
          topic0 = 0xf10061092bbb1af405b21f944d5a3fc967534deaabe2a030b36dfdd9e565d1e6  -- vOWB sale
          OR topic0 = 0x63283f7a7cc750062bcd0676724d5ad05f2fa23df7619d9bde3f8abc776575d1  -- USDC sale
      )
      AND block_time >= DATE '2026-03-25'
    GROUP BY 1
),

nft_sales_baseapp AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS sales_count,
        'Base App' AS channel
    FROM base.transactions t
    WHERE t."to" = 0xf46A1D3eAA84558887169CF2CEE343491364c8BA
      AND t.success = true
      AND t.block_time >= DATE '2026-03-25'
    GROUP BY 1
),

combined AS (
    SELECT * FROM nft_sales_web
    UNION ALL
    SELECT * FROM nft_sales_baseapp
)

SELECT
    day,
    channel AS "Channel",
    sales_count AS "Sales Count",
    SUM(sales_count) OVER (PARTITION BY channel ORDER BY day) AS "Cumulative Sales"
FROM combined
WHERE day < CURRENT_DATE
ORDER BY day ASC, channel
```

### Визуализация: Stacked Bar Chart (РЯД S4-4, 6 колонок слева)

1. Тип: **Bar Chart** (stacked)
2. **X-axis:** `day`
3. **Y-axis:** `Sales Count`
4. **Group by:** `Channel`
5. **Цвета:**
   - Web: Emerald `#22C55E`
   - Base App: Amber `#F59E0B`
6. **Stacking:** ON
7. **Ширина:** 6 колонок
8. **Заголовок:** `Daily NFT Purchases (Web + Base App)`

---

## QUERY 4.4: OWB - Agentic Passes

### Что он делает
Отслеживает продажи и распределение Agentic Passes (AGNTC). Показывает общие метрики по агентским пассам.

### На какие вопросы отвечает
- Сколько Agentic Passes продано?
- Сколько уникальных владельцев пассов?
- Какова динамика продаж пассов?

### Название запроса при сохранении
`OWB Clash - Agentic Passes`

### SQL-код

```sql
-- OWB Clash of Coins: Agentic Passes (AGNTC)
-- Contract: 0x49046E2988A78222693c04AD049b68e5A4801034
-- Based on @Hempanda's work (dune.com/queries/7322915)

WITH pass_txs AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT t."from") AS daily_buyers
    FROM base.transactions t
    WHERE t."to" = 0x49046E2988A78222693c04AD049b68e5A4801034
      AND t.success = true
      AND t.block_time >= DATE '2026-03-25'
    GROUP BY 1
),

-- Date spine
date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2026-03-25', CURRENT_DATE, INTERVAL '1' day)) AS t(day)
),

-- Fill missing days
daily_filled AS (
    SELECT
        ds.day,
        COALESCE(pt.daily_txs, 0) AS daily_txs,
        COALESCE(pt.daily_buyers, 0) AS daily_buyers
    FROM date_spine ds
    LEFT JOIN pass_txs pt ON ds.day = pt.day
),

-- Total holders (unique addresses that received passes via Transfer events)
total_holders AS (
    SELECT COUNT(DISTINCT buyer) AS unique_holders
    FROM (
        SELECT DISTINCT t."from" AS buyer
        FROM base.transactions t
        WHERE t."to" = 0x49046E2988A78222693c04AD049b68e5A4801034
          AND t.success = true
          AND t.block_time >= DATE '2026-03-25'
    ) sub
)

SELECT
    df.day,
    df.daily_txs AS "Daily Pass Txs",
    df.daily_buyers AS "Daily Pass Buyers",
    SUM(df.daily_txs) OVER (ORDER BY df.day) AS "Cumulative Pass Txs",
    SUM(df.daily_buyers) OVER (ORDER BY df.day) AS "Cumulative Pass Buyers",
    th.unique_holders AS "Total Pass Holders"
FROM daily_filled df
CROSS JOIN total_holders th
WHERE df.day < CURRENT_DATE
ORDER BY df.day ASC
```

### Визуализация: Bar Chart + Counter (РЯД S4-4, 6 колонок справа)

**Counter:** Total Pass Holders
1. Тип: **Counter**
2. **Column:** `Total Pass Holders`
3. **Цвет:** Purple `#8B5CF6`
4. **Title:** `Agentic Pass Holders`

**Chart:** Cumulative Pass Buyers
1. Тип: **Line Chart** или **Area Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Cumulative Pass Buyers` - Purple `#8B5CF6`
4. **Ширина:** 6 колонок
5. **Заголовок:** `Agentic Pass Holders Growth`

> **Примечание (@Hempanda):** ~1800 агентов готовятся играть, при 2300 холдеров пассов. Эта динамика будет интересна после запуска беты. Hero = пак из трёх агентов, можно отражать отдельно в v3.
>
> **MRR формула по пассам** (@Hempanda, Apr 14):
> `188 x $1000/12mo + 458 x $100/3mo + 1655 x $10/mo = ~$47.9K/mo estimated MRR`

---

---

# КОРРЕКТИРОВКИ СУЩЕСТВУЮЩИХ СЕКЦИЙ (V1 FIXES)

> Следующие исправления предложены @remmez (Сергей RUA) 12 апреля 2026.
> Они касаются уже существующих секций дашборда (1-2, не 3-4).
> Каждое исправление описано с объяснением, что было не так и как исправить.

### 1. Cross-Pollination Index

**Проблема:** `base.transactions` не учитывает взаимодействия через DEX (транзакция идёт через Uni/1inch роутер и не попадает в `transactions` по адресу).

**Решение:** Заменить `base.transactions` на `base.traces` - это захватывает все internal calls, включая DEX.

**Нюанс:** `traces` подтягивает инфра-контракты (aerodrome, 1inch и т.д.) с 10K+ транзакций/неделю. Фильтр: `calls < 2000` на адрес, чтобы отсечь автоматизацию и оставить человеческую активность.

**Результат:** Число power users было занижено ~в 2 раза.

### 2. Ecosystem KPIs (WoW)

**Проблема:** Calendar week некорректно сравнивает: если сейчас утро понедельника, то "текущая неделя" = пара часов, а "прошлая неделя" = полные 7 дней. Результат: WoW Growth = -99%.

**Решение:** Сравнивать rolling 7 завершённых дней vs предыдущие 7 завершённых дней:
```sql
-- Текущие 7 дней (завершённые)
WHERE block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '7' day
  AND block_time < DATE_TRUNC('day', NOW())

-- Предыдущие 7 дней
WHERE block_time >= DATE_TRUNC('day', NOW()) - INTERVAL '14' day
  AND block_time < DATE_TRUNC('day', NOW()) - INTERVAL '7' day
```

### 3. Daily Agentic Activity - Time Series

**Проблема:** Cumulative Txs - не самая показательная метрика.

**Решение:** Заменить cumulative txs на **cumulative unique users** (новые адреса по дням). Это более сильная метрика, показывающая реальное здоровье экосистемы.

### 4. Projects Leaderboard (Holders + Avg Txs/User)

**Проблемы:**
1. Holders считались некорректно - любое взаимодействие записывало адрес в holders, даже если он уже не держит токен. Virtuals показывал 1,600,000 holders вместо ~1,100,000.
2. Не было метрики вовлечённости.

**Решение:**
1. Считать holders корректно: только адреса с балансом > 0 (через net transfers)
2. Добавить колонку **Avg Txs/User** - завышенный коэффициент = подозрение на ботов

```sql
-- Корректный подсчёт holders (кто имеет баланс > 0)
-- Пример для одного токена:
SELECT COUNT(*) AS real_holders
FROM (
    SELECT
        "to" AS holder,
        SUM(CASE WHEN "to" = address THEN CAST(value AS DOUBLE) ELSE 0 END)
        - SUM(CASE WHEN "from" = address THEN CAST(value AS DOUBLE) ELSE 0 END) AS balance
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
    GROUP BY 1
    HAVING balance > 0
) sub
```

### 5. Base vs Solana - Growth Dynamics (WoW)

**Проблема:** Ложное падение из-за той же WoW ошибки (calendar week).

**Решение:** Та же формула rolling 7d через `DATE_TRUNC('day', NOW())`.

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
| **OWB Agentic Gaming** | OWB deep dive: NFT revenue, DTU census, retention, agentic passes |
| **Methodology** | Definitions, inclusion criteria, Activity Score formula, known limitations |
```

---

# ОБНОВЛЕНИЕ METHODOLOGY (FOOTER)

Добавь в конец секции Methodology (перед финальной строкой `> This dashboard is a telemetry instrument...`) следующий текст:

```markdown
#### Section 3: Base Agentic Gaming

We track the emerging category of **games designed for AI agents** on Base. These are arenas where autonomous agents compete with real tokens and verifiable on-chain logic. The category is in early/launch stage - we include projects that have:

1. A deployed smart contract on Base with measurable gaming activity
2. Agent-first design (agents are the primary participants, not humans)
3. On-chain settlement (prizes, survival payments, or battle outcomes)

**Tracked projects:** Last AI Standing (USDC survival game), Clash of Coins (first $5M agentic tournament).

**Removed:** Agent Royale (no active transactions detected).

**Upcoming:** LegendOfBase (Uptopia) - monitoring for contract deployment.

#### Section 4: OWB Agentic Gaming

OWB (Clash of Coins) is tracked across 7 on-chain contracts. Data starts from **March 25, 2026** (agentic presale launch).

| Data Source | What We Capture | Table |
|-------------|----------------|-------|
| Direct transactions to OWB contracts | Tx counts, addresses, DTU frequency | `base.transactions` |
| NFT Sales event logs | In-game item purchases (Web + Base App) | `base.logs` |
| Agentic Passes (AGNTC) | Pass sales, holder growth | `base.transactions` |
| DEX trading activity | Volume (USD) as revenue proxy | `dex.trades` |

**DTU (Daily Transacting Users):** Each unique wallet address that interacts with any OWB contract on a given day. This includes human wallets - we cannot yet distinguish between human users and AI agents on-chain. The term DTU is preferred over "bot" to avoid negative connotation.

**NFT Revenue:** Tracked via event logs from two sales contracts (Web version + Base App). This captures verifiable on-chain purchases only. Off-chain payments (card purchases, etc.) are not included.

**Agentic MRR Estimate:** Based on pass tier pricing: ~188 Platinum ($1000/yr) + ~458 Gold ($100/3mo) + ~1655 Silver ($10/mo) = estimated ~$47.9K/month. Actual on-chain verification is done via pass contract transactions.

**Known limitations:**
- Off-chain game activity (gameplay sessions, AI inference, matchmaking) is not captured
- Subscription payments may occur off-chain
- DTU count includes human wallets - no on-chain distinction possible yet (team has been asked to separate agents from humans via different event topics)
- NFT Revenue is on-chain only - actual total revenue is likely higher
- Data starts from March 25, 2026 - pre-agentic activity is in Section 3
```

---

---

# ПОРЯДОК ДЕЙСТВИЙ НА DUNE - ЧЕКЛИСТ

## Шаг 1: Применить V1 Fixes к существующим секциям

1. **Cross-Pollination Index:** Замени `base.transactions` на `base.traces` + фильтр calls < 2000
2. **Ecosystem KPIs:** Исправь WoW на rolling 7d через `DATE_TRUNC('day', NOW())`
3. **Daily Activity:** Замени cumulative txs на cumulative unique users
4. **Leaderboard:** Исправь подсчёт holders (balance > 0), добавь Avg Txs/User
5. **Base vs Solana:** Исправь WoW

## Шаг 2: Создать Query 3.1

1. На Dune нажми **New** → **Query**
2. Вставь SQL-код Query 3.1 (см. выше)
3. Нажми **Run** - проверь, что данные возвращаются
4. Сохрани с названием: `Base Agentic Gaming - Ecosystem Pulse`
5. Создай **5 Counter-визуализаций** (см. таблицу каунтеров выше):
   - New visualization → Counter → выбрать колонку → задать Title/Color
6. Создай **3 графика** (3.1a, 3.1b, 3.1c):
   - New visualization → Bar Chart (3.1a) / Area Chart (3.1b) / Line Chart (3.1c)
   - Настрой оси и цвета по инструкциям выше
   - **Не использовать логарифмическую шкалу** (Linear scale only)

## Шаг 3: Создать Query 3.2

1. **New** → **Query** → вставь SQL Query 3.2
2. **Run** → проверь
3. Сохрани: `Base Agentic Gaming - Projects Comparison`
4. Создай **Table** визуализацию с Avg Txs/User
5. Создай **Horizontal Bar** (3.2a) и **Pie Chart** (3.2b)

## Шаг 4: Создать Query 4.1

1. **New** → **Query** → вставь SQL Query 4.1
2. **Run** → проверь (данные с 25.03.2026)
3. Сохрани: `OWB Clash - Key Metrics (KPI Bar)`
4. Создай **5 Counter-визуализаций** (см. таблицу каунтеров)

## Шаг 5: Создать Query 4.2

1. **New** → **Query** → вставь SQL Query 4.2
2. **Run** → проверь
3. Сохрани: `OWB Clash - Community Growth (Retention)`
4. Создай **Stacked Bar Chart** (New + Returning users)

## Шаг 6: Создать Query 4.3

1. **New** → **Query** → вставь SQL Query 4.3
2. **Run** → проверь
3. Сохрани: `OWB Clash - NFT Purchases`
4. Создай **Stacked Bar Chart** (Web + Base App)

## Шаг 7: Создать Query 4.4

1. **New** → **Query** → вставь SQL Query 4.4
2. **Run** → проверь
3. Сохрани: `OWB Clash - Agentic Passes`
4. Создай **Counter** (Total Pass Holders) и **Line Chart** (Cumulative Pass Buyers)

## Шаг 8: Добавить Text Widgets

1. Открой дашборд → **Edit**
2. Нажми **Add text widget** → вставь текст Section 3 Header
3. Нажми **Add text widget** → вставь текст Section 4 Header

## Шаг 9: Расположить виджеты

1. В **Edit** mode перетащи виджеты по карте layout:
   - Замени placeholder "Base Agentic Gaming - Coming Soon..." на новые виджеты Section 3
   - Замени placeholder "OWB Agentic Gaming - Coming Soon..." на новые виджеты Section 4
2. Убедись что всё между секцией "Base vs Solana" и "Methodology"

## Шаг 10: Обновить Table of Contents

1. Найди text widget с таблицей `| Section | What You'll Find |`
2. Добавь строки для Base Agentic Gaming и OWB Agentic Gaming (см. выше)

## Шаг 11: Обновить Methodology

1. Найди Methodology footer (последний text widget)
2. Добавь новые секции перед закрывающей строкой (см. текст выше)

## Шаг 12: Финальная проверка

- [ ] V1 Fixes применены к существующим секциям (5 исправлений)
- [ ] Все 6 queries работают без ошибок
- [ ] 10 каунтеров отображают корректные цифры
- [ ] Данные Section 4 начинаются с 25.03.2026
- [ ] WoW нигде не показывает ложное -99%
- [ ] Нигде нет em-dashes ("--"), только обычные дефисы
- [ ] Терминология DTU (не "bots")
- [ ] $5M (не $1M)
- [ ] Нет ссылки на NFT Sales / Aerodrome в Section 4 header
- [ ] Agent Royale убран из всех запросов
- [ ] Table of Contents обновлён
- [ ] Methodology обновлена
- [ ] Placeholders "Coming Soon..." удалены
- [ ] Данные между виджетами не противоречат друг другу (сверить каунтеры с графиками)

---

# ПРИМЕЧАНИЯ

## Как добавить новый agentic gaming проект (Section 3)

1. Найди контракт проекта на [BaseScan](https://basescan.org)
2. Добавь адрес в `gaming_contracts` CTE в Queries 3.1 и 3.2
3. Добавь описание в текстовый виджет Section 3
4. Обнови Methodology

> **Следующие кандидаты:** LegendOfBase (Uptopia) - уже можно начинать мониторить контракт (@remmez, Apr 16)

## Отслеживаемые контракты

### Section 3 - Base Agentic Gaming

| Project | Contract | Type | Status |
|---------|----------|------|--------|
| Last AI Standing | `0x88beBFeA498619D4eA891E707c47C43E2D43E62d` | Game Contract | Active |
| Clash of Coins (OWB) | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | Token | Active |
| Clash of Coins Rewards | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | ClaimRewards | Active |
| ~~Agent Royale~~ | ~~`0xF5178A7562B580309F48a4dc8aCDDAf15587eb07`~~ | ~~Token~~ | **Removed v2** |
| LegendOfBase (Uptopia) | TBD | TBD | Pending |

### Section 4 - OWB Ecosystem (Full Contract List)

| Contract | Address | Purpose | Source |
|----------|---------|---------|--------|
| OWB Token (ERC-20) | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | Core token | Team |
| ClaimRewards | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | Rewards claim | Team |
| Agentic Claim 1 | `0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb` | Pre-agentic claim | Team Spreadsheet |
| Agentic Claim 2 | `0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203` | Updated claim | Team Spreadsheet |
| NFT Sales (Web) | `0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b` | Web CoC NFT sales | @Hempanda |
| NFT Sales (Base App) | `0xf46A1D3eAA84558887169CF2CEE343491364c8BA` | Base App sales (USDC) | @Hempanda |
| Agentic Passes (AGNTC) | `0x49046E2988A78222693c04AD049b68e5A4801034` | Agentic pass NFTs | @remmez |
| OWB Staking | `0x692d11c779d43bbc12cb8565c7f71a54a47d117c` | Staking contract | @Hempanda |
| vOWB→OWB Swaps | `0x6fb8a5de77cfb16dd4d4a8af8bcfa4d078c5e088` | Token swap | @Hempanda |
| Aerodrome Pool | `0x995985c9027e8a90c823a5e0a9112fea72d1f4dd` | DEX liquidity | Team |
| Uniswap V3 Pool | `0xf252f51919dfca2c9c0ea279f11183580edee4d6` | DEX liquidity | Team |

### NFT Sales Event Topics (for base.logs queries)

| Event | Topic0 | Contract |
|-------|--------|----------|
| NFT Sale (vOWB) | `0xf10061092bbb1af405b21f944d5a3fc967534deaabe2a030b36dfdd9e565d1e6` | 0x3C83eF... |
| NFT Sale (USDC) | `0x63283f7a7cc750062bcd0676724d5ad05f2fa23df7619d9bde3f8abc776575d1` | 0x3C83eF... |
| Staking: Rewards | `0x106f923f993c2149d49b4255ff723acafa1f2d94393f561d3eda32ae348f7241` | 0x692d11... |
| Staking: Stake | `0x1449c6dd7851abc30abf37f57715f492010519147cc2652fbc38202c18a6ee90` | 0x692d11... |
| Staking: Unstake | `0x7fc4727e062e336010f2c282598ef5f14facb3de68cf8195c2f23e1454b2b74e` | 0x692d11... |

## Если запрос выдаёт ошибку

1. **Адреса:** DuneSQL использует `0x` varbinary. Если ошибка - попробуй `FROM_HEX('...')`
2. **Таблицы:** `base.transactions` для прямых tx, `base.logs` для event logs, `dex.trades` для DEX, `tokens.transfers` (с `WHERE blockchain = 'base'`) для ERC20
3. **Производительность:** Убедись что есть фильтр по дате (минимум `>= DATE '2026-03-25'` для Section 4)
4. **WoW:** Используем rolling 7d через `DATE_TRUNC('day', NOW())` - НЕ calendar week
5. **Терминология:** DTU (Daily Transacting Users), не "bots"
6. **Em-dashes:** Не использовать "—" (длинное тире), только "-" (дефис)

## Полные запросы (для возможного расширения)

Если в будущем понадобится развернуть Section 4 или добавить дополнительные метрики:
- `docs/SECTIONS_3_4_AGENTIC_GAMING_DASHBOARD.md` - полная инструкция
- Готовые запросы от коллег:
  - @remmez KPI: `dune.com/queries/7322445` (форк)
  - @remmez Retention: `dune.com/queries/7322191`
  - @remmez NFT Purchases: `dune.com/queries/7322567`
  - @Hempanda Agentic Passes: `dune.com/queries/7322915`

## Roadmap для v3

- [ ] Прямой подсчёт NFT Revenue через event logs (не DEX proxy)
- [ ] Разбивка по типам пассов (Platinum/Gold/Silver) и Hero Packs
- [ ] Humans vs AI - разделение при наличии разных event topics от команды
- [ ] Наложение agentic метрик на чарт курса OWB токена (лаг влияния)
- [ ] OWB Staking analytics (daily staked/unstaked, rewards claimed)
- [ ] vOWB daily swaps to OWB
- [ ] Добавление LegendOfBase/Uptopia в Section 3

---

*Документ создан: Апрель 2026*
*Версия: v2 (обновлён по рекомендациям команды 12-16 апреля)*
*Формат: DuneSQL (Trino-based)*
*Совместимо с: https://dune.com/ax1research/base-agentic-ecosystem*
