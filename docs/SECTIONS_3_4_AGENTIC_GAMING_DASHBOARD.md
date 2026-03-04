# РАЗДЕЛЫ 3 & 4: Base Agentic Gaming + OWB Agentic Gaming — Полная Инструкция

> **Дашборд:** `Base Agentic: The Birth of AI Economy`
> **Новые разделы:** Section 3 (Base Agentic Gaming) + Section 4 (OWB Agentic Gaming)
> **Поддерживается:** AX1 Community ([Twitter](https://twitter.com/AX1ecosystem))

---

## ОБЩАЯ СТРУКТУРА НОВЫХ РАЗДЕЛОВ

Два новых блока добавляются ПОСЛЕ существующих секций (после Base vs Solana):

| Section | Queries | What It Tracks |
|---------|---------|---------------|
| **3) Base Agentic Gaming** | 2 queries | Emerging agentic gaming landscape on Base: daily activity, players, project comparison |
| **4) OWB Agentic Gaming** | 3 queries | OWB (Clash of Coins) deep dive: MRR proxy, bot census, transaction telemetry |

---

## ОТСЛЕЖИВАЕМЫЕ КОНТРАКТЫ

### Section 3 — Base Agentic Gaming Projects

| Project | Contract | Type | Description |
|---------|----------|------|-------------|
| Last AI Standing | `0x5e9e09b03d08017fddbc1652e9394e7cb4a24074` | Game Contract | USDC survival game — agents pay to stay alive, dead fund the living |
| Agent Royale ($ROYAL) | `0xF5178A7562B580309F48a4dc8aCDDAf15587eb07` | Token | On-chain battle competition — agents fight for ETH prize pool |
| Clash of Coins (OWB) | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | Token | First agentic tournament on Base — $1M prize pool |
| Clash of Coins Rewards | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | ClaimRewards | On-chain rewards claim for Clash of Coins players |

### Section 4 — OWB Ecosystem Contracts

| Contract | Address | Purpose |
|----------|---------|---------|
| OWB Token (ERC-20) | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | Core ecosystem token — powers purchases, upgrades, rewards |
| ClaimRewards | `0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40` | Periodic rewards claim — backend-signed, on-chain execution |
| oCOIN Token | `0x5B8F638330d7D6bD9D43811fe702F6894e97EF03` | In-game economy currency |
| OWB/USDC Aerodrome | `0x995985c9027e8a90c823a5e0a9112fea72d1f4dd` | Main DEX liquidity pool |
| OWB/USDC Uniswap V3 | `0xf252f51919dfca2c9c0ea279f11183580edee4d6` | Secondary DEX liquidity pool (0.01% fee, 100% locked) |

---

## ЦВЕТОВАЯ ПАЛИТРА (НОВЫЕ СЕКЦИИ)

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
| Cumulative Lines | Dark Orange | `#EA580C` |
| Background Accents | Dark variants of above |

---

## КАРТА РАСПОЛОЖЕНИЯ НОВЫХ ВИДЖЕТОВ

```
=====================================================================
  SECTION 3: BASE AGENTIC GAMING
=====================================================================

РЯД S3-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — Section 3 Header — на всю ширину]
          "Base Agentic Gaming: Where AI Agents Become Players"

РЯД S3-2: [5 КАУНТЕРОВ из Query 3.1]
          | Total Gaming Txs | Unique Players | Active Projects |
          | Weekly Gaming Txs | WoW Growth % |

РЯД S3-3: [ГРАФИК 3.1a — на всю ширину]
          Daily Agentic Gaming Activity (stacked bars by project + 7d MA line)

РЯД S3-4: [ГРАФИК 3.1b — 6 колонок]  [ГРАФИК 3.1c — 6 колонок]
          Daily Unique Players (area)    Cumulative Gaming Txs (line)

РЯД S3-5: [ТАБЛИЦА 3.2 — на всю ширину]
          Agentic Gaming Projects Comparison Table

РЯД S3-6: [ГРАФИК 3.2a — 8 колонок]  [ГРАФИК 3.2b — 4 колонки]
          Player Overlap Matrix (bar)    Tx Share Pie Chart

=====================================================================
  SECTION 4: OWB AGENTIC GAMING
=====================================================================

РЯД S4-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — Section 4 Header — на всю ширину]
          "OWB Agentic Gaming: GameAI Economy on Base"

РЯД S4-2: [3 КАУНТЕРА из Query 4.1 — MRR]
          | Monthly Revenue (OWB inflows) | Active Paying Addresses |
          | ARPU (Avg Revenue Per User) |

РЯД S4-3: [ГРАФИК 4.1a — 8 колонок]   [ГРАФИК 4.1b — 4 колонки]
          Monthly Revenue Trend (bars)    Revenue Source Breakdown (pie)

РЯД S4-4: [ТЕКСТ — "Bot / Agent Census"]

РЯД S4-5: [5 КАУНТЕРОВ из Query 4.2 — Bot Census]
          | Total Bots All-Time | Monthly Active Bots | Daily Active Bots |
          | New Bots (30d) | Avg Claims per Bot |

РЯД S4-6: [ГРАФИК 4.2a — 6 колонок]   [ГРАФИК 4.2b — 6 колонок]
          Daily Active Bots trend         New vs Returning Bots (stacked area)

РЯД S4-7: [ГРАФИК 4.2c — на всю ширину]
          Bot Activity Distribution (horizontal bars: frequency cohorts)

РЯД S4-8: [ТЕКСТ — "OWB Smart Contract Telemetry"]

РЯД S4-9: [4 КАУНТЕРА из Query 4.3]
          | Total Txs (30d) | Unique Addresses (30d) |
          | Avg Daily Txs | Avg Daily Volume USD |

РЯД S4-10: [ГРАФИК 4.3a — на всю ширину]
           Daily Transaction Activity (stacked by contract + 7d MA)

РЯД S4-11: [ГРАФИК 4.3b — 6 колонок]  [ГРАФИК 4.3c — 6 колонок]
           Tx Volume USD trend (bar+line)  Contract Activity Breakdown (pie)

РЯД S4-12: [ГРАФИК 4.3d — на всю ширину]
           Hourly Activity Heatmap (hour of day vs day of week)
```

---

---

# ТЕКСТОВЫЕ ВИДЖЕТЫ (Markdown)

---

### Text Widget S3: Section 3 Header (РЯД S3-1)

**Как добавить:** В режиме Edit нажми **"Add text widget"**, вставь текст ниже, растяни на всю ширину (12 колонок).

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

### Text Widget S4: Section 4 Header (РЯД S4-1)

**Текст (скопируй как есть):**

