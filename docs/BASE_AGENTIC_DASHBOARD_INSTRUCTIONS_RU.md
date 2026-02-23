# ДАШБОРД BASE AGENTIC ECOSYSTEM - Полная Инструкция

> **Название дашборда:** `Base Agentic: The Birth of AI Economy`
> **Поддерживается:** AX1 Community ([Twitter](https://twitter.com/AX1ecosystem))

---

## ОБЩАЯ СТРУКТУРА

Дашборд состоит из **1 блока: Base Agentic** (максимум 5 queries), разделённого на:
- **Infrastructure / Фундаментальные** (Virtuals Protocol, Spectral, Clanker, Venice, AIXBT)
- **Consumer / Самостоятельные агенты** (AWE, FAI, VADER, CLAWD, Bankr, Ribbita)

**Контракт ERC-8004 (реестр агентов):** `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432`

---

## ЧТО ТЕБЕ НУЖНО СДЕЛАТЬ (ШАГ ЗА ШАГОМ)

---

### ШАГ 1: Создать дашборд

1. Зайди на https://dune.com
2. Нажми **"New"** -> **"Dashboard"**
3. Назови его: `Base Agentic: The Birth of AI Economy`
4. Поставь **Public**

---

### ШАГ 2: Создать 5 Queries (запросов)

Для каждого запроса ниже:
1. Нажми **"New"** -> **"Query"**
2. Вставь SQL-код
3. Нажми **"Run"** чтобы проверить
4. Сохрани с названием, которое я указываю

---

### ШАГ 3: Добавить виджеты на дашборд

После создания каждого запроса:
1. Открой свой дашборд
2. Нажми **"Edit"**
3. Нажми **"Add visualization"** и найди свой сохранённый запрос
4. Настрой визуализацию (тип графика, цвета, оси) как описано ниже
5. Перетащи и расположи виджеты по макету

---

## КАРТА РАСПОЛОЖЕНИЯ ВИДЖЕТОВ НА ДАШБОРДЕ

```
РЯД 1:  [ТЕКСТ-ЗАГОЛОВОК - на всю ширину]
         "Base Agentic: The Birth of AI Economy" + описание + кредит AX1

РЯД 2:  [6 КАУНТЕРОВ из Запроса 1]
         | Всего Txs YTD | Уникальные Адреса | 8004 Агенты | Недельные Txs | Недельные Users | Infra/Consumer |

РЯД 3:  [ГРАФИК 2a - на всю ширину]
         Ежедневные транзакции - стакнутые бары + линии 7d MA (Infra vs Consumer)

РЯД 4:  [ГРАФИК 2b - левая половина]  [ГРАФИК 2c - правая половина]
         Ежедневные активные адреса      Кумулятивные транзакции

РЯД 5:  [ТЕКСТ-РАЗДЕЛИТЕЛЬ - "Top Agentic Projects Leaderboard"]

РЯД 6:  [ТАБЛИЦА 3a - на всю ширину]
         Таблица рейтинга проектов

РЯД 7:  [ГРАФИК 3b - 8 колонок слева]  [ГРАФИК 3c - 4 колонки справа]
         Activity Score Breakdown (stacked)     Pie Chart доли транзакций

РЯД 8:  [ГРАФИК 3d - на всю ширину]
         WoW Growth Bars (зелёные/красные горизонтальные бары)

РЯД 9:  [ТЕКСТ-РАЗДЕЛИТЕЛЬ - "ERC-8004 Agent Registry"]

РЯД 10: [3 КАУНТЕРА: Всего Агентов / Уникальные Создатели / Доля Топ-30]

РЯД 11: [ГРАФИК 4a - 8 колонок]  [ГРАФИК 4b - 4 колонки]
         Ежедневные регистрации + кумулятив    Концентрация создателей

РЯД 12: [ТЕКСТ-РАЗДЕЛИТЕЛЬ - "Virtuals Protocol Deep Dive"]

РЯД 13: [ГРАФИК 5a - левая половина]  [ГРАФИК 5b - правая половина]
         DEX Volume VIRTUAL                    Уникальные трейдеры

РЯД 14: [ГРАФИК 5c - левая половина]  [ГРАФИК 5d - правая половина]
         Рост получателей                      DEX Trading Activity

РЯД 15: [ТЕКСТ-ФУТЕР - на всю ширину]
         Методология и источники данных
```

---

## ЦВЕТОВАЯ ПАЛИТРА

| Элемент | Цвет | HEX |
|---------|-------|-----|
| Infrastructure | Синий | `#3B82F6` |
| Consumer/Агенты | Фиолетовый | `#8B5CF6` |
| ERC-8004 / Рост | Зелёный | `#10B981` |
| Объём/Деньги | Янтарный/Золотой | `#F59E0B` |
| Кумулятивные линии | Тёмные варианты | `#1E40AF`, `#6D28D9` |
| Падение/Негатив | Красный | `#EF4444` |

---

## ТЕКСТОВЫЕ ВИДЖЕТЫ (Markdown)

### Виджет 1: Заголовок дашборда (РЯД 1)

**Как добавить:** В режиме Edit нажми **"Add text widget"**, вставь текст ниже, растяни на всю ширину (12 колонок).

**Текст (скопируй как есть):**

```markdown
# Base Agentic: Telemetry for an Emerging AI Economy

**A telemetry dashboard for Base agentic activity** — starting with identity and infrastructure, then tracking verifiable autonomy and onchain commerce signals as they become measurable.

We are observing the birth of a market. The first signals are identity registrations (ERC-8004), token launchpad activity (Virtuals, Clanker), and early agent-adjacent tooling (Venice, Bankr). True autonomous onchain commerce (x402, agent-to-agent transactions) is not yet measurable at scale — the moment it is, it will appear here.

**What this dashboard tracks:**
- **Identity:** ERC-8004 agent registrations — how fast is "agentic citizenship" growing?
- **Infrastructure:** DEX activity around agent-adjacent tokens — where does capital flow first?
- **Adoption signals:** Unique users, cross-project overlap, week-over-week momentum
- **Concentration risk:** Creator distribution, supply concentration, organic vs synthetic growth

> Supported by [AX1 Community](https://twitter.com/AX1ecosystem) | Data: 2026 YTD | Updated weekly
```

---

### Виджет 2: Разделитель перед Leaderboard (РЯД 5)

**Текст:**

```markdown
---

## Top Agentic Projects Leaderboard

Which protocols are driving real onchain activity? This leaderboard ranks tracked projects by a composite **Activity Score** over the last 30 days.

**Activity Score formula:** `40% Transactions (normalized) + 35% Unique Users (normalized) + 25% ETH Volume (normalized)`. Each component is normalized against the top performer (max = 100). A project scoring 80 has 80% of the leading project's composite activity.

**Important context:** Most projects tracked here are agent-adjacent infrastructure, not autonomous agents themselves. See Methodology at the bottom for inclusion criteria and what "agentic" means in this context.
```

---

### Виджет 3: Разделитель перед ERC-8004 (РЯД 8)

**Текст:**

```markdown
---

## ERC-8004 Agent Registry: Onchain Citizenship

ERC-8004 is the onchain identity standard for AI agents. Every registration is a deliberate act of "claiming existence" on Base. Below we track new agent registrations, creator concentration, and the growth of this digital nation.

> "This isn't about counting transactions - it's about witnessing the birth of agentic citizenship."
```

---

### Виджет 4: Разделитель перед Virtuals (РЯД 11)

**Текст:**

```markdown
---

## Virtuals Protocol: The Engine of Base Agentic Infrastructure

Virtuals Protocol is the largest AI agent launchpad on Base. Below we analyze its token economics, trading activity, and the health of agent tokens launched through Virtuals. This is the pulse of Base's agentic infrastructure.
```

---

### Виджет 5: Футер дашборда (РЯД 14)

**Текст:**

```markdown
---

### Methodology, Definitions & Data Sources

#### What do we mean by "Agentic"?

In early 2026, no token project on any chain represents a fully autonomous AI agent executing onchain commerce independently. What we track is the **agentic ecosystem** — the infrastructure, tooling, and token-economic layer being built around the thesis that AI agents will transact onchain. This includes:

- **Launchpads** that create agent tokens (Virtuals, Clanker)
- **Inference/tooling** that agents will use (Venice LLM, Spectral)
- **Identity standards** that give agents onchain existence (ERC-8004)
- **Bot-adjacent tokens** whose communities test agent-like behaviors (CLAWD, Bankr, AIXBT)
- **Consumer experiments** exploring agent token economics (AWE, FAI, VADER, Ribbita)

We are deliberately tracking the **pre-agentic infrastructure buildout**. The moment verifiable autonomous commerce (x402 payments, agent-to-agent swaps) becomes measurable, those metrics will be added.

#### Project Classification

| Project | What It Actually Is | Why It's Tracked | Category |
|---------|-------------------|-----------------|----------|
| Virtuals Protocol | AI agent token launchpad | Largest agent token factory on Base | Infrastructure |
| Clanker | Token launch infrastructure | Enables rapid agent-adjacent token creation | Infrastructure |
| Spectral | Onchain ML / autonomous agent infra | Closest to true agent autonomy tooling | Infrastructure |
| Venice | Privacy-preserving LLM | Core inference layer for future agents | Infrastructure |
| AIXBT | AI-driven market analysis token | Narrative agent with real following | Infrastructure |
| AWE | AI entertainment agent | Consumer agent experiment | Consumer |
| FAI | Community agent token | Consumer agent experiment | Consumer |
| VADER | Agent-themed community token | Consumer agent token economics | Consumer |
| CLAWD | Viral bot / social agent | Bot-driven token with high activity | Consumer |
| Bankr | Wallet/portfolio bot | Bot-adjacent utility agent | Consumer |
| Ribbita | Agent-themed community token | Consumer agent experiment | Consumer |

#### Inclusion Criteria

1. **Onchain presence on Base** — must have a token contract with measurable activity
2. **Self-identifies or is identified by community as "agentic"** — either the team markets it as an AI agent, or the market classifies it in the agentic narrative
3. **Minimum activity threshold** — at least 100 transactions in the last 30 days
4. **Not purely a meme token** — must have some functional claim beyond speculation (bot, tool, launchpad, inference)

#### Known Limitations & Caveats

- **Concentration risk:** Some tracked tokens have high supply concentration (e.g., Clanker ~70% supply on 5 addresses). This dashboard tracks activity, not decentralization.
- **"Agentic" is generous:** Most tracked projects are infrastructure or narrative bets, not autonomous agents. This reflects the state of the market, not a quality endorsement.
- **Off-chain activity not captured:** API calls, LLM inference, social media automation — none of this shows up onchain.
- **Token ≠ Agent:** Having a token does not make something an AI agent. We track token activity as a proxy for ecosystem attention and capital allocation.
- **No revenue data:** Agent business models (x402 payments, subscription fees, NFT sales) are not standardized enough to compare.

#### Activity Score Formula

`Score = 40% × (project_txs / max_txs) + 35% × (project_users / max_users) + 25% × (project_eth_vol / max_eth_vol)`

Each component is **normalized to the top performer** (scoring 100). A project with half the transactions of the leader scores 50 on that component. The weights (40/35/25) prioritize breadth of usage over pure volume.

#### Standards Tracked

- **ERC-8004** — Agent Identity Registry (`0x8004A169FB4a3325136EB29fA0ceB6D2e539a432`). Onchain identity for AI agents. Early stage: high registration volume, unclear how many represent active agents.
- **x402** — HTTP-native payment protocol for agent commerce. Not yet measurable onchain at scale.

#### Data Sources

All metrics use **Base mainnet on-chain data** via Dune Analytics. YTD = January 1, 2026 onwards. DEX data from `dex.trades` (Dune Spellbook). Agent registrations from `base.logs` (raw events).

> This dashboard is a telemetry instrument, not a rating system. Inclusion does not imply endorsement. Built with data, not narratives. Supported by [AX1 Community](https://twitter.com/AX1ecosystem).
```

---

---

# ЗАПРОС 1: Base Agentic Pulse - KPI Каунтеры

## Что он делает
Показывает главные цифры экосистемы: общее количество транзакций, уникальных адресов, зарегистрированных агентов ERC-8004, а также недельную динамику (Week-over-Week) и разбивку Infrastructure vs Consumer.

## На какие вопросы отвечает
- Насколько большая агентская экосистема прямо сейчас?
- Она растёт неделя к неделе или стагнирует?
- Какая доля у Infrastructure vs Consumer?

## Название запроса при сохранении
`Base Agentic - Ecosystem Pulse KPIs`

## SQL-код (скопируй и вставь в Dune Query Editor)

```sql
WITH agentic_contracts AS (
    SELECT address, name, category FROM (
        VALUES
        -- Infrastructure / Фундаментальные
        (0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b, 'Virtuals Protocol', 'Infrastructure'),
        (0x96419929d7949d6a801a6909c145c8eef6a40431, 'Spectral', 'Infrastructure'),
        (0x1bc0c42215582d5a085795f4badbac3ff36d1bcb, 'Clanker', 'Infrastructure'),
        (0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf, 'Venice', 'Infrastructure'),
        (0x4f9fd6be4a90f2620860d680c0d4d5fb53d1a825, 'AIXBT', 'Infrastructure'),
        -- Consumer / Самостоятельные агенты
        (0x1b4617734c43f6159f3a70b7e06d883647512778, 'AWE', 'Consumer'),
        (0xb33Ff54b9F7242EF1593d2C9Bcd8f9df46c77935, 'FAI', 'Consumer'),
        (0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870, 'VADER', 'Consumer'),
        (0x9f86db9fc6f7c9408e8fda3ff8ce4e78ac7a6b07, 'CLAWD', 'Consumer'),
        (0x22af33fe49fd1fa80c7149773dde5890d3c76f3b, 'Bankr', 'Consumer'),
        (0xA4A2E2ca3fBfE21aed83471D28b6f65A233C6e00, 'Ribbita', 'Consumer')
    ) AS t(address, name, category)
),

current_week AS (
    SELECT
        COUNT(*) AS total_txs,
        COUNT(DISTINCT t."from") AS unique_users,
        SUM(t.value / 1e18) AS total_eth_volume
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= date_trunc('week', now())
      AND t.block_time < now()
      AND t.success = true
),

prev_week AS (
    SELECT
        COUNT(*) AS total_txs,
        COUNT(DISTINCT t."from") AS unique_users,
        SUM(t.value / 1e18) AS total_eth_volume
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= date_trunc('week', now()) - interval '7' day
      AND t.block_time < date_trunc('week', now())
      AND t.success = true
),

all_time AS (
    SELECT
        COUNT(*) AS total_txs,
        COUNT(DISTINCT t."from") AS unique_users
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
),

-- Registered(uint256 agentId, string agentURI, address owner) event
agents_8004 AS (
    SELECT
        COUNT(*) AS total_agents_registered
    FROM base.logs l
    WHERE l.contract_address = 0x8004A169FB4a3325136EB29fA0ceB6D2e539a432
      AND l.topic0 = 0xca52e62c367d81bb2e328eb795f7c7ba24afb478408a26c0e201d155c449bc4a
),

category_split AS(
    SELECT
        ac.category,
        COUNT(*) AS txs
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1
)

SELECT
    at.total_txs AS "Total Transactions (2026 YTD)",
    at.unique_users AS "Unique Addresses (2026 YTD)",
    a8.total_agents_registered AS "ERC-8004 Agents Registered",
    cw.total_txs AS "This Week Txs",
    pw.total_txs AS "Last Week Txs",
    CASE
        WHEN pw.total_txs > 0
        THEN ROUND(100.0 * (cw.total_txs - pw.total_txs) / pw.total_txs, 1)
        ELSE 0
    END AS "WoW Growth %",
    cw.unique_users AS "This Week Users",
    pw.unique_users AS "Last Week Users",
    CASE
        WHEN pw.unique_users > 0
        THEN ROUND(100.0 * (cw.unique_users - pw.unique_users) / pw.unique_users, 1)
        ELSE 0
    END AS "WoW Users Growth %",
    COALESCE(MAX(CASE WHEN cs.category = 'Infrastructure' THEN cs.txs END), 0) AS "Infrastructure Txs YTD",
    COALESCE(MAX(CASE WHEN cs.category = 'Consumer' THEN cs.txs END), 0) AS "Consumer Txs YTD"
FROM all_time at
CROSS JOIN agents_8004 a8
CROSS JOIN current_week cw
CROSS JOIN prev_week pw
CROSS JOIN category_split cs
GROUP BY 1,2,3,4,5,6,7,8,9
```

## Как оформить визуализации (6 каунтеров)

Из этого одного запроса создай **6 отдельных Counter-визуализаций**. Для этого:

1. После запуска запроса нажми **"New visualization"**
2. Выбери тип **"Counter"**
3. Настрой каждый каунтер:

| # | Заголовок каунтера | Какую колонку выбрать | Цвет |
|---|---|---|---|
| 1 | **Total Transactions YTD** | `Total Transactions (2026 YTD)` | Синий `#3B82F6` |
| 2 | **Unique Addresses YTD** | `Unique Addresses (2026 YTD)` | Фиолетовый `#8B5CF6` |
| 3 | **ERC-8004 Agents** | `ERC-8004 Agents Registered` | Зелёный `#10B981` |
| 4 | **Weekly Txs (WoW)** | `This Week Txs` + в подпись `WoW Growth %` | Синий `#3B82F6` |
| 5 | **Weekly Users (WoW)** | `This Week Users` + в подпись `WoW Users Growth %` | Фиолетовый `#8B5CF6` |
| 6 | **Infra vs Consumer** | `Infrastructure Txs YTD` и `Consumer Txs YTD` | Разные цвета |

**Расположение на дашборде:** Все 6 каунтеров в один ряд (РЯД 2). Каждый занимает 2 колонки = полная ширина.

---

---

# ЗАПРОС 2: Ежедневная Активность - Временные Ряды + 7d MA

## Что он делает
Главный "пульс" дашборда. Показывает ежедневные транзакции и активных пользователей по всей агентской экосистеме, разбитые на Infrastructure vs Consumer, с 7-дневными скользящими средними и кумулятивным графиком.

## На какие вопросы отвечает
- Тренд активности экосистемы вверх или вниз?
- Какая категория двигает рост?
- Когда произошли значимые сдвиги?

## Название запроса при сохранении
`Base Agentic - Daily Activity Time Series`

## SQL-код

```sql
WITH agentic_contracts AS (
    SELECT address, name, category FROM (
        VALUES
        (0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b, 'Virtuals Protocol', 'Infrastructure'),
        (0x96419929d7949d6a801a6909c145c8eef6a40431, 'Spectral', 'Infrastructure'),
        (0x1bc0c42215582d5a085795f4badbac3ff36d1bcb, 'Clanker', 'Infrastructure'),
        (0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf, 'Venice', 'Infrastructure'),
        (0x4f9fd6be4a90f2620860d680c0d4d5fb53d1a825, 'AIXBT', 'Infrastructure'),
        (0x1b4617734c43f6159f3a70b7e06d883647512778, 'AWE', 'Consumer'),
        (0xb33Ff54b9F7242EF1593d2C9Bcd8f9df46c77935, 'FAI', 'Consumer'),
        (0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870, 'VADER', 'Consumer'),
        (0x9f86db9fc6f7c9408e8fda3ff8ce4e78ac7a6b07, 'CLAWD', 'Consumer'),
        (0x22af33fe49fd1fa80c7149773dde5890d3c76f3b, 'Bankr', 'Consumer'),
        (0xA4A2E2ca3fBfE21aed83471D28b6f65A233C6e00, 'Ribbita', 'Consumer')
    ) AS t(address, name, category)
),

daily_raw AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        ac.category,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT t."from") AS daily_users
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1, 2
),

date_spine AS (
    SELECT
        day,
        category
    FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
    CROSS JOIN (VALUES ('Infrastructure'), ('Consumer')) AS c(category)
),

daily_filled AS (
    SELECT
        ds.day,
        ds.category,
        COALESCE(dr.daily_txs, 0) AS daily_txs,
        COALESCE(dr.daily_users, 0) AS daily_users
    FROM date_spine ds
    LEFT JOIN daily_raw dr
        ON ds.day = dr.day
        AND ds.category = dr.category
),

with_ma AS (
    SELECT
        day,
        category,
        daily_txs,
        daily_users,
        AVG(daily_txs) OVER (
            PARTITION BY category
            ORDER BY day
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS txs_7d_ma,
        AVG(daily_users) OVER (
            PARTITION BY category
            ORDER BY day
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS users_7d_ma,
        SUM(daily_txs) OVER (
            PARTITION BY category
            ORDER BY day
        ) AS cumulative_txs
    FROM daily_filled
)

SELECT
    day,
    category,
    daily_txs AS "Daily Transactions",
    daily_users AS "Daily Active Addresses",
    ROUND(txs_7d_ma, 0) AS "Txs 7d MA",
    ROUND(users_7d_ma, 0) AS "Users 7d MA",
    cumulative_txs AS "Cumulative Transactions"
FROM with_ma
WHERE day < current_date
ORDER BY day ASC, category
```

## Как оформить визуализации (3 графика из этого запроса)

### График 2a: Ежедневные Транзакции (РЯД 3 - на всю ширину)

1. Нажми **"New visualization"**
2. Тип: **Bar Chart**
3. **X-axis:** `day`
4. **Y-axis:** `Daily Transactions`
5. **Group by:** `category` (это создаст стакнутые бары)
6. Включи **"Stacking"** = ON
7. Добавь вторую серию (линию): `Txs 7d MA` - тип Line
8. **Цвета:**
   - Infrastructure бары = синий `#3B82F6`
   - Consumer бары = фиолетовый `#8B5CF6`
   - Infrastructure MA линия = тёмно-синий `#1E40AF`
   - Consumer MA линия = тёмно-фиолетовый `#6D28D9`
9. **Ширина на дашборде:** 12 колонок (полная ширина)
10. **Заголовок:** `Daily Agentic Transactions (Infrastructure vs Consumer)`

### График 2b: Ежедневные Активные Адреса (РЯД 4, левая половина)

1. **"New visualization"**
2. Тип: **Area Chart**
3. **X-axis:** `day`
4. **Y-axis:** `Daily Active Addresses`
5. **Group by:** `category`
6. Включи **Stacking** = ON
7. Цвета: те же (синий/фиолетовый)
8. **Ширина:** 6 колонок (левая половина)
9. **Заголовок:** `Daily Active Addresses`

### График 2c: Кумулятивные Транзакции (РЯД 4, правая половина)

1. **"New visualization"**
2. Тип: **Line Chart**
3. **X-axis:** `day`
4. **Y-axis:** `Cumulative Transactions`
5. **Group by:** `category`
6. Цвета: синий/фиолетовый
7. **Ширина:** 6 колонок (правая половина)
8. **Заголовок:** `Cumulative Transactions`

---

---

# ЗАПРОС 3: Рейтинг Топ Проектов (Leaderboard 30d)

## Что он делает
Ранжированная таблица всех 11 агентских проектов по композитному Activity Score (40% транзакции + 35% пользователи + 25% объём ETH) за последние 30 дней. Показывает WoW-рост, холдеров, и кто реально двигает экосистему.

## На какие вопросы отвечает
- Какие протоколы лидируют по реальному использованию?
- Кто растёт быстрее всех?
- Какое соотношение объём/пользователи?

## Название запроса при сохранении
`Base Agentic - Projects Leaderboard`

## SQL-код

```sql
WITH agentic_contracts AS (
    SELECT address, name, category FROM (
        VALUES
        (0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b, 'Virtuals Protocol', 'Infrastructure'),
        (0x96419929d7949d6a801a6909c145c8eef6a40431, 'Spectral', 'Infrastructure'),
        (0x1bc0c42215582d5a085795f4badbac3ff36d1bcb, 'Clanker', 'Infrastructure'),
        (0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf, 'Venice', 'Infrastructure'),
        (0x4f9fd6be4a90f2620860d680c0d4d5fb53d1a825, 'AIXBT', 'Infrastructure'),
        (0x1b4617734c43f6159f3a70b7e06d883647512778, 'AWE', 'Consumer'),
        (0xb33Ff54b9F7242EF1593d2C9Bcd8f9df46c77935, 'FAI', 'Consumer'),
        (0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870, 'VADER', 'Consumer'),
        (0x9f86db9fc6f7c9408e8fda3ff8ce4e78ac7a6b07, 'CLAWD', 'Consumer'),
        (0x22af33fe49fd1fa80c7149773dde5890d3c76f3b, 'Bankr', 'Consumer'),
        (0xA4A2E2ca3fBfE21aed83471D28b6f65A233C6e00, 'Ribbita', 'Consumer')
    ) AS t(address, name, category)
),

metrics_30d AS (
    SELECT
        ac.name AS project,
        ac.category,
        COUNT(*) AS txs_30d,
        COUNT(DISTINCT t."from") AS users_30d,
        SUM(t.value / 1e18) AS eth_volume_30d
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= now() - interval '30' day
      AND t.success = true
    GROUP BY 1, 2
),

metrics_7d AS (
    SELECT
        ac.name AS project,
        COUNT(*) AS txs_7d,
        COUNT(DISTINCT t."from") AS users_7d
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= now() - interval '7' day
      AND t.success = true
    GROUP BY 1
),

metrics_prev_7d AS (
    SELECT
        ac.name AS project,
        COUNT(*) AS txs_prev_7d,
        COUNT(DISTINCT t."from") AS users_prev_7d
    FROM base.transactions t
    INNER JOIN agentic_contracts ac
        ON t."to" = ac.address
    WHERE t.block_time >= now() - interval '14' day
      AND t.block_time < now() - interval '7' day
      AND t.success = true
    GROUP BY 1
),

holders AS (
    SELECT
        ac.name AS project,
        COUNT(DISTINCT tt."to") AS holders_count
    FROM tokens_base.transfers tt
    INNER JOIN agentic_contracts ac
        ON tt.contract_address = ac.address
    WHERE tt.block_time >= DATE '2024-01-01'
    GROUP BY 1
),

scored AS (
    SELECT
        m.project,
        m.category,
        m.txs_30d,
        m.users_30d,
        ROUND(m.eth_volume_30d, 4) AS eth_volume_30d,
        COALESCE(m7.txs_7d, 0) AS txs_7d,
        COALESCE(m7.users_7d, 0) AS users_7d,
        COALESCE(h.holders_count, 0) AS holders,
        CASE
            WHEN COALESCE(mp.txs_prev_7d, 0) > 0
            THEN ROUND(100.0 * (COALESCE(m7.txs_7d, 0) - mp.txs_prev_7d) / mp.txs_prev_7d, 1)
            ELSE NULL
        END AS wow_txs_growth_pct,
        CASE
            WHEN COALESCE(mp.users_prev_7d, 0) > 0
            THEN ROUND(100.0 * (COALESCE(m7.users_7d, 0) - mp.users_prev_7d) / mp.users_prev_7d, 1)
            ELSE NULL
        END AS wow_users_growth_pct,
        0.4 * m.txs_30d / NULLIF(MAX(m.txs_30d) OVER (), 0) * 100 AS score_txs,
        0.35 * m.users_30d / NULLIF(MAX(m.users_30d) OVER (), 0) * 100 AS score_users,
        0.25 * m.eth_volume_30d / NULLIF(MAX(m.eth_volume_30d) OVER (), 0) * 100 AS score_volume,
        (
            0.4 * m.txs_30d / NULLIF(MAX(m.txs_30d) OVER (), 0)
          + 0.35 * m.users_30d / NULLIF(MAX(m.users_30d) OVER (), 0)
          + 0.25 * m.eth_volume_30d / NULLIF(MAX(m.eth_volume_30d) OVER (), 0)
        ) * 100 AS activity_score
    FROM metrics_30d m
    LEFT JOIN metrics_7d m7 ON m.project = m7.project
    LEFT JOIN metrics_prev_7d mp ON m.project = mp.project
    LEFT JOIN holders h ON m.project = h.project
)

SELECT
    ROW_NUMBER() OVER (ORDER BY activity_score DESC) AS "#",
    project AS "Project",
    category AS "Category",
    txs_30d AS "Txs (30d)",
    users_30d AS "Users (30d)",
    eth_volume_30d AS "ETH Vol (30d)",
    txs_7d AS "Txs (7d)",
    holders AS "Holders",
    wow_txs_growth_pct AS "WoW Txs %",
    wow_users_growth_pct AS "WoW Users %",
    ROUND(activity_score, 1) AS "Activity Score",
    ROUND(score_txs, 1) AS "Score: Transactions",
    ROUND(score_users, 1) AS "Score: Users",
    ROUND(score_volume, 1) AS "Score: Volume"
FROM scored
ORDER BY activity_score DESC
```

## Как оформить визуализации (4 визуализации)

### Таблица 3a: Leaderboard (РЯД 6 - на всю ширину)

1. **"New visualization"**
2. Тип: **Table**
3. Скрой колонки `Score: Transactions`, `Score: Users`, `Score: Volume` (они для графика 3b)
4. **Условное форматирование (Conditional formatting):**
   - `WoW Txs %`: зелёный если положительный, красный если отрицательный
   - `WoW Users %`: зелёный если положительный, красный если отрицательный
   - `Activity Score`: градиент цвета (светло-синий -> тёмно-синий)
5. **Ширина:** 12 колонок (полная ширина)
6. **Заголовок:** `Top Agentic Projects Leaderboard (30 Days)`

### График 3b: Activity Score - Что Делает Проект Сильным (РЯД 7 - 8 колонок слева)

Этот график показывает ПОЧЕМУ каждый проект имеет свой рейтинг — из чего состоит его Activity Score.

1. **"New visualization"**
2. Тип: **Bar Chart** (горизонтальный, stacked)
3. **Y-axis:** `Project` (категориальная ось)
4. **X-axis (stacked bars):**
   - `Score: Transactions` — синий `#3B82F6`
   - `Score: Users` — фиолетовый `#8B5CF6`
   - `Score: Volume` — янтарный `#F59E0B`
5. **Stacking:** включить (Stacked)
6. **Сортировка:** по `Activity Score` убывание
7. **Ширина:** 8 колонок
8. **Заголовок:** `Activity Score Breakdown: What Makes Each Project Tick`

> Это показывает: Virtuals — лидер за счёт объёма торгов, Clanker — за счёт числа транзакций, и т.д.

### График 3c: Доля Экосистемы - Pie Chart (РЯД 7 - 4 колонки справа)

1. **"New visualization"**
2. Тип: **Pie Chart**
3. **Labels:** `Project`
4. **Values:** `Txs (30d)`
5. **Цвета:** Infrastructure проекты — оттенки синего, Consumer — оттенки фиолетового:
   - Virtuals: `#3B82F6`
   - Spectral: `#60A5FA`
   - Clanker: `#2563EB`
   - Venice: `#93C5FD`
   - AIXBT: `#1D4ED8`
   - AWE: `#8B5CF6`
   - FAI: `#A78BFA`
   - VADER: `#7C3AED`
   - CLAWD: `#C4B5FD`
   - Bankr: `#6D28D9`
   - Ribbita: `#DDD6FE`
6. **Показать %** на каждом сегменте
7. **Ширина:** 4 колонки
8. **Заголовок:** `Ecosystem Transaction Share (30d)`

### График 3d: WoW Growth Bars (РЯД 8 - на всю ширину)

Этот график мгновенно показывает кто растёт, а кто падает.

1. **"New visualization"**
2. Тип: **Bar Chart** (горизонтальный)
3. **Y-axis:** `Project`
4. **X-axis:** `WoW Txs %`
5. **Цвет:** Условный — зелёный `#10B981` для положительных, красный `#EF4444` для отрицательных
6. **Показать значения** на каждом баре (например: +45.2%, -12.3%)
7. **Ширина:** 12 колонок (полная ширина)
8. **Заголовок:** `Week-over-Week Transaction Growth by Project`

> Моментально видно: кто на подъёме (+зелёные бары справа), а кто теряет активность (-красные бары слева).

---

---

# ЗАПРОС 4: ERC-8004 Реестр Агентов - Глубокий Анализ

## Что он делает
Анализирует контракт IdentityRegistry ERC-8004: ежедневные регистрации новых агентов, кумулятивный рост, концентрация создателей (сколько кошельков создали большую часть агентов).

## На какие вопросы отвечает
- Сколько AI-агентов зарегистрировано?
- Рост органический или 30 кошельков насоздавали 25% всех агентов?
- Какая динамика регистраций по дням?

## Название запроса при сохранении
`Base Agentic - ERC-8004 Registry`

## SQL-код (Запрос 4a - основной, ежедневные регистрации)

```sql
-- Используем событие Registered(uint256 agentId, string agentURI, address owner)
-- topic0 = хеш события Registered
-- topic1 = agentId (indexed)
-- topic2 = owner/creator (indexed)
WITH registrations AS (
    SELECT
        l.block_time,
        date_trunc('day', l.block_time) AS day,
        l.topic2 AS creator,
        l.tx_hash
    FROM base.logs l
    WHERE l.contract_address = 0x8004A169FB4a3325136EB29fA0ceB6D2e539a432
      AND l.topic0 = 0xca52e62c367d81bb2e328eb795f7c7ba24afb478408a26c0e201d155c449bc4a
),

daily_reg AS(
    SELECT
        day,
        COUNT(*) AS daily_registrations,
        COUNT(DISTINCT creator) AS daily_unique_creators,
        SUM(COUNT(*)) OVER (ORDER BY day) AS cumulative_agents,
        SUM(COUNT(DISTINCT creator)) OVER (ORDER BY day) AS cumulative_creators_running
    FROM registrations
    GROUP BY 1
)

SELECT
    day,
    daily_registrations AS "New Agents",
    daily_unique_creators AS "New Unique Creators",
    cumulative_agents AS "Total Agents (Cumulative)"
FROM daily_reg
ORDER BY day ASC
```

## SQL-код (Запрос 4b - концентрация создателей)

Создай **отдельный запрос** с названием `Base Agentic - ERC-8004 Creator Concentration`:

```sql
-- Используем событие Registered вместо Transfer для точного подсчёта
WITH registrations AS (
    SELECT
        l.topic2 AS creator
    FROM base.logs l
    WHERE l.contract_address = 0x8004A169FB4a3325136EB29fA0ceB6D2e539a432
      AND l.topic0 = 0xca52e62c367d81bb2e328eb795f7c7ba24afb478408a26c0e201d155c449bc4a
),

creator_stats AS(
    SELECT
        creator,
        COUNT(*) AS agents_created
    FROM registrations
    GROUP BY 1
)

SELECT
    CASE
        WHEN agents_created = 1 THEN '1 agent'
        WHEN agents_created BETWEEN 2 AND 5 THEN '2-5 agents'
        WHEN agents_created BETWEEN 6 AND 20 THEN '6-20 agents'
        WHEN agents_created BETWEEN 21 AND 100 THEN '21-100 agents'
        ELSE '100+ agents'
    END AS "Creator Cohort",
    COUNT(*) AS "Number of Creators",
    SUM(agents_created) AS "Total Agents Created",
    ROUND(100.0 * SUM(agents_created) / (SELECT COUNT(*) FROM registrations), 1) AS "% of All Agents"
FROM creator_stats
GROUP BY 1
ORDER BY SUM(agents_created) DESC
```

## Как оформить визуализации

### Каунтеры (РЯД 10 - 3 штуки)

Из Запроса 4a возьми последнюю строку (максимальный `cumulative_agents`):
1. **Total Agents Registered** - Counter, зелёный `#10B981`
2. **Total Unique Creators** - Counter, бирюзовый `#14B8A6`
3. **Top 30 Creators' Share** - Counter (посчитай из данных 4b, например "25% всех агентов от 30 кошельков")

### График 4a: Ежедневные Регистрации (РЯД 11, 8 колонок слева)

1. **"New visualization"** из Запроса 4a
2. Тип: **Bar Chart** с наложением Line
3. **X-axis:** `day`
4. **Y-axis слева (бары):** `New Agents` - зелёный `#10B981`
5. **Y-axis справа (линия):** `Total Agents (Cumulative)` - янтарный `#F59E0B`, пунктирная
6. **Ширина:** 8 колонок
7. **Заголовок:** `ERC-8004 Agent Registrations`

### График 4b: Концентрация Создателей (РЯД 11, 4 колонки справа)

1. **"New visualization"** из Запроса 4b
2. Тип: **Bar Chart** (горизонтальный)
3. **Y-axis:** `Creator Cohort`
4. **X-axis:** `Total Agents Created`
5. **Цвет:** градиент от светло-зелёного к тёмно-зелёному
6. Включи **Data Labels** чтобы показывать `% of All Agents` на каждом баре
7. **Ширина:** 4 колонки
8. **Заголовок:** `Growth Reality Check: Creator Concentration`

---

---

# ЗАПРОС 5: Virtuals Protocol - Глубокий Анализ

## Что он делает
Детальный анализ торговой активности токена VIRTUAL на DEX: ежедневный объём в USD, уникальные трейдеры, рост новых холдеров, 7-дневные скользящие средние.

## На какие вопросы отвечает
- Насколько активна торговля VIRTUAL?
- Динамика холдеров - растёт или падает?
- Какой тренд торговой активности?

## Название запроса при сохранении
`Base Agentic - Virtuals Deep Dive`

## SQL-код

```sql
WITH daily_dex AS (
    SELECT
        date_trunc('day', block_time) AS day,
        COUNT(*) AS trades,
        SUM(amount_usd) AS volume_usd,
        COUNT(DISTINCT taker) AS unique_traders
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (token_bought_address = 0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b
           OR token_sold_address = 0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b)
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

daily_receivers AS (
    SELECT
        date_trunc('day', block_time) AS day,
        COUNT(DISTINCT "to") AS daily_unique_receivers
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b
      AND block_time >= DATE '2026-01-01'
    GROUP BY 1
),

combined AS (
    SELECT
        dd.day,
        dd.trades AS "DEX Trades",
        ROUND(dd.volume_usd, 0) AS "Volume USD",
        dd.unique_traders AS "Unique Traders",
        COALESCE(dr.daily_unique_receivers, 0) AS "Daily Unique Receivers",
        AVG(dd.trades) OVER (ORDER BY dd.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "Trades 7d MA",
        AVG(dd.volume_usd) OVER (ORDER BY dd.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "Volume 7d MA",
        SUM(COALESCE(dr.daily_unique_receivers, 0)) OVER (ORDER BY dd.day) AS "Cumulative Receivers (2026)"
    FROM daily_dex dd
    LEFT JOIN daily_receivers dr ON dd.day = dr.day
)

SELECT
    day,
    "DEX Trades",
    "Volume USD",
    "Unique Traders",
    "Daily Unique Receivers",
    ROUND("Trades 7d MA", 0) AS "Trades 7d MA",
    ROUND("Volume 7d MA", 0) AS "Volume 7d MA",
    "Cumulative Receivers (2026)"
FROM combined
WHERE day < current_date
ORDER BY day ASC
```

## Как оформить визуализации (4 графика)

### График 5a: Ежедневный DEX Volume (РЯД 13, левая половина)

1. **"New visualization"**
2. Тип: **Bar Chart** с наложением Line
3. **X-axis:** `day`
4. **Y-axis слева (бары):** `Volume USD` - янтарный/золотой `#F59E0B`
5. **Y-axis справа (линия):** `Volume 7d MA` - тёмно-янтарный `#D97706`
6. **Ширина:** 6 колонок
7. **Заголовок:** `VIRTUAL Daily DEX Volume (USD)`

### График 5b: Уникальные Трейдеры (РЯД 13, правая половина)

1. **"New visualization"**
2. Тип: **Area Chart**
3. **X-axis:** `day`
4. **Y-axis:** `Unique Traders`
5. **Цвет:** фиолетовый `#8B5CF6`
6. **Ширина:** 6 колонок
7. **Заголовок:** `VIRTUAL Unique Traders per Day`

### График 5c: Рост Получателей (РЯД 14, левая половина)

1. **"New visualization"**
2. Тип: **Bar + Line**
3. **X-axis:** `day`
4. **Y-axis слева (бары):** `Daily Unique Receivers` - зелёный `#10B981`
5. **Y-axis справа (линия):** `Cumulative Receivers (2026)` - тёмно-зелёный `#065F46`
6. **Ширина:** 6 колонок
7. **Заголовок:** `VIRTUAL Token: Daily Unique Receivers`

### График 5d: Активность Торговли (РЯД 14, правая половина)

1. **"New visualization"**
2. Тип: **Line Chart** с заливкой
3. **X-axis:** `day`
4. **Y-axis:** `DEX Trades` + `Trades 7d MA`
5. **Цвета:** Trades = светло-синий, MA = тёмно-синий
6. **Ширина:** 6 колонок
7. **Заголовок:** `VIRTUAL DEX Trading Activity`

---

---

# БОНУСНЫЙ ЗАПРОС: Cross-Pollination Index — Сетевой Эффект Экосистемы

## Что он делает
Измеряет **сетевой эффект** экосистемы: сколько кошельков используют несколько проектов одновременно. Это самый сильный сигнал здоровья — если пользователи взаимодействуют только с 1 проектом, экосистемы нет. Если они используют 3-4+ проекта — значит composability работает и есть реальный network effect.

## На какие вопросы отвечает
- Есть ли у Base Agentic реальный сетевой эффект?
- Сколько "power users" используют 3+ проекта?
- В среднем сколько проектов использует каждый кошелёк?

## Название запроса при сохранении
`Base Agentic - Cross-Pollination Index`

## SQL-код

```sql
WITH agentic_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b, 'Virtuals Protocol'),
        (0x96419929d7949d6a801a6909c145c8eef6a40431, 'Spectral'),
        (0x1bc0c42215582d5a085795f4badbac3ff36d1bcb, 'Clanker'),
        (0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf, 'Venice'),
        (0x4f9fd6be4a90f2620860d680c0d4d5fb53d1a825, 'AIXBT'),
        (0x1b4617734c43f6159f3a70b7e06d883647512778, 'AWE'),
        (0xb33Ff54b9F7242EF1593d2C9Bcd8f9df46c77935, 'FAI'),
        (0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870, 'VADER'),
        (0x9f86db9fc6f7c9408e8fda3ff8ce4e78ac7a6b07, 'CLAWD'),
        (0x22af33fe49fd1fa80c7149773dde5890d3c76f3b, 'Bankr'),
        (0xA4A2E2ca3fBfE21aed83471D28b6f65A233C6e00, 'Ribbita')
    ) AS t(address, name)
),

user_projects AS (
    SELECT
        t."from" AS wallet,
        COUNT(DISTINCT ac.name) AS projects_used
    FROM base.transactions t
    INNER JOIN agentic_contracts ac ON t."to" = ac.address
    WHERE t.block_time >= date_trunc('day', now()) - interval '7' day
      AND t.success = true
    GROUP BY 1
)

SELECT
    COUNT(CASE WHEN projects_used >= 3 THEN 1 END) AS "Power Users (3+ Projects)",
    ROUND(AVG(CAST(projects_used AS double)), 2) AS "Avg Projects per User",
    ROUND(100.0 * COUNT(CASE WHEN projects_used = 1 THEN 1 END) / COUNT(*), 1) AS "Single-Project Users %"
FROM user_projects
```

## Как оформить визуализации (3 каунтера)

### Counter 1: Power Users

1. **"New visualization"**
2. Тип: **Counter**
3. **Колонка:** `Power Users (3+ Projects)`
4. **Заголовок:** `Power Users (3+ Projects)`
5. **Подпись:** `wallets active in 3+ agentic projects (7d)`
6. **Цвет:** Бирюзовый `#14B8A6`
7. **Ширина:** 4 колонки

### Counter 2: Avg Projects per User

1. **"New visualization"**
2. Тип: **Counter**
3. **Колонка:** `Avg Projects per User`
4. **Заголовок:** `Avg Projects per User`
5. **Подпись:** `ecosystem network effect (7d)`
6. **Цвет:** Янтарный `#F59E0B`
7. **Формат:** число с 2 десятичными
8. **Ширина:** 4 колонки

### Counter 3: Single-Project Users %

1. **"New visualization"**
2. Тип: **Counter**
3. **Колонка:** `Single-Project Users %`
4. **Заголовок:** `Single-Project Users %`
5. **Подпись:** `% users in only 1 project — lower = healthier ecosystem`
6. **Цвет:** Красный `#EF4444`
7. **Формат:** число с суффиксом `%`
8. **Ширина:** 4 колонки

> **Как читать:**
> - **Power Users = 500+** → сильный сетевой эффект, пользователи активно исследуют экосистему
> - **Power Users < 50** → слабое взаимодействие между проектами
> - **Avg Projects = 1.0** → нет сетевого эффекта (каждый юзер в 1 проекте)
> - **Avg Projects = 2.0+** → здоровая экосистема с composability
> - **Single-Project < 50%** → большинство юзеров используют 2+ проекта (отлично!)
> - **Single-Project > 80%** → экосистема фрагментирована, нет cross-pollination

---

---

# ВАЖНЫЕ ПРИМЕЧАНИЯ

## Если запрос выдаёт ошибку

1. **Адреса контрактов.** DuneSQL использует адреса как varbinary с префиксом `0x`. Если ошибка - попробуй обернуть: `FROM_HEX('0b3e328455c4059EEb9e3f84b5543F74E24e7E1b')` вместо `0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b`

2. **Таблица трансферов.** Правильное название: `tokens.transfers` с фильтром `WHERE blockchain = 'base'`. Это кросс-чейн таблица Dune Spellbook. Если не работает - попробуй `erc20_base.evt_Transfer`. Проверь точное название в Data Explorer (левая панель в Query Editor).

3. **ERC-8004 подсчёт агентов.** Запросы используют таблицу `base.logs` для подсчёта событий `Registered(uint256 agentId, string agentURI, address owner)`. `topic0` = `0xca52e6...` (хеш события Registered), `topic1` = agentId, `topic2` = owner/creator. Каждая регистрация = 1 событие Registered. Это надёжнее, чем Transfer events или селектор функции.

4. **Производительность.** Если запрос долго выполняется - убедись что есть фильтр `AND t.block_time >= DATE '2026-01-01'` чтобы ограничить объём сканируемых данных.

## Как обновлять дашборд

Раз в неделю:
1. Открой каждый запрос
2. Нажми **"Run"** для обновления данных
3. Dune кэширует результаты - новые данные появятся после перезапуска

## Итого по файлам запросов

| # | Название в Dune | Тип визуализации |
|---|---|---|
| 1 | `Base Agentic - Ecosystem Pulse KPIs` | 6 Counter |
| 2 | `Base Agentic - Daily Activity Time Series` | Bar+Line, Area, Line |
| 3 | `Base Agentic - Projects Leaderboard` | Table + Stacked Bar + Pie + WoW Bar |
| 4a | `Base Agentic - ERC-8004 Registry` | Bar+Line + 3 Counter |
| 4b | `Base Agentic - ERC-8004 Creator Concentration` | Horizontal Bar |
| 5 | `Base Agentic - Virtuals Deep Dive` | Bar+Line, Area, Bar+Line, Line |
| Bonus | `Base Agentic - Cross-Pollination Index` | 3 Counter |
| 6 | `Base vs Solana - Agentic Ecosystem Snapshot` | 6 Counter + Table |
| 7 | `Base vs Solana - Growth Dynamics` | Bar+Line (weekly) |

---

---

# БЛОК 2: СРАВНЕНИЕ BASE AGENTIC vs SOLANA AGENTIC

> Максимум 2 запроса. Цель — показать, что Base на данный момент доминирует в реальной агентской экономике.

---

## ТЕКСТОВЫЙ ВИДЖЕТ: Разделитель перед блоком Base vs Solana

**Как добавить:** В режиме Edit нажми **"Add text widget"**, вставь текст ниже.

**Текст (скопируй как есть):**

```markdown
---

## Base vs Solana: Who's Winning the Agentic Race?

Two ecosystems, two philosophies. Base has ERC-8004 agent identity, x402 commerce, and Virtuals infrastructure. Solana has raw speed, ai16z/elizaOS framework, and a meme-agent culture. Below we compare them head-to-head using real on-chain DEX trading data.

> "Don't count transactions — measure economic gravity."
```

---

### Виджет 6: Разделитель перед Ecosystem Snapshot (РЯД 17)

**Как добавить:** В режиме Edit нажми **"Add text widget"**, вставь текст ниже.

**Текст (скопируй как есть):**

```markdown
---

## Agentic Ecosystem Snapshot: 30-Day Head-to-Head

Two chains. Two visions of AI agents. One question: where is the real economic activity? This snapshot compares total DEX volume, unique traders, and average trade size for curated AI agent tokens on Base vs Solana over the last 30 days.

> "Volume is the voice of the market — listen to which chain it's speaking on."
```

---

# ЗАПРОС 6: Base vs Solana — Agentic Ecosystem Snapshot

## Что он делает
Сравнивает ключевые метрики DEX-трейдинга агентских токенов на Base и Solana за последние 30 дней. Показывает общий объём, количество трейдов, уникальных трейдеров и среднюю сделку — бок о бок.

## На какие вопросы отвечает
- Где больше реальной торговой активности по AI-агентским токенам?
- Какая экосистема привлекает больше уникальных трейдеров?
- Где крупнее средняя сделка (= более серьёзные деньги)?

## Название запроса при сохранении
`Base vs Solana - Agentic Ecosystem Snapshot`

## SQL-код

```sql
-- Base vs Solana: Agentic Token DEX Activity (Last 30 Days)
-- Compares trading metrics for top AI agent tokens on both chains
-- IMPORTANT: Base uses dex.trades, Solana uses dex_solana.trades (separate table!)

WITH base_tokens AS (
    SELECT address, name FROM (
        VALUES
        -- Infrastructure
        (0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b, 'VIRTUAL'),
        (0x96419929d7949d6a801a6909c145c8eef6a40431, 'Spectral'),
        (0x1bc0c42215582d5a085795f4badbac3ff36d1bcb, 'Clanker'),
        (0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf, 'Venice'),
        (0x4f9fd6be4a90f2620860d680c0d4d5fb53d1a825, 'AIXBT'),
        -- Consumer Agents
        (0x1b4617734c43f6159f3a70b7e06d883647512778, 'AWE'),
        (0xb33Ff54b9F7242EF1593d2C9Bcd8f9df46c77935, 'FAI'),
        (0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870, 'VADER'),
        (0x9f86db9fc6f7c9408e8fda3ff8ce4e78ac7a6b07, 'CLAWD'),
        (0x22af33fe49fd1fa80c7149773dde5890d3c76f3b, 'Bankr'),
        (0xA4A2E2ca3fBfE21aed83471D28b6f65A233C6e00, 'Ribbita')
    ) AS t(address, name)
),

-- Base agentic DEX trades (last 30 days) — from dex.trades (EVM cross-chain table)
base_trades AS (
    SELECT
        CAST(d.amount_usd AS DOUBLE) AS amount_usd,
        d.taker
    FROM dex.trades d
    WHERE d.blockchain = 'base'
      AND (
          d.token_bought_address IN (SELECT address FROM base_tokens)
          OR d.token_sold_address IN (SELECT address FROM base_tokens)
      )
      AND d.block_time >= NOW() - INTERVAL '30' DAY
      AND d.amount_usd > 0
),

-- Solana agentic DEX trades (last 30 days) — from dex_solana.trades (SEPARATE Solana table!)
-- Note: dex_solana.trades uses VARCHAR addresses (plain base58 strings), not varbinary
-- Column names: token_bought_mint_address, token_sold_mint_address, trader_id (not taker)
solana_trades AS (
    SELECT
        CAST(d.amount_usd AS DOUBLE) AS amount_usd,
        d.trader_id
    FROM dex_solana.trades d
    WHERE (
          d.token_bought_mint_address IN (
              'HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC',  -- ai16z
              '9BB6NFEcjBCtnNLFko2FqVQBq8HHM13kCyYcdQbgpump',  -- Fartcoin
              'CzLSujWBLFsSjncfkh59rUFqvafWcY5tzedWJSuypump',  -- GOAT
              '61V8vBaqAGMpfGeQisFBFLbEDnpBXFMqYrBkGz6hpump',  -- ARC
              '8x5VqbHA8D7NkD52uNuS5nnt3PwA8pLD34ymskeSo2Wn',  -- Zerebro
              'KENJSUYLASHUMfHyy5o4Hp2FdNqZg1AsUPhfH2kYvEP',   -- GRIFFAIN
              '3iQL8BFS2vE7mww4ehAqQHAsbmRNCrPxizWAT2Zfyr9y'   -- VIRTUAL (SOL)
          )
          OR d.token_sold_mint_address IN (
              'HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC',
              '9BB6NFEcjBCtnNLFko2FqVQBq8HHM13kCyYcdQbgpump',
              'CzLSujWBLFsSjncfkh59rUFqvafWcY5tzedWJSuypump',
              '61V8vBaqAGMpfGeQisFBFLbEDnpBXFMqYrBkGz6hpump',
              '8x5VqbHA8D7NkD52uNuS5nnt3PwA8pLD34ymskeSo2Wn',
              'KENJSUYLASHUMfHyy5o4Hp2FdNqZg1AsUPhfH2kYvEP',
              '3iQL8BFS2vE7mww4ehAqQHAsbmRNCrPxizWAT2Zfyr9y'
          )
      )
      AND d.block_time >= NOW() - INTERVAL '30' DAY
      AND d.amount_usd > 0
),

base_agg AS (
    SELECT
        'Base' AS chain,
        COUNT(*) AS total_trades,
        COUNT(DISTINCT taker) AS unique_traders,
        ROUND(SUM(amount_usd), 0) AS total_volume_usd,
        ROUND(AVG(amount_usd), 2) AS avg_trade_size
    FROM base_trades
),

solana_agg AS (
    SELECT
        'Solana' AS chain,
        COUNT(*) AS total_trades,
        COUNT(DISTINCT trader_id) AS unique_traders,
        ROUND(SUM(amount_usd), 0) AS total_volume_usd,
        ROUND(AVG(amount_usd), 2) AS avg_trade_size
    FROM solana_trades
),

combined AS (
    SELECT * FROM base_agg
    UNION ALL
    SELECT * FROM solana_agg
)

SELECT
    chain,
    total_trades AS "Total Trades (30d)",
    unique_traders AS "Unique Traders (30d)",
    total_volume_usd AS "Total Volume USD (30d)",
    avg_trade_size AS "Avg Trade Size USD",
    -- Market share
    ROUND(100.0 * total_volume_usd / NULLIF(SUM(total_volume_usd) OVER (), 0), 1) AS "Volume Share %",
    ROUND(100.0 * unique_traders / NULLIF(SUM(unique_traders) OVER (), 0), 1) AS "Trader Share %"
FROM combined
ORDER BY total_volume_usd DESC
```

## Как оформить визуализации

### Вариант A: 6 каунтеров (РЯД: на всю ширину)

Из этого запроса создай **6 Counter-визуализаций** (по 2 колонки каждый = 12 суммарно):

| # | Title | Column Name | Row Filter | Цвет | Ширина |
|---|-------|-------------|-----------|------|--------|
| 1 | 🔵 Base: Volume (30d) | `Total Volume USD (30d)` | WHERE chain='Base' | `#3B82F6` (синий) | 2 колонки |
| 2 | 🟣 Solana: Volume (30d) | `Total Volume USD (30d)` | WHERE chain='Solana' | `#8B5CF6` (фиолетовый) | 2 колонки |
| 3 | 🔵 Base: Traders (30d) | `Unique Traders (30d)` | WHERE chain='Base' | `#3B82F6` | 2 колонки |
| 4 | 🟣 Solana: Traders (30d) | `Unique Traders (30d)` | WHERE chain='Solana' | `#8B5CF6` | 2 колонки |
| 5 | 🔵 Base: Market Share | `Volume Share %` | WHERE chain='Base' | `#10B981` (зелёный) | 2 колонки |
| 6 | 🟣 Solana: Market Share | `Volume Share %` | WHERE chain='Solana' | `#F59E0B` (янтарный) | 2 колонки |

**Для каждого каунтера:**
1. New visualization → Counter
2. **Title:** как в таблице выше
3. **Column:** указанная колонка
4. **Row number:** 1 для Base, 2 для Solana
5. **Prefix:** `$` для Volume, пусто для остальных
6. **Suffix:** `%` для Share, пусто для остальных

### Вариант B: Таблица сравнения (дополнительно)

1. Тип: **Table**
2. Показать все колонки
3. Форматирование: `Total Volume USD (30d)` → Dollar format
4. **Conditional formatting:** `Volume Share %` → зелёный если > 50%, красный если < 50%
5. Заголовок: `Base vs Solana: Agentic DEX Activity (30d)`
6. Ширина: 12 колонок (вся ширина)

---

### Виджет 7: Разделитель перед Growth Dynamics (РЯД 19)

**Как добавить:** В режиме Edit нажми **"Add text widget"**, вставь текст ниже.

**Текст (скопируй как есть):**

```markdown
---

## Growth Dynamics: Who's Accelerating?

Snapshots tell you where things stand — but momentum tells you where they're going. This section tracks weekly DEX volume trends, week-over-week growth rates, and shifting market share between Base and Solana agentic ecosystems over the last 12 weeks.

> "In crypto, the trend isn't your friend — it's your thesis."
```

---

# ЗАПРОС 7: Base vs Solana — Growth Dynamics (Weekly)

## Что он делает
Показывает еженедельную динамику DEX-объёмов и числа трейдеров по агентским токенам на обеих цепочках. Ключевое — это тренд и momentum: кто ускоряется, а кто замедляется.

## На какие вопросы отвечает
- Как менялся объём торгов по неделям на Base vs Solana?
- Какая цепочка набирает momentum (WoW ускорение)?
- Где общий тренд — рост или стагнация?

## Название запроса при сохранении
`Base vs Solana - Growth Dynamics`

## SQL-код

```sql
-- Base vs Solana: Weekly Agentic DEX Volume & Growth (Last 12 Weeks)
-- Shows weekly trends + WoW growth for both ecosystems
-- IMPORTANT: Base uses dex.trades, Solana uses dex_solana.trades (separate table!)

WITH base_tokens AS (
    SELECT address FROM (
        VALUES
        (0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b),
        (0x96419929d7949d6a801a6909c145c8eef6a40431),
        (0x1bc0c42215582d5a085795f4badbac3ff36d1bcb),
        (0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf),
        (0x4f9fd6be4a90f2620860d680c0d4d5fb53d1a825),
        (0x1b4617734c43f6159f3a70b7e06d883647512778),
        (0xb33Ff54b9F7242EF1593d2C9Bcd8f9df46c77935),
        (0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870),
        (0x9f86db9fc6f7c9408e8fda3ff8ce4e78ac7a6b07),
        (0x22af33fe49fd1fa80c7149773dde5890d3c76f3b),
        (0xA4A2E2ca3fBfE21aed83471D28b6f65A233C6e00)
    ) AS t(address)
),

-- Weekly Base volume — from dex.trades (EVM cross-chain table)
base_weekly AS (
    SELECT
        DATE_TRUNC('week', d.block_time) AS week,
        'Base' AS chain,
        COUNT(*) AS trades,
        COUNT(DISTINCT d.taker) AS traders,
        ROUND(SUM(CAST(d.amount_usd AS DOUBLE)), 0) AS volume_usd
    FROM dex.trades d
    WHERE d.blockchain = 'base'
      AND (
          d.token_bought_address IN (SELECT address FROM base_tokens)
          OR d.token_sold_address IN (SELECT address FROM base_tokens)
      )
      AND d.block_time >= NOW() - INTERVAL '84' DAY  -- ~12 weeks
      AND d.amount_usd > 0
    GROUP BY 1
),

-- Weekly Solana volume — from dex_solana.trades (SEPARATE Solana table!)
-- Uses VARCHAR mint addresses (plain base58 strings), column: trader_id (not taker)
solana_weekly AS (
    SELECT
        DATE_TRUNC('week', d.block_time) AS week,
        'Solana' AS chain,
        COUNT(*) AS trades,
        COUNT(DISTINCT d.trader_id) AS traders,
        ROUND(SUM(CAST(d.amount_usd AS DOUBLE)), 0) AS volume_usd
    FROM dex_solana.trades d
    WHERE (
          d.token_bought_mint_address IN (
              'HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC',  -- ai16z
              '9BB6NFEcjBCtnNLFko2FqVQBq8HHM13kCyYcdQbgpump',  -- Fartcoin
              'CzLSujWBLFsSjncfkh59rUFqvafWcY5tzedWJSuypump',  -- GOAT
              '61V8vBaqAGMpfGeQisFBFLbEDnpBXFMqYrBkGz6hpump',  -- ARC
              '8x5VqbHA8D7NkD52uNuS5nnt3PwA8pLD34ymskeSo2Wn',  -- Zerebro
              'KENJSUYLASHUMfHyy5o4Hp2FdNqZg1AsUPhfH2kYvEP',   -- GRIFFAIN
              '3iQL8BFS2vE7mww4ehAqQHAsbmRNCrPxizWAT2Zfyr9y'   -- VIRTUAL (SOL)
          )
          OR d.token_sold_mint_address IN (
              'HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC',
              '9BB6NFEcjBCtnNLFko2FqVQBq8HHM13kCyYcdQbgpump',
              'CzLSujWBLFsSjncfkh59rUFqvafWcY5tzedWJSuypump',
              '61V8vBaqAGMpfGeQisFBFLbEDnpBXFMqYrBkGz6hpump',
              '8x5VqbHA8D7NkD52uNuS5nnt3PwA8pLD34ymskeSo2Wn',
              'KENJSUYLASHUMfHyy5o4Hp2FdNqZg1AsUPhfH2kYvEP',
              '3iQL8BFS2vE7mww4ehAqQHAsbmRNCrPxizWAT2Zfyr9y'
          )
      )
      AND d.block_time >= NOW() - INTERVAL '84' DAY  -- ~12 weeks
      AND d.amount_usd > 0
    GROUP BY 1
),

combined AS (
    SELECT * FROM base_weekly
    UNION ALL
    SELECT * FROM solana_weekly
)

SELECT
    week,
    chain,
    trades AS "Weekly Trades",
    traders AS "Weekly Traders",
    volume_usd AS "Weekly Volume USD",
    -- WoW growth %
    ROUND(
        100.0 * (volume_usd - LAG(volume_usd) OVER (PARTITION BY chain ORDER BY week))
        / NULLIF(LAG(volume_usd) OVER (PARTITION BY chain ORDER BY week), 0),
    1) AS "WoW Volume Growth %",
    -- Market share per week
    ROUND(
        100.0 * volume_usd
        / NULLIF(SUM(volume_usd) OVER (PARTITION BY week), 0),
    1) AS "Volume Share %"
FROM combined
ORDER BY week, chain
```

## Как оформить визуализации

### График 7a: Weekly Volume Comparison (РЯД: 8 колонок слева)

1. Тип: **Bar Chart**
2. **X-axis:** `week`
3. **Y-axis:** `Weekly Volume USD`
4. **Group by:** `chain`
5. **Stacking:** **Grouped** (рядом друг с другом, НЕ стакнутые)
6. **Цвета:** Base = `#3B82F6` (синий), Solana = `#8B5CF6` (фиолетовый)
7. **Заголовок:** `Weekly DEX Volume: Base vs Solana Agentic Tokens`
8. **Y-axis label:** `Volume (USD)`
9. **Number format:** `$0a` (сокращённый)

### График 7b: Volume Market Share Trend (РЯД: 4 колонки справа)

1. Тип: **Area Chart** (100% stacked)
2. **X-axis:** `week`
3. **Y-axis:** `Volume Share %`
4. **Group by:** `chain`
5. **Stacking:** **100% Stacked**
6. **Цвета:** Base = `#3B82F6`, Solana = `#8B5CF6`
7. **Заголовок:** `Market Share Trend (%)`
8. Должно показывать как доля Base растёт/падает со временем

### График 7c: WoW Growth Rate (РЯД: на всю ширину, дополнительно)

1. Тип: **Line Chart**
2. **X-axis:** `week`
3. **Y-axis:** `WoW Volume Growth %`
4. **Group by:** `chain`
5. **Цвета:** Base = `#3B82F6`, Solana = `#8B5CF6`
6. **Заголовок:** `Week-over-Week Volume Growth Rate (%)`
7. **Reference line:** 0% (горизонтальная линия на нуле)
8. Линии выше нуля = рост, ниже = сжатие

---

## ТЕКСТОВЫЙ ВИДЖЕТ: Футер блока Base vs Solana

**Текст:**

```markdown
---

### Methodology: Base vs Solana Comparison

**Base tokens tracked:** VIRTUAL, Spectral, Clanker, Venice, AIXBT, AWE, FAI, VADER, CLAWD, Bankr, Ribbita
**Solana tokens tracked:** ai16z (elizaOS), Fartcoin, GOAT, ARC, Zerebro, GRIFFAIN, VIRTUAL (SOL)

**Data source:** `dex.trades` (Base, EVM) + `dex_solana.trades` (Solana) — Dune Spellbook curated DEX tables for each chain.

**Important caveats:**
- This compares specific curated token lists, not entire ecosystems
- Solana has no ERC-8004 equivalent (agent registry) yet — agent identity is Base-exclusive
- x402 commerce activity is not captured in DEX trades (separate protocol)
- Some Solana AI tokens may be primarily meme-driven rather than utility-driven
- Token lists can be expanded as new agentic projects emerge

> Supported by [AX1 Community](https://twitter.com/AX1ecosystem)
```

---

## КАРТА РАСПОЛОЖЕНИЯ ВИДЖЕТОВ — БЛОК 2

```
РЯД 16: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — "Base vs Solana: Who's Winning the Agentic Race?"]

РЯД 17: [6 КАУНТЕРОВ из Запроса 6]
         | Base Vol | Solana Vol | Base Traders | Solana Traders | Base Share | Solana Share |

РЯД 18: [ТАБЛИЦА 6 — на всю ширину]
         Сравнительная таблица Base vs Solana

РЯД 19: [ГРАФИК 7a — 8 колонок]  [ГРАФИК 7b — 4 колонки]
         Weekly Volume Bars               Market Share Area (100%)

РЯД 20: [ГРАФИК 7c — на всю ширину]
         WoW Growth Rate Lines

РЯД 21: [ТЕКСТ-ФУТЕР блока Base vs Solana]
```

---

## ВАЖНЫЕ ПРИМЕЧАНИЯ К БЛОКУ 2

### Почему 2 разные таблицы (dex.trades vs dex_solana.trades)?

В Dune данные о DEX-трейдах хранятся в **РАЗНЫХ таблицах** для EVM и Solana:

| Данные | Таблица | Адреса | Колонка трейдера |
|--------|---------|--------|------------------|
| Base (EVM) | `dex.trades` WHERE blockchain = 'base' | varbinary (0x...) | `taker` |
| Solana | `dex_solana.trades` (отдельная таблица!) | VARCHAR (plain base58 строки) | `trader_id` |

**ВАЖНО:** Нельзя получить Solana данные через `dex.trades WHERE blockchain = 'solana'` — это не работает! Solana живёт в своей отдельной таблице `dex_solana.trades`.

Также отличаются названия колонок:
- EVM: `token_bought_address`, `token_sold_address`, `taker`
- Solana: `token_bought_mint_address`, `token_sold_mint_address`, `trader_id`

Solana адреса в `dex_solana.trades` — это обычные строки (VARCHAR), а не varbinary. Поэтому `from_base58()` НЕ нужен — просто используй строки в кавычках: `'HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC'`

### Если Solana запросы медленные

Таблицы Solana в Dune значительно тяжелее EVM-таблиц. Советы:
- Не увеличивай период больше 90 дней
- Если таймаут — уменьши список Solana токенов до 3-4 главных (ai16z, GOAT, Fartcoin)
- Используй `INTERVAL '30' DAY` вместо `INTERVAL '84' DAY` для Запроса 7

### Solana токены — откуда адреса

| Токен | Solana Mint Address | Описание |
|-------|-------------------|-----------|
| ai16z (elizaOS) | `HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC` | AI DAO + Eliza framework, крупнейший AI агент на Solana |
| Fartcoin | `9BB6NFEcjBCtnNLFko2FqVQBq8HHM13kCyYcdQbgpump` | AI-мем токен (Truth Terminal связь) |
| GOAT | `CzLSujWBLFsSjncfkh59rUFqvafWcY5tzedWJSuypump` | Goatseus Maximus — первый пул-фан AI мем-токен |
| ARC | `61V8vBaqAGMpfGeQisFBFLbEDnpBXFMqYrBkGz6hpump` | AI Rig Complex — Rust фреймворк для AI агентов |
| Zerebro | `8x5VqbHA8D7NkD52uNuS5nnt3PwA8pLD34ymskeSo2Wn` | Автономный AI агент (музыка, NFT, мемы) |
| GRIFFAIN | `KENJSUYLASHUMfHyy5o4Hp2FdNqZg1AsUPhfH2kYvEP` | AI финансовый агент на Solana |
| VIRTUAL (SOL) | `3iQL8BFS2vE7mww4ehAqQHAsbmRNCrPxizWAT2Zfyr9y` | Virtuals Protocol — мост с Base на Solana |
