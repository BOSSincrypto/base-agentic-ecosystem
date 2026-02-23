# Base Agentic Dashboard — V1 Update Guide

> Этот файл содержит ТОЛЬКО то, что нужно обновить/добавить/изменить на живом дашборде.
> Ничего не удаляй — только замени/добавь указанные элементы.

---

## ИЗМЕНЕНИЕ 0 (НОВОЕ): Оглавление / Table of Contents (Widget 0, РЯД 1)

**Что сделать:** Добавь НОВЫЙ text widget **самым первым элементом** дашборда — над заголовком, либо сразу под заголовком (РЯД 1-2). Растяни на всю ширину (12 колонок).

**Как:** В Edit mode нажми "Add text widget", вставь текст ниже, перетащи на самый верх.

**Текст:**

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
| **Methodology** | Definitions, inclusion criteria, Activity Score formula, known limitations | Bottom |
```

**Зачем:** Читатель сразу видит структуру дашборда и знает куда скроллить. Не нужно гадать "это про адопшен или экономику?" — всё расписано в одной таблице. Номера рядов помогают ориентироваться.

---

## ИЗМЕНЕНИЕ 1: Заголовок дашборда (Widget 1, РЯД 1)

**Что сделать:** Замени текст в верхнем text widget на новый.

**Старый текст (удалить):**
```
# Base Agentic: The Birth of AI Economy

This dashboard maps the early anatomy of an AI-native economy on Base...
(весь блок текста)
```

**Новый текст (вставить вместо):**

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

**Зачем:** Одна строка сразу объясняет о чём дашборд: это телеметрия зарождающегося рынка. Убирает путаницу "это про адопшен? экономику? автономность?" — ответ: всё перечислено в 4 пунктах, + честное признание что это "birth of a market", не готовый продукт.

---

## ИЗМЕНЕНИЕ 2: Разделитель перед Leaderboard (Widget 2, РЯД 5)

**Что сделать:** Замени текст в text widget перед таблицей Leaderboard.

**Старый текст (удалить):**
```
## Top Agentic Projects Leaderboard

Which protocols are driving real activity? This leaderboard ranks the top agentic projects by composite activity score (transactions, unique users, ETH volume) over the last 30 days. Size = volume. Growth = week-over-week momentum.
```

**Новый текст (вставить вместо):**

```markdown
---

## Top Agentic Projects Leaderboard

Which protocols are driving real onchain activity? This leaderboard ranks tracked projects by a composite **Activity Score** over the last 30 days.

**Activity Score formula:** `55% Transactions (normalized) + 45% Unique Users (normalized)`. Each component is normalized against the top performer (max = 100). A project scoring 80 has 80% of the leading project's composite activity.

**Important context:** Most projects tracked here are agent-adjacent infrastructure, not autonomous agents themselves. See Methodology at the bottom for inclusion criteria and what "agentic" means in this context.
```

**Зачем:** Теперь расшифровка Activity Score прямо рядом с таблицей. Читатель видит формулу и понимает почему Virtuals на первом месте, а остальные ниже. Плюс честная пометка что это не автономные агенты.

---

## ИЗМЕНЕНИЕ 3: Футер / Методология (Widget 5, РЯД 14-15)

**Что сделать:** Замени ВЕСЬ текст в нижнем text widget (Methodology) на значительно расширенную версию.

**Старый текст (удалить):** весь блок "Methodology & Data Sources" (короткий, ~15 строк)

**Новый текст (вставить вместо):**

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

`Score = 55% × (project_txs / max_txs) + 45% × (project_users / max_users)`

Each component is **normalized to the top performer** (scoring 100). A project with half the transactions of the leader scores 50 on that component. The weights (55/45) prioritize breadth of usage (transactions) while giving strong weight to organic reach (unique users).

**Пример:** Если у Virtuals 10,000 txs (максимум), а у Clanker 5,000 — Clanker получает 50 по компоненту Transactions. Если у Clanker больше уникальных пользователей — он получит выше по Users. Итоговый Score = сумма обоих компонентов с весами.

#### Standards Tracked

- **ERC-8004** — Agent Identity Registry (`0x8004A169FB4a3325136EB29fA0ceB6D2e539a432`). Onchain identity for AI agents. Early stage: high registration volume, unclear how many represent active agents.
- **x402** — HTTP-native payment protocol for agent commerce. Not yet measurable onchain at scale.

#### Data Sources

All metrics use **Base mainnet on-chain data** via Dune Analytics. YTD = January 1, 2026 onwards. DEX data from `dex.trades` (Dune Spellbook). Agent registrations from `base.logs` (raw events).

> This dashboard is a telemetry instrument, not a rating system. Inclusion does not imply endorsement. Built with data, not narratives. Supported by [AX1 Community](https://twitter.com/AX1ecosystem).
```