```markdown
---

## OWB Agentic Gaming: GameAI Economy on Base

**OWB (Clash of Coins)** is the first large-scale GameAI project on Base — #1 gaming app on Base with 30k+ DAU. OWB Studio is building Agentic-as-a-Service (AaaS): reasoning agents, hyper-personalized gameplay, autonomous on-chain economies, and the first agentic tournament with a $1M prize pool.

Below we track three core pillars of OWB's agentic economy:

| Pillar | What We Measure | Why It Matters |
|--------|----------------|---------------|
| **Revenue (MRR Proxy)** | Monthly OWB token inflows to game contracts, paying addresses | Monetization health — is the agentic economy generating real value? |
| **Bot / Agent Census** | Active bots, new onboarding, retention, activity distribution | Adoption depth — how many agents are actually participating? |
| **Smart Contract Telemetry** | Tx counts, volumes, contract-level breakdown, hourly patterns | Infrastructure load — how active is the on-chain layer? |

**Contracts monitored:** OWB Token, ClaimRewards, oCOIN, DEX pools (Aerodrome + Uniswap V3)

> OWB Token: `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` | [Aerodrome](https://aerodrome.finance) | [CoinMarketCap](https://coinmarketcap.com/currencies/owb/)
```

---

### Text Widget S4-Bot: Bot Census Sub-Header (РЯД S4-4)

**Текст:**

```markdown
### Bot / Agent Census

How many autonomous agents are active in the OWB ecosystem? Below we decompose the bot population by activity level, onboarding rate, and retention. Each "bot" is a unique wallet address that has interacted with OWB smart contracts (ClaimRewards, token transfers, or DEX trades).
```

---

### Text Widget S4-Telemetry: Smart Contract Telemetry Sub-Header (РЯД S4-8)

**Текст:**

```markdown
### OWB Smart Contract Telemetry

Raw infrastructure metrics across all OWB-related smart contracts on Base. This section answers: how much on-chain load does OWB generate, which contracts are most active, and what are the usage patterns by time of day?
```

---

---

# QUERY 3.1: Base Agentic Gaming — Ecosystem Pulse & Daily Activity

## Что он делает
Отслеживает совокупную активность всех известных проектов agentic gaming на Base: транзакции, уникальные игроки, ежедневная динамика с 7-дневными скользящими средними, кумулятивный рост. Показывает KPI-каунтеры + три графика.

## На какие вопросы отвечает
- Сколько всего транзакций и игроков в agentic gaming на Base?
- Какой тренд — растёт или стагнирует?
- Какой проект генерирует больше всего активности?
- Какова недельная динамика (WoW)?

## Название запроса при сохранении
`Base Agentic Gaming - Ecosystem Pulse`

## SQL-код

```sql
-- Base Agentic Gaming: Ecosystem Pulse & Daily Activity
-- Tracks all known agentic gaming contracts on Base
-- Uses base.transactions for tx counts + unique addresses

WITH gaming_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0x5e9e09b03d08017fddbc1652e9394e7cb4a24074, 'Last AI Standing'),
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
    WHERE t.block_time >= DATE '2025-01-01'
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
    WHERE t.block_time >= DATE '2025-01-01'
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

-- Current week
current_week AS (
    SELECT
        COUNT(*) AS week_txs,
        COUNT(DISTINCT t."from") AS week_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE_TRUNC('week', NOW())
      AND t.success = true
),

-- Previous week
prev_week AS (
    SELECT
        COUNT(*) AS prev_txs,
        COUNT(DISTINCT t."from") AS prev_players
    FROM base.transactions t
    INNER JOIN gaming_contracts gc ON t."to" = gc.address
    WHERE t.block_time >= DATE_TRUNC('week', NOW()) - INTERVAL '7' day
      AND t.block_time < DATE_TRUNC('week', NOW())
      AND t.success = true
),

-- Date spine for continuous chart
date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2025-01-01', CURRENT_DATE, INTERVAL '1' day)) AS t(day)
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
  AND wm.day >= DATE '2025-06-01'
ORDER BY wm.day ASC
```

## Как оформить визуализации

### 5 Каунтеров (РЯД S3-2)

Из этого запроса создай **5 Counter-визуализаций**. Используй последнюю строку результата.

| # | Заголовок | Колонка | Цвет | Ширина |
|---|-----------|---------|------|--------|
| 1 | **Total Agentic Gaming Txs** | `Total Gaming Txs` | Pink `#EC4899` | 2-3 колонки |
| 2 | **Unique Players** | `Unique Players All-Time` | Cyan `#06B6D4` | 2-3 колонки |
| 3 | **Active Projects (30d)** | `Active Projects (30d)` | Emerald `#10B981` | 2-3 колонки |
| 4 | **This Week Txs** | `This Week Txs` | Pink `#EC4899` | 2-3 колонки |
| 5 | **WoW Growth** | `WoW Growth %` | Green `#10B981` (если >0) / Red `#EF4444` (если <0) | 2-3 колонки |

### График 3.1a: Daily Gaming Activity (РЯД S3-3 — на всю ширину)

1. Тип: **Bar Chart** с наложением Line
2. **X-axis:** `day`
3. **Y-axis (бары):** `Daily Gaming Txs` — Pink `#EC4899`
4. **Y-axis (линия):** `Txs 7d MA` — тёмно-розовый `#BE185D`, пунктирная
5. Включи **Stacking** = OFF (одна серия)
6. **Ширина:** 12 колонок (полная ширина)
7. **Заголовок:** `Daily Agentic Gaming Transactions on Base`

### График 3.1b: Daily Unique Players (РЯД S3-4, левая половина)

1. Тип: **Area Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Daily Unique Players` — Cyan `#06B6D4`
4. **Ширина:** 6 колонок
5. **Заголовок:** `Daily Unique Players`

### График 3.1c: Cumulative Gaming Txs (РЯД S3-4, правая половина)

1. Тип: **Line Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Cumulative Gaming Txs` — Dark Pink `#BE185D`
4. **Ширина:** 6 колонок
5. **Заголовок:** `Cumulative Agentic Gaming Transactions`

---

---

# QUERY 3.2: Base Agentic Gaming — Projects Comparison

## Что он делает
Сравнительная таблица всех agentic gaming проектов на Base: транзакции за 30 дней, уникальные игроки, WoW-динамика, средний размер транзакции, доля от общей активности.

## На какие вопросы отвечает
- Какой agentic gaming проект самый активный?
- У кого больше уникальных игроков?
- Кто растёт быстрее?
- Какова доля каждого проекта в общей активности?

## Название запроса при сохранении
`Base Agentic Gaming - Projects Comparison`

## SQL-код

```sql
-- Base Agentic Gaming: Projects Comparison & Leaderboard
-- Compares all tracked agentic gaming projects on Base

WITH gaming_contracts AS (
    SELECT address, name, category FROM (
        VALUES
        (0x5e9e09b03d08017fddbc1652e9394e7cb4a24074, 'Last AI Standing', 'Survival'),
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

## Как оформить визуализации

### Таблица 3.2: Projects Comparison (РЯД S3-5 — на всю ширину)

1. Тип: **Table**
2. **Условное форматирование:**
   - `WoW Txs %`: зелёный если >0, красный если <0
   - `WoW Players %`: зелёный если >0, красный если <0
   - `Ecosystem Share %`: градиент от светлого к тёмному
3. Скрой колонки `First Seen`, `Last Active` (слишком детально)
4. **Ширина:** 12 колонок
5. **Заголовок:** `Agentic Gaming Projects on Base — 30-Day Comparison`

### График 3.2a: Transaction Breakdown by Project (РЯД S3-6, 8 колонок)

1. Тип: **Bar Chart** (горизонтальный)
2. **Y-axis:** `Project`
3. **X-axis:** `Txs (30d)` — Pink `#EC4899`
4. **Показать значения** на каждом баре
5. **Ширина:** 8 колонок
6. **Заголовок:** `Gaming Transactions by Project (30d)`

### График 3.2b: Ecosystem Share Pie (РЯД S3-6, 4 колонки)

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

# QUERY 4.1: OWB Agentic — MRR & Revenue Proxy

## Что он делает
Отслеживает месячные потоки OWB токенов в игровые контракты как прокси для MRR (Monthly Recurring Revenue). Считает:
- Совокупный месячный объём OWB, поступающий в экосистемные контракты
- Количество уникальных платящих адресов (подписчиков)
- ARPU (Average Revenue Per User) — средний доход на пользователя
- Разбивку источников дохода (ClaimRewards vs DEX vs direct transfers)

## На какие вопросы отвечает
- Сколько OWB "зарабатывает" экосистема ежемесячно?
- Растёт ли число платящих адресов?
- Какой средний чек на пользователя?
- Откуда идут основные потоки (claims, DEX, прямые переводы)?

## Название запроса при сохранении
`OWB Agentic - MRR Revenue Proxy`

## SQL-код

```sql
-- OWB Agentic: Monthly Revenue Proxy (MRR)
-- Tracks OWB token flows as revenue proxy
-- Sources: ClaimRewards events, OWB transfers to game contracts, DEX activity
-- OWB Token: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
-- ClaimRewards: 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
-- oCOIN: 0x5B8F638330d7D6bD9D43811fe702F6894e97EF03

WITH owb_ecosystem_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'ClaimRewards'),
        (0x5B8F638330d7D6bD9D43811fe702F6894e97EF03, 'oCOIN Contract')
    ) AS t(address, name)
),

-- 1) ClaimRewards activity: each claim = engagement + value distributed
claim_activity AS (
    SELECT
        DATE_TRUNC('month', t.block_time) AS month,
        'ClaimRewards' AS source,
        COUNT(*) AS tx_count,
        COUNT(DISTINCT t."from") AS unique_addresses,
        SUM(t.value / 1e18) AS eth_value
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.success = true
      AND t.block_time >= DATE '2025-01-01'
    GROUP BY 1
),

-- 2) OWB token transfers INTO ecosystem contracts (direct revenue)
owb_inflows AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        'OWB Inflows' AS source,
        COUNT(*) AS tx_count,
        COUNT(DISTINCT "from") AS unique_addresses,
        SUM(amount) AS owb_amount
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "to" IN (
          0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40,
          0x5B8F638330d7D6bD9D43811fe702F6894e97EF03
      )
      AND block_time >= DATE '2025-01-01'
    GROUP BY 1
),

-- 3) OWB DEX trading volume (market activity = ecosystem attention)
dex_activity AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        'DEX Trading' AS source,
        COUNT(*) AS tx_count,
        COUNT(DISTINCT taker) AS unique_addresses,
        SUM(amount_usd) AS volume_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= DATE '2025-01-01'
      AND amount_usd > 0
    GROUP BY 1
),

-- 4) OWB price for valuation
owb_price AS (
    SELECT
        DATE_TRUNC('month', block_time) AS month,
        SUM(amount_usd) / NULLIF(
            SUM(CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                THEN token_bought_amount
                WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                THEN token_sold_amount
                ELSE 0
            END), 0
        ) AS avg_owb_price
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= DATE '2025-01-01'
      AND amount_usd > 0
    GROUP BY 1
),

-- Combine all sources by month
monthly_combined AS (
    SELECT
        month,
        SUM(CASE WHEN source = 'ClaimRewards' THEN tx_count ELSE 0 END) AS claim_txs,
        SUM(CASE WHEN source = 'ClaimRewards' THEN unique_addresses ELSE 0 END) AS claim_users,
        SUM(CASE WHEN source = 'OWB Inflows' THEN tx_count ELSE 0 END) AS inflow_txs,
        SUM(CASE WHEN source = 'OWB Inflows' THEN unique_addresses ELSE 0 END) AS inflow_users,
        SUM(CASE WHEN source = 'DEX Trading' THEN tx_count ELSE 0 END) AS dex_txs,
        SUM(CASE WHEN source = 'DEX Trading' THEN unique_addresses ELSE 0 END) AS dex_traders,
        SUM(CASE WHEN source = 'DEX Trading' THEN volume_usd ELSE 0 END) AS dex_volume_usd,
        SUM(CASE WHEN source = 'OWB Inflows' THEN owb_amount ELSE 0 END) AS owb_inflow_amount,
        SUM(tx_count) AS total_txs,
        -- Deduplicated paying addresses across sources (approximation)
        GREATEST(
            SUM(CASE WHEN source = 'ClaimRewards' THEN unique_addresses ELSE 0 END),
            SUM(CASE WHEN source = 'OWB Inflows' THEN unique_addresses ELSE 0 END),
            SUM(CASE WHEN source = 'DEX Trading' THEN unique_addresses ELSE 0 END)
        ) AS active_paying_addresses
    FROM (
        SELECT month, source, tx_count, unique_addresses, 0 AS eth_value, 0 AS owb_amount, 0 AS volume_usd FROM claim_activity
        UNION ALL
        SELECT month, source, tx_count, unique_addresses, 0, owb_amount, 0 FROM owb_inflows
        UNION ALL
        SELECT month, source, tx_count, unique_addresses, 0, 0, volume_usd FROM dex_activity
    ) combined
    GROUP BY 1
)

SELECT
    mc.month,
    mc.claim_txs AS "Claim Transactions",
    mc.claim_users AS "Claim Users",
    mc.inflow_txs AS "OWB Inflow Txs",
    mc.inflow_users AS "OWB Inflow Users",
    mc.dex_txs AS "DEX Trades",
    mc.dex_traders AS "DEX Traders",
    ROUND(mc.dex_volume_usd, 2) AS "DEX Volume (USD)",
    ROUND(mc.owb_inflow_amount, 2) AS "OWB Inflows (tokens)",
    ROUND(mc.owb_inflow_amount * COALESCE(op.avg_owb_price, 0), 2) AS "OWB Inflows (USD)",
    mc.total_txs AS "Total Monthly Txs",
    mc.active_paying_addresses AS "Active Paying Addresses",
    -- MRR proxy = DEX volume + OWB inflows valued in USD
    ROUND(mc.dex_volume_usd + (mc.owb_inflow_amount * COALESCE(op.avg_owb_price, 0)), 2) AS "Monthly Revenue Proxy (USD)",
    -- ARPU = Monthly Revenue / Active Paying Addresses
    ROUND(
        (mc.dex_volume_usd + (mc.owb_inflow_amount * COALESCE(op.avg_owb_price, 0)))
        / NULLIF(mc.active_paying_addresses, 0),
        2
    ) AS "ARPU (USD)",
    ROUND(COALESCE(op.avg_owb_price, 0), 6) AS "Avg OWB Price (USD)",
    -- MoM growth
    ROUND(
        100.0 * (
            (mc.dex_volume_usd + (mc.owb_inflow_amount * COALESCE(op.avg_owb_price, 0)))
            - LAG(mc.dex_volume_usd + (mc.owb_inflow_amount * COALESCE(op.avg_owb_price, 0))) OVER (ORDER BY mc.month)
        ) / NULLIF(
            LAG(mc.dex_volume_usd + (mc.owb_inflow_amount * COALESCE(op.avg_owb_price, 0))) OVER (ORDER BY mc.month),
            0
        ),
        1
    ) AS "MoM Growth %"
FROM monthly_combined mc
LEFT JOIN owb_price op ON mc.month = op.month
ORDER BY mc.month ASC
```