**Зачем:** Полная методология отвечает на все вопросы:
- "Что такое agentic?" — честный ответ: это pre-agentic infrastructure
- "Почему включили X?" — таблица Project Classification + Inclusion Criteria
- "А Clanker с 70% саплая на 5 адресах?" — прямо написано в Known Limitations
- "Как считается Activity Score?" — формула + пример
- "Зачем ERC-8004 если там пусто?" — "early stage, unclear how many represent active agents"

---

## ИЗМЕНЕНИЕ 4 (НОВОЕ): Text Widget — Activity Score Explainer

**Что сделать:** Добавь НОВЫЙ text widget **сразу ПОД таблицей Leaderboard** (после РЯД 6, перед графиками 3b/3c).

**Как:** В Edit mode нажми "Add text widget", вставь текст ниже, расположи на всю ширину (12 колонок) между таблицей и графиками.

**Текст:**

```markdown
#### How to Read Activity Score

The stacked bar below shows **why** each project ranks where it does. Activity Score = 2 components:

| Component | Weight | What It Measures | Color |
|-----------|--------|-----------------|-------|
| **Transactions** | 55% | Total txs to contract (30d) — measures breadth of usage | Blue |
| **Unique Users** | 45% | Distinct wallets interacting (30d) — measures organic reach | Purple |

Each is **normalized to the top project** (max = 100 points per component). A score of 75 means the project has 75% of the max possible composite activity.

> **Reading the chart:** If a project's bar is mostly blue (Transactions) — high-frequency protocol with lots of calls. If mostly purple (Users) — broad organic reach with many distinct wallets. A balanced bar = healthy all-round activity.
```

**Зачем:** Читатель смотрит на Leaderboard, видит "Activity Score 47.3" и не понимает что это. Теперь прямо под таблицей — объяснение с цветами графика. Сразу понятно: синий = транзакции, фиолетовый = уникальные пользователи.

---

## ИТОГО: ЧТО НУЖНО СДЕЛАТЬ НА DUNE

| # | Действие | Где на дашборде |
|---|----------|----------------|
| 0 | **Добавить новый** text widget (Оглавление / TOC) | Самый верх — над или сразу под заголовком |
| 1 | **Заменить** текст Widget 1 (заголовок) | РЯД 1 — самый верх |
| 2 | **Заменить** текст Widget 2 (перед Leaderboard) | РЯД 5 |
| 3 | **Заменить** текст Widget 5 (Methodology) | Самый низ дашборда |
| 4 | **Добавить новый** text widget (Activity Score Explainer) | Между таблицей Leaderboard и графиками (после РЯД 6) |

**SQL Запроса 3 (Leaderboard) МЕНЯЕТСЯ** — см. ИЗМЕНЕНИЕ 5 ниже. Остальные SQL не меняются.

---

## ИЗМЕНЕНИЕ 5: SQL Запроса 3 (Leaderboard) — убрать Volume

**Что сделать:** Замени SQL запроса https://dune.com/queries/6731906/10590178 на новый.

**Что изменилось:**
- Убраны колонки `ETH Vol (30d)` и `Score: Volume`
- Activity Score пересчитан: было `40% txs + 35% users + 25% volume` → стало **`55% txs + 45% users`**
- Убраны CTE/колонки связанные с `eth_volume`
- Добавлен `ROUND()` для score компонентов

**Новый SQL (скопируй целиком):**

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
        COUNT(DISTINCT t."from") AS users_30d
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
        0.55 * m.txs_30d / NULLIF(MAX(m.txs_30d) OVER (), 0) * 100 AS score_txs,
        0.45 * m.users_30d / NULLIF(MAX(m.users_30d) OVER (), 0) * 100 AS score_users,
        (
            0.55 * m.txs_30d / NULLIF(MAX(m.txs_30d) OVER (), 0)
          + 0.45 * m.users_30d / NULLIF(MAX(m.users_30d) OVER (), 0)
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
    txs_7d AS "Txs (7d)",
    holders AS "Holders",
    wow_txs_growth_pct AS "WoW Txs %",
    wow_users_growth_pct AS "WoW Users %",
    ROUND(activity_score, 1) AS "Activity Score",
    ROUND(score_txs, 1) AS "Score: Transactions",
    ROUND(score_users, 1) AS "Score: Users"
FROM scored
ORDER BY activity_score DESC
```

**Описание запроса (обнови на Dune):**
`Ranks agentic projects by Activity Score (55% transactions + 45% unique users, normalized). Shows 30d and 7d metrics, WoW growth, and holder counts.`