## Как оформить визуализации

### 3 Каунтера MRR (РЯД S4-2)

Из последней строки (текущий или предыдущий полный месяц):

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **Monthly Revenue (MRR Proxy)** | `Monthly Revenue Proxy (USD)` | USD, 0 дес. | Emerald `#22C55E` | 4 колонки |
| 2 | **Active Paying Addresses** | `Active Paying Addresses` | Number | Cyan `#06B6D4` | 4 колонки |
| 3 | **ARPU** | `ARPU (USD)` | USD, 2 дес. | Amber `#F59E0B` | 4 колонки |

### График 4.1a: Monthly Revenue Trend (РЯД S4-3, 8 колонок)

1. Тип: **Bar Chart** с наложением Line
2. **X-axis:** `month`
3. **Y-axis (бары):** `Monthly Revenue Proxy (USD)` — Emerald `#22C55E`
4. **Y-axis (линия):** `Active Paying Addresses` (правая ось) — Cyan `#06B6D4`
5. **Ширина:** 8 колонок
6. **Заголовок:** `OWB Monthly Revenue Proxy (USD) & Active Addresses`

### График 4.1b: Revenue Source Breakdown (РЯД S4-3, 4 колонки)

Для этого графика создай **дополнительную визуализацию** из того же запроса, суммируя все месяцы:

1. Тип: **Pie Chart** (от последнего полного месяца)
2. **Слайсы:**
   - `DEX Volume (USD)` — Label: "DEX Trading" — Amber `#F59E0B`
   - `OWB Inflows (USD)` — Label: "Game Contract Inflows" — Emerald `#22C55E`
3. **Показать %**
4. **Ширина:** 4 колонки
5. **Заголовок:** `Revenue Sources (Latest Month)`

> **Как сделать:** Визуализацию Pie Chart проще всего сделать через отдельную визуализацию, где вручную указать 2 серии. Или можно создать отдельный query с `UNPIVOT`-логикой (см. альтернативный SQL ниже).

**Альтернативный SQL для Pie Chart (отдельный простой запрос):**

```sql
-- OWB Revenue Sources Breakdown (Latest Full Month)
WITH dex_rev AS (
    SELECT
        'DEX Trading' AS source,
        ROUND(SUM(amount_usd), 2) AS revenue_usd
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
claim_rev AS (
    SELECT
        'Rewards Claims' AS source,
        ROUND(COUNT(*) * 0.01, 2) AS revenue_usd -- proxy: each claim represents engagement value
    FROM base.transactions
    WHERE "to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND success = true
      AND block_time >= DATE_TRUNC('month', NOW()) - INTERVAL '1' month
      AND block_time < DATE_TRUNC('month', NOW())
),
inflow_rev AS (
    SELECT
        'OWB Token Inflows' AS source,
        ROUND(SUM(amount_usd), 2) AS revenue_usd
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND "to" IN (
          0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40,
          0x5B8F638330d7D6bD9D43811fe702F6894e97EF03
      )
      AND block_time >= DATE_TRUNC('month', NOW()) - INTERVAL '1' month
      AND block_time < DATE_TRUNC('month', NOW())
)
SELECT * FROM dex_rev
UNION ALL
SELECT * FROM claim_rev
UNION ALL
SELECT * FROM inflow_rev
ORDER BY revenue_usd DESC
```

---

---

# QUERY 4.2: OWB Bot / Agent Census

## Что он делает
Детальная перепись ботов/агентов в экосистеме OWB. Каждый уникальный адрес, взаимодействовавший с контрактами OWB = 1 "бот". Отслеживает:
- Total bots (all-time)
- Monthly Active Bots (MAB)
- Daily Active Bots (DAB)
- New vs Returning bots
- Средние claims per bot
- Распределение по активности (frequency cohorts)

## На какие вопросы отвечает
- Сколько ботов/агентов в экосистеме OWB?
- Сколько новых ботов приходит ежедневно?
- Какой процент ботов возвращается (retention)?
- Как распределена активность — много "одноразовых" или есть ядро постоянных?
- Сколько в среднем claims делает один бот?

## Название запроса при сохранении
`OWB Agentic - Bot Agent Census`

## SQL-код

```sql
-- OWB Agentic: Bot / Agent Census
-- Tracks unique wallet addresses as "bots" interacting with OWB ecosystem
-- Contracts: OWB Token transfers, ClaimRewards, oCOIN, DEX trades
-- OWB: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
-- ClaimRewards: 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
-- oCOIN: 0x5B8F638330d7D6bD9D43811fe702F6894e97EF03

WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40),
        (0x5B8F638330d7D6bD9D43811fe702F6894e97EF03)
    ) AS t(address)
),

-- All interactions: transactions TO owb contracts
all_interactions AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        t."from" AS bot_address
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE '2025-01-01'

    UNION ALL

    -- OWB token transfers (from/to)
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        "from" AS bot_address
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      AND block_time >= DATE '2025-01-01'

    UNION ALL

    -- DEX traders of OWB
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        taker AS bot_address
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= DATE '2025-01-01'
),

-- First seen per bot
first_seen AS (
    SELECT
        bot_address,
        MIN(day) AS first_day
    FROM all_interactions
    GROUP BY 1
),

-- Daily bot activity (deduplicated)
daily_bots AS (
    SELECT
        day,
        bot_address
    FROM all_interactions
    GROUP BY 1, 2
),

-- Classify bots per day
classified AS (
    SELECT
        db.day,
        db.bot_address,
        CASE
            WHEN db.day = fs.first_day THEN 'new'
            ELSE 'returning'
        END AS bot_type
    FROM daily_bots db
    INNER JOIN first_seen fs ON db.bot_address = fs.bot_address
),

-- Daily aggregated
daily_agg AS (
    SELECT
        day,
        COUNT(DISTINCT bot_address) AS daily_active_bots,
        COUNT(DISTINCT CASE WHEN bot_type = 'new' THEN bot_address END) AS new_bots,
        COUNT(DISTINCT CASE WHEN bot_type = 'returning' THEN bot_address END) AS returning_bots
    FROM classified
    GROUP BY 1
),

-- Date spine
date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2025-01-01', CURRENT_DATE, INTERVAL '1' day)) AS t(day)
),

-- Fill gaps
daily_filled AS (
    SELECT
        ds.day,
        COALESCE(da.daily_active_bots, 0) AS daily_active_bots,
        COALESCE(da.new_bots, 0) AS new_bots,
        COALESCE(da.returning_bots, 0) AS returning_bots
    FROM date_spine ds
    LEFT JOIN daily_agg da ON ds.day = da.day
),

-- With MAs and cumulative
with_metrics AS (
    SELECT
        day,
        daily_active_bots AS "Daily Active Bots",
        new_bots AS "New Bots",
        returning_bots AS "Returning Bots",
        ROUND(AVG(daily_active_bots) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "DAB 7d MA",
        SUM(new_bots) OVER (ORDER BY day) AS "Cumulative Bots (All-Time)",
        -- 30-day window active bots
        SUM(daily_active_bots) OVER (ORDER BY day ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS "Monthly Active Window",
        -- Retention proxy: returning / (returning + new) over 7d
        ROUND(
            100.0 * SUM(returning_bots) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
            / NULLIF(SUM(returning_bots + new_bots) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0),
            1
        ) AS "7d Retention Rate %"
    FROM daily_filled
),

-- KPIs
kpi_total_bots AS (
    SELECT COUNT(DISTINCT bot_address) AS total_bots_alltime
    FROM all_interactions
),
kpi_mab AS (
    SELECT COUNT(DISTINCT bot_address) AS monthly_active_bots
    FROM all_interactions
    WHERE day >= CURRENT_DATE - INTERVAL '30' day
),
kpi_dab AS (
    SELECT COUNT(DISTINCT bot_address) AS today_active_bots
    FROM all_interactions
    WHERE day = CURRENT_DATE - INTERVAL '1' day
),
kpi_new_30d AS (
    SELECT COUNT(DISTINCT bot_address) AS new_bots_30d
    FROM first_seen
    WHERE first_day >= CURRENT_DATE - INTERVAL '30' day
),
-- Avg claims per bot (ClaimRewards specific)
avg_claims AS (
    SELECT
        ROUND(CAST(COUNT(*) AS DOUBLE) / NULLIF(COUNT(DISTINCT t."from"), 0), 1) AS avg_claims_per_bot
    FROM base.transactions t
    WHERE t."to" = 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
      AND t.success = true
      AND t.block_time >= CURRENT_DATE - INTERVAL '30' day
)

SELECT
    wm.day,
    wm."Daily Active Bots",
    wm."New Bots",
    wm."Returning Bots",
    wm."DAB 7d MA",
    wm."Cumulative Bots (All-Time)",
    wm."7d Retention Rate %",
    -- KPI values (same per row for counters)
    kb.total_bots_alltime AS "Total Bots All-Time",
    km.monthly_active_bots AS "Monthly Active Bots",
    kd.today_active_bots AS "Daily Active Bots (yesterday)",
    kn.new_bots_30d AS "New Bots (30d)",
    ac.avg_claims_per_bot AS "Avg Claims per Bot (30d)"
FROM with_metrics wm
CROSS JOIN kpi_total_bots kb
CROSS JOIN kpi_mab km
CROSS JOIN kpi_dab kd
CROSS JOIN kpi_new_30d kn
CROSS JOIN avg_claims ac
WHERE wm.day < CURRENT_DATE
  AND wm.day >= DATE '2025-06-01'
ORDER BY wm.day ASC
```

## Как оформить визуализации

### 5 Каунтеров Bot Census (РЯД S4-5)

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **Total Bots (All-Time)** | `Total Bots All-Time` | Number | Orange `#F97316` | 2-3 кол. |
| 2 | **Monthly Active Bots** | `Monthly Active Bots` | Number | Cyan `#06B6D4` | 2-3 кол. |
| 3 | **Daily Active Bots** | `Daily Active Bots (yesterday)` | Number | Pink `#EC4899` | 2-3 кол. |
| 4 | **New Bots (30d)** | `New Bots (30d)` | Number | Emerald `#10B981` | 2-3 кол. |
| 5 | **Avg Claims / Bot** | `Avg Claims per Bot (30d)` | Number (1 decimal) | Amber `#F59E0B` | 2-3 кол. |

### График 4.2a: Daily Active Bots Trend (РЯД S4-6, 6 колонок)

1. Тип: **Area Chart**
2. **X-axis:** `day`
3. **Y-axis:** `Daily Active Bots` — Cyan `#06B6D4` (area)
4. **Наложение линии:** `DAB 7d MA` — Dark Cyan `#0E7490` (line, dashed)
5. **Ширина:** 6 колонок
6. **Заголовок:** `OWB Daily Active Bots`

### График 4.2b: New vs Returning Bots (РЯД S4-6, 6 колонок)

1. Тип: **Stacked Area Chart**
2. **X-axis:** `day`
3. **Y-axis (stacked):**
   - `New Bots` — Emerald `#10B981`
   - `Returning Bots` — Orange `#F97316`
4. **Stacking:** ON
5. **Ширина:** 6 колонок
6. **Заголовок:** `New vs Returning Bots`

### График 4.2c: Bot Activity Distribution (РЯД S4-7 — на всю ширину)

> **Для этого графика нужен отдельный мини-запрос** (или дополнительная визуализация). SQL ниже:

**Дополнительный мини-запрос (отдельный):**

Название: `OWB Agentic - Bot Activity Distribution`

```sql
-- OWB: Bot Activity Distribution (Frequency Cohorts)
-- How many times did each bot interact in the last 30 days?

WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40),
        (0x5B8F638330d7D6bD9D43811fe702F6894e97EF03)
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

**Визуализация 4.2c:**

1. Тип: **Horizontal Bar Chart**
2. **Y-axis:** `Activity Cohort`
3. **X-axis:** `Number of Bots` — Cyan `#06B6D4`
4. **Data Labels:** показать `% of All Bots` на каждом баре
5. **Ширина:** 12 колонок
6. **Заголовок:** `Bot Activity Distribution (30d) — Who Are The Most Active Agents?`

---

---

# QUERY 4.3: OWB Transaction Activity — Smart Contract Telemetry

## Что он делает
Детальная транзакционная телеметрия всех OWB-связанных смарт-контрактов на Base. Показывает:
- Ежедневные транзакции по контракту
- Объём в USD (для DEX) и ETH (для прямых tx)
- Уникальные адреса
- Почасовой heatmap активности
- 7d MA

## На какие вопросы отвечает
- Какой контракт OWB самый активный?
- Какова ежедневная нагрузка на инфраструктуру?
- В какое время суток пик активности?
- Какой средний ежедневный объём торговли OWB?

## Название запроса при сохранении
`OWB Agentic - Transaction Telemetry`

## SQL-код

```sql
-- OWB Agentic: Smart Contract Transaction Telemetry
-- Tracks all transaction activity across OWB ecosystem contracts
-- OWB Token: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
-- ClaimRewards: 0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40
-- oCOIN: 0x5B8F638330d7D6bD9D43811fe702F6894e97EF03

WITH owb_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'ClaimRewards'),
        (0x5B8F638330d7D6bD9D43811fe702F6894e97EF03, 'oCOIN')
    ) AS t(address, name)
),

-- Daily transaction metrics per contract
daily_per_contract AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        oc.name AS contract_name,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT t."from") AS daily_addresses,
        SUM(t.value / 1e18) AS daily_eth_volume,
        SUM(t.gas_used * t.gas_price / 1e18) AS daily_gas_eth
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= DATE '2025-01-01'
    GROUP BY 1, 2
),

-- DEX volume for OWB (separate because it's from dex.trades, not base.transactions)
daily_dex AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        'DEX (OWB Pairs)' AS contract_name,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT taker) AS daily_addresses,
        SUM(amount_usd) AS daily_volume_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= DATE '2025-01-01'
      AND amount_usd > 0
    GROUP BY 1
),

-- Combine both sources
all_daily AS (
    SELECT day, contract_name, daily_txs, daily_addresses, 0.0 AS daily_volume_usd
    FROM daily_per_contract
    UNION ALL
    SELECT day, contract_name, daily_txs, daily_addresses, daily_volume_usd
    FROM daily_dex
),

-- Daily totals (aggregated across all contracts)
daily_totals AS (
    SELECT
        day,
        SUM(daily_txs) AS total_txs,
        SUM(daily_addresses) AS total_addresses_raw,
        SUM(daily_volume_usd) AS total_volume_usd
    FROM all_daily
    GROUP BY 1
),

-- Date spine
date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2025-01-01', CURRENT_DATE, INTERVAL '1' day)) AS t(day)
),

-- Filled daily totals
daily_filled AS (
    SELECT
        ds.day,
        COALESCE(dt.total_txs, 0) AS total_txs,
        COALESCE(dt.total_addresses_raw, 0) AS total_addresses,
        COALESCE(dt.total_volume_usd, 0) AS total_volume_usd
    FROM date_spine ds
    LEFT JOIN daily_totals dt ON ds.day = dt.day
),

-- With MAs
with_ma AS (
    SELECT
        day,
        total_txs AS "Daily Txs (All Contracts)",
        total_addresses AS "Daily Unique Addresses",
        ROUND(total_volume_usd, 2) AS "Daily DEX Volume (USD)",
        ROUND(AVG(total_txs) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "Txs 7d MA",
        ROUND(AVG(total_volume_usd) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS "Volume 7d MA (USD)",
        SUM(total_txs) OVER (ORDER BY day) AS "Cumulative Txs"
    FROM daily_filled
),

-- KPIs (30d)
kpi_30d AS (
    SELECT
        SUM(total_txs) AS txs_30d,
        ROUND(AVG(total_txs), 0) AS avg_daily_txs,
        ROUND(SUM(total_volume_usd), 2) AS volume_30d_usd,
        ROUND(AVG(total_volume_usd), 2) AS avg_daily_volume_usd
    FROM daily_filled
    WHERE day >= CURRENT_DATE - INTERVAL '30' day
      AND day < CURRENT_DATE
),
kpi_unique AS (
    SELECT COUNT(DISTINCT t."from") AS unique_addr_30d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= NOW() - INTERVAL '30' day
)

SELECT
    wm.day,
    wm."Daily Txs (All Contracts)",
    wm."Daily Unique Addresses",
    wm."Daily DEX Volume (USD)",
    wm."Txs 7d MA",
    wm."Volume 7d MA (USD)",
    wm."Cumulative Txs",
    -- KPIs
    k.txs_30d AS "Total Txs (30d)",
    ku.unique_addr_30d AS "Unique Addresses (30d)",
    k.avg_daily_txs AS "Avg Daily Txs",
    k.avg_daily_volume_usd AS "Avg Daily Volume (USD)"
FROM with_ma wm
CROSS JOIN kpi_30d k
CROSS JOIN kpi_unique ku
WHERE wm.day < CURRENT_DATE
  AND wm.day >= DATE '2025-06-01'
ORDER BY wm.day ASC
```

## Дополнительный запрос: Contract Activity Breakdown (для Pie Chart)

Название: `OWB Agentic - Contract Activity Breakdown`

```sql
-- OWB: Activity Breakdown by Contract (30d)
WITH owb_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1, 'OWB Token'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'ClaimRewards'),
        (0x5B8F638330d7D6bD9D43811fe702F6894e97EF03, 'oCOIN')
    ) AS t(address, name)
),

contract_metrics AS (
    SELECT
        oc.name AS "Contract",
        COUNT(*) AS "Transactions (30d)",
        COUNT(DISTINCT t."from") AS "Unique Addresses",
        ROUND(SUM(t.value / 1e18), 4) AS "ETH Volume",
        ROUND(SUM(t.gas_used * t.gas_price / 1e18), 4) AS "Gas Spent (ETH)",
        ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS "Tx Share %"
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.success = true
      AND t.block_time >= NOW() - INTERVAL '30' day
    GROUP BY 1
)

SELECT * FROM contract_metrics

UNION ALL

-- Add DEX row
SELECT
    'DEX (OWB Pairs)' AS "Contract",
    COUNT(*) AS "Transactions (30d)",
    COUNT(DISTINCT taker) AS "Unique Addresses",
    0 AS "ETH Volume",
    0 AS "Gas Spent (ETH)",
    0 AS "Tx Share %"  -- will recalculate visually
FROM dex.trades
WHERE blockchain = 'base'
  AND (
      token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
  )
  AND block_time >= NOW() - INTERVAL '30' day
  AND amount_usd > 0

ORDER BY "Transactions (30d)" DESC
```

## Дополнительный запрос: Hourly Activity Heatmap

Название: `OWB Agentic - Hourly Activity Heatmap`

```sql
-- OWB: Hourly Activity Heatmap (Last 30 Days)
-- Shows when OWB ecosystem is most active (hour x day of week)

WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40),
        (0x5B8F638330d7D6bD9D43811fe702F6894e97EF03)
    ) AS t(address)
)

SELECT
    HOUR(t.block_time) AS "Hour (UTC)",
    CASE DAY_OF_WEEK(t.block_time)
        WHEN 1 THEN 'Mon'
        WHEN 2 THEN 'Tue'
        WHEN 3 THEN 'Wed'
        WHEN 4 THEN 'Thu'
        WHEN 5 THEN 'Fri'
        WHEN 6 THEN 'Sat'
        WHEN 7 THEN 'Sun'
    END AS "Day of Week",
    DAY_OF_WEEK(t.block_time) AS day_num,
    COUNT(*) AS "Transactions",
    COUNT(DISTINCT t."from") AS "Unique Addresses"
FROM base.transactions t
INNER JOIN owb_contracts oc ON t."to" = oc.address
WHERE t.success = true
  AND t.block_time >= NOW() - INTERVAL '30' day
GROUP BY 1, 2, 3
ORDER BY 3, 1
```

## Как оформить визуализации

### 4 Каунтера Telemetry (РЯД S4-9)

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **Total Txs (30d)** | `Total Txs (30d)` | Number | Orange `#F97316` | 3 кол. |
| 2 | **Unique Addresses (30d)** | `Unique Addresses (30d)` | Number | Cyan `#06B6D4` | 3 кол. |
| 3 | **Avg Daily Txs** | `Avg Daily Txs` | Number | Pink `#EC4899` | 3 кол. |
| 4 | **Avg Daily Volume** | `Avg Daily Volume (USD)` | USD, 0 дес. | Amber `#F59E0B` | 3 кол. |

### График 4.3a: Daily Transaction Activity (РЯД S4-10 — на всю ширину)

1. Тип: **Bar Chart** с наложением Line
2. **X-axis:** `day`
3. **Y-axis (бары):** `Daily Txs (All Contracts)` — Orange `#F97316`
4. **Y-axis (линия):** `Txs 7d MA` — Dark Orange `#EA580C`, пунктирная
5. **Ширина:** 12 колонок
6. **Заголовок:** `OWB Daily Transaction Activity (All Contracts)`

### График 4.3b: DEX Volume Trend (РЯД S4-11, 6 колонок)

1. Тип: **Bar Chart + Line**
2. **X-axis:** `day`
3. **Y-axis (бары):** `Daily DEX Volume (USD)` — Amber `#F59E0B`
4. **Y-axis (линия):** `Volume 7d MA (USD)` — Dark Amber `#D97706`
5. **Ширина:** 6 колонок
6. **Заголовок:** `OWB DEX Volume (USD)`

### График 4.3c: Contract Activity Breakdown (РЯД S4-11, 6 колонок)

Из отдельного запроса `OWB Agentic - Contract Activity Breakdown`:

1. Тип: **Pie Chart**
2. **Labels:** `Contract`
3. **Values:** `Transactions (30d)`
4. **Цвета:**
   - OWB Token: `#F97316`
   - ClaimRewards: `#22C55E`
   - oCOIN: `#06B6D4`
   - DEX (OWB Pairs): `#F59E0B`
5. **Показать %**
6. **Ширина:** 6 колонок
7. **Заголовок:** `Activity by Contract (30d)`

### График 4.3d: Hourly Activity Heatmap (РЯД S4-12 — на всю ширину)

Из отдельного запроса `OWB Agentic - Hourly Activity Heatmap`:

1. Тип: **Heatmap** (или Pivot Table с цветом)
2. **X-axis:** `Hour (UTC)` (0-23)
3. **Y-axis:** `Day of Week` (Mon-Sun)
4. **Values / Color:** `Transactions`
5. **Color scale:** от светло-оранжевого к тёмно-оранжевому
6. **Ширина:** 12 колонок
7. **Заголовок:** `OWB Activity Heatmap — When Are Agents Most Active? (UTC)`

> **Примечание:** Dune поддерживает heatmap через Pivot Table visualization. Выбери тип "Pivot", поставь Row = `Day of Week`, Column = `Hour (UTC)`, Value = `Transactions`, цветовая шкала = Orange.

---

---

# ИТОГО: ПОЛНЫЙ СПИСОК ЗАПРОСОВ

| # | Название в Dune | Section | Тип визуализации |
|---|----------------|---------|------------------|
| 3.1 | `Base Agentic Gaming - Ecosystem Pulse` | Section 3 | 5 Counter + Bar+Line + Area + Line |
| 3.2 | `Base Agentic Gaming - Projects Comparison` | Section 3 | Table + Horizontal Bar + Pie |
| 4.1 | `OWB Agentic - MRR Revenue Proxy` | Section 4 | 3 Counter + Bar+Line + Pie |
| 4.1b | `OWB Revenue Sources Breakdown` (опционально, для Pie) | Section 4 | Pie |
| 4.2 | `OWB Agentic - Bot Agent Census` | Section 4 | 5 Counter + Area + Stacked Area |
| 4.2b | `OWB Agentic - Bot Activity Distribution` | Section 4 | Horizontal Bar |
| 4.3 | `OWB Agentic - Transaction Telemetry` | Section 4 | 4 Counter + Bar+Line + Bar+Line |
| 4.3b | `OWB Agentic - Contract Activity Breakdown` | Section 4 | Pie (+ Table) |
| 4.3c | `OWB Agentic - Hourly Activity Heatmap` | Section 4 | Heatmap / Pivot |

**Основных queries: 5** (3.1, 3.2, 4.1, 4.2, 4.3)
**Дополнительных мини-queries: 4** (4.1b, 4.2b, 4.3b, 4.3c)

---

# ОБНОВЛЕНИЕ TABLE OF CONTENTS (WIDGET 0)

Обнови оглавление в верхнем text widget, добавив 2 новые строки:

```markdown
| Section | What You'll Find | Row |
|---------|-----------------|-----|
| **Ecosystem Pulse** | 6 KPIs: Total Txs, Unique Addresses, ERC-8004 Agents, Weekly dynamics, Infra vs Consumer | 2-3 |
| **Cross-Pollination Index** | Network effect: Power Users (3+ projects), Avg Projects per User, Single-Project % | 4 |
| **Daily Activity** | Daily transaction trends across all tracked projects (area chart) | 5 |
| **Leaderboard** | Top projects ranked by Activity Score (55% Txs + 45% Users) with WoW momentum | 6-7 |
| **ERC-8004 Registry** | Agent identity registrations: daily growth, creator concentration, total agents | 8-10 |
| **Virtuals Protocol** | Deep dive: token economics, trading activity, agent token health | 11-13 |
| **Base vs Solana** | Head-to-head: DEX volume, traders, avg trade size, growth dynamics | 14-16 |
| **Base Agentic Gaming** | Emerging agentic gaming on Base: daily activity, players, project comparison | 17-22 |
| **OWB Agentic Gaming** | OWB deep dive: MRR proxy, bot census (5 metrics), transaction telemetry, heatmap | 23-34 |
| **Methodology** | Definitions, inclusion criteria, Activity Score formula, known limitations | Bottom |
```

---

# ОБНОВЛЕНИЕ МЕТОДОЛОГИИ (FOOTER)

Добавь в конец секции Methodology следующий текст:

```markdown
#### Section 3: Base Agentic Gaming

We track the emerging category of **games designed for AI agents** on Base. These are arenas where autonomous agents compete with real tokens and verifiable on-chain logic. The category is in early/launch stage — we include projects that have:

1. A deployed smart contract on Base with measurable gaming activity
2. Agent-first design (agents are the primary participants, not humans)
3. On-chain settlement (prizes, survival payments, or battle outcomes)

**Tracked projects:** Last AI Standing (USDC survival game), Agent Royale (ETH battle competition), Clash of Coins (first $1M agentic tournament).

#### Section 4: OWB Agentic Gaming

OWB (Clash of Coins) metrics are tracked across four on-chain data sources:

| Data Source | What We Capture | Table |
|-------------|----------------|-------|
| Direct transactions to OWB contracts | Tx counts, addresses, gas | `base.transactions` |
| OWB token transfers | Token flows, inflows to game contracts | `tokens.transfers` |
| DEX trading activity | Volume (USD), traders, trades | `dex.trades` |
| ClaimRewards events | Claim frequency, unique claimers | `base.transactions` (to ClaimRewards address) |

**MRR Proxy:** Monthly Recurring Revenue is approximated as the sum of DEX trading volume + OWB token inflows to game contracts valued at monthly average price. This is a proxy — actual subscription revenue may include off-chain components not captured on-chain.

**Bot Census:** Each unique wallet address that interacts with any OWB contract is counted as one "bot." This includes human wallets — we cannot distinguish between human users and AI agents on-chain. The term "bot" is used in the gaming context of OWB's agentic tournament design.

**Known limitations:**
- Off-chain game activity (gameplay sessions, AI inference, matchmaking) is not captured
- Subscription payments may occur off-chain
- "Bot" count includes human wallets — no on-chain distinction possible
- MRR proxy is a lower bound — actual revenue likely higher due to off-chain monetization
```

---

# ВАЖНЫЕ ПРИМЕЧАНИЯ

## Как добавить новый agentic gaming проект (Section 3)

1. Найди контракт проекта на BaseScan
2. Добавь адрес в `gaming_contracts` CTE в Queries 3.1 и 3.2
3. Добавь описание в текстовый виджет Section 3
4. Обнови методологию

## Если запрос выдаёт ошибку

1. **Адреса контрактов:** DuneSQL использует адреса как varbinary с префиксом `0x`. Если ошибка — попробуй обернуть: `FROM_HEX('...')`.

2. **Таблицы:** Используй `base.transactions` для прямых tx, `dex.trades` для DEX, `tokens.transfers` (с `WHERE blockchain = 'base'`) для ERC20 трансферов.

3. **Производительность:** Если запрос медленный — убедись что есть фильтр по дате (`AND t.block_time >= DATE '2025-01-01'`).

4. **DAY_OF_WEEK / HOUR:** Это функции DuneSQL (Trino). Если ошибка — попробуй `EXTRACT(DOW FROM t.block_time)` и `EXTRACT(HOUR FROM t.block_time)`.

5. **Heatmap:** Если Dune не поддерживает прямой heatmap — используй Pivot Table visualization с цветовой шкалой.

## Порядок создания на Dune

1. Создай Query 3.1 → Run → Save → New visualization (5 counters + 3 графика)
2. Создай Query 3.2 → Run → Save → New visualization (table + bar + pie)
3. Создай Query 4.1 → Run → Save → New visualization (3 counters + bar+line)
4. Создай Query 4.1b (опционально) → Run → Save → Pie chart
5. Создай Query 4.2 → Run → Save → New visualization (5 counters + area + stacked area)
6. Создай Query 4.2b → Run → Save → Horizontal bar
7. Создай Query 4.3 → Run → Save → New visualization (4 counters + bar+line + bar+line)
8. Создай Query 4.3b → Run → Save → Pie chart
9. Создай Query 4.3c → Run → Save → Heatmap/Pivot
10. Добавь text widgets (S3, S4 headers + sub-headers)
11. Расположи всё на дашборде по карте выше
12. Обнови Table of Contents
13. Обнови Methodology

---

*Документ создан: 4 марта 2026*
*Отслеживаемые контракты: OWB, ClaimRewards, oCOIN, Last AI Standing, Agent Royale*
*Формат: DuneSQL (Trino-based)*
