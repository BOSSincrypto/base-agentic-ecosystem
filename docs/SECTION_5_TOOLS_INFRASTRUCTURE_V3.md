# РАЗДЕЛ 5: Tools & Infrastructure - Batches 3.0 (V3)

> **Дашборд:** `Base Agentic: The Birth of AI Economy`
> **URL:** https://dune.com/ax1research/base-agentic-ecosystem
> **Раздел:** Section 5 (Tools & Infrastructure - Batches 3.0)
> **Дата:** Апрель 2026, V3
> **Дедлайн:** 27 апреля (пре-шаблон) → 28 апреля (пре-финал) → 29 апреля (финальный релиз)
> **Источник:** Обсуждение команды AX1, 23–27 апреля 2026
> **Тестовый дашборд:** https://dune.com/bossincrypto/test
> **x402 Query:** https://dune.com/queries/7384630

---

## СОДЕРЖАНИЕ

1. [Ключевые изменения V3](#ключевые-изменения-v3)
2. [Общий план](#общий-план)
3. [Инфоборды проектов](#инфоборды-проектов)
   - BlockRunAI (ключевой)
   - Floe Labs (on-chain active)
   - Agently (ERC-8004)
   - 4mica (токен live, Vault coming soon)
4. [Section 5: Tools & Infrastructure](#section-5-tools--infrastructure)
   - Text Widget S5 (Section Header + Info Boards)
   - Query 5.1 — On-chain Activity (для проектов с данными)
   - Query 5.2 — x402 Facilitator Protocol Pulse
   - Визуализации и оформление
5. [Обновление Table of Contents](#обновление-table-of-contents)
6. [Обновление Methodology (Footer)](#обновление-methodology-footer)
7. [Порядок действий на Dune — Чеклист](#порядок-действий-на-dune--чеклист)

---

## КЛЮЧЕВЫЕ ИЗМЕНЕНИЯ V3

Согласно обсуждению команды (AX1, Сергей RUA, BOSSincrypto) от 23–27 апреля 2026:

| Изменение | Причина | Источник |
|-----------|---------|----------|
| **Новая категория: Tools & Infrastructure** | Проекты, которые "не генерят, а пропускают активность через себя" | @AX1, 23.04 |
| **Фокус на Batches 3.0 (003)** | Все 4 проекта — участники Base Batches 003 accelerator | @AX1, 23.04 |
| **Формат — инфоборды** | "Саммари по проектам, оформить как инфоборды. KPI пока не релевантны, нет за что зацепиться" | @Сергей, 27.04 |
| **Расположение — НАД gaming** | "По аналогии с agentic gaming. Но ее над ней, gaming последней" | @AX1, 27.04 |
| **On-chain → данные, Coming soon → метка** | "Что уже имеет ончейн активность — добавить ниже собственного подраздела. Что пока в разработке — coming soon" | @Сергей, 27.04 |
| **Подсветка для Base** | "Нужно подсветить эти проекты из Batches 3.0, чтобы коллеги из Base видели аптренд дашборда" | @Сергей, 27.04 |
| **BlockRunAI — ключевой** | Главный проект секции + запланирована AMA | @AX1, 23–25.04 |
| **Информационный подход** | "Не у всех токен запущен, ончейн активности минимум" — "Да, по стате что получится" | @Сергей + @AX1, 25.04 |

### Что такое "Tools & Infrastructure"?
Отдельная категория от Infrastructure (Virtuals, Spectral, Clanker...) и Consumer (AWE, FAI, VADER...). Это **агентская инфраструктура нового поколения** — проекты Batches 3.0, которые строят:
- Платежные рельсы для агентов (x402 protocol)
- Маркетплейсы и роутинг для межагентного взаимодействия
- Кредитные протоколы для агентов (DeFi for agents)
- Системы микроплатежей и кредитных табов

**Ключевое отличие от Infrastructure:** эти проекты не запускают свои токены как основной продукт. Они строят "трубы", через которые проходит агентская активность.

---

## ОБЩИЙ ПЛАН

### Формат: Инфоборды

По рекомендации @Сергей — секция оформляется **как инфоборды** (info boards) по проектам:
- Каждый проект получает **текстовый блок-описание** (что делает, ключевые метрики, ссылки)
- Проекты с ончейн-данными → **подраздел с метриками** ниже описания
- Проекты без mainnet данных → **метка "Coming Soon"**
- KPI-каунтеры минимальны — только там, где есть реальные данные

### Что добавляем

| Section | Queries | Widgets | Rows |
|---------|---------|---------|------|
| **5) Tools & Infrastructure (Batches 3.0)** | 2 queries | 1 text (header + 4 info boards) + 2 counters + 1 line chart = **4-5** | 3-4 ряда |

### Где располагается

> **ВАЖНО:** Секция размещается **НАД** gaming секциями. Gaming — последней. (@AX1, 27.04)

Новый порядок на дашборде:
1. Ecosystem Pulse (KPIs)
2. Cross-Pollination Index
3. Daily Activity
4. Leaderboard
5. ERC-8004 Registry
6. Virtuals Protocol
7. Base vs Solana
8. **→ Section 5: Tools & Infrastructure (Batches 3.0)** ← НОВОЕ
9. Section 3: Base Agentic Gaming
10. Section 4: OWB Agentic Gaming
11. Methodology (footer)

---

## ЦВЕТОВАЯ ПАЛИТРА

### Новый цвет для Section 5

| Element | Color | HEX |
|---------|-------|-----|
| **Tools & Infrastructure** | **Teal** | **`#14B8A6`** |
| BlockRunAI (primary) | Teal | `#14B8A6` |
| Floe Labs | Sky | `#0EA5E9` |
| Agently | Indigo | `#6366F1` |
| 4mica | Violet | `#7C3AED` |
| x402 Protocol | Dark Teal | `#0F766E` |
| Growth/Positive | Green | `#10B981` |
| Decline/Negative | Red | `#EF4444` |

### Полная палитра дашборда (с V3)

| Category | Color | HEX |
|----------|-------|-----|
| Infrastructure (V1) | Blue | `#3B82F6` |
| Consumer/Agents (V1) | Purple | `#8B5CF6` |
| **Tools & Infrastructure (V3)** | **Teal** | **`#14B8A6`** |
| Agentic Gaming (V2) | Pink | `#EC4899` |
| OWB (V2) | Orange | `#F97316` |

---

## КАРТА LAYOUT (SECTION 5)

```
=====================================================================
  SECTION 5: TOOLS & INFRASTRUCTURE (BATCHES 3.0)
  Расположение: НАД gaming секциями (gaming — последние)
=====================================================================

РЯД S5-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ + ИНФОБОРДЫ — 12 колонок]
          "Tools & Infrastructure: The Backbone of Agent Economy"
          + 4 Info Boards (BlockRunAI, Floe Labs, Agently, 4mica)
          + On-chain Status Labels (Active / Coming Soon)

РЯД S5-2: [2 КАУНТЕРА из Query 5.1]       [МИНИ-ТАБЛИЦА — 6 кол.]
          | x402 Txs | On-chain Txs |        Contract Status Table

РЯД S5-3: [ГРАФИК 5.2 — 12 колонок]
          x402 Facilitator: Protocol Pulse on Base (line + cumulative)

=====================================================================
```

---

## ИНФОБОРДЫ ПРОЕКТОВ

### Статус ончейн-данных

| Проект | Статус | Что есть на Base Mainnet |
|--------|--------|-------------------------|
| **BlockRunAI** | 🟡 Через x402 Facilitator | Нет dedicated контракта. Платежи через x402 Facilitator |
| **Floe Labs** | 🟢 Active | Lending contract (`0x17946c...`) + FLOE token (`0xA2CBA6...`) |
| **Agently** | 🟡 Shared (ERC-8004) | Использует общий ERC-8004 Registry |
| **4mica** | 🟡 Токен live / Vault coming soon | 4MICA token via Virtuals; Vault на тестнете |

---

### 1. BlockRunAI (Ключевой проект)

| Параметр | Значение |
|----------|----------|
| **Тип** | AI Agent Payment Rail + LLM Gateway |
| **Сайт** | [blockrun.ai](https://blockrun.ai) |
| **Twitter/X** | [@BlockRunAI](https://x.com/BlockRunAI) |
| **GitHub** | [github.com/BlockRunAI](https://github.com/BlockRunAI) |
| **Протоколы** | x402, MCP (Model Context Protocol) |
| **Сети** | Base Mainnet (primary), Solana Mainnet |
| **Валюта** | USDC |
| **Свой токен** | Нет |
| **Ончейн** | Платежи через x402 Facilitator (Coinbase CDP): `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` |

**Что делает:**
BlockRun — платежный рельс для AI-агентов. Маркетплейс, где AI-агенты автономно находят, маршрутизируют и оплачивают API-сервисы с помощью USDC через x402 протокол. Без API-ключей, без подписок.

**Ключевые продукты:**
- **ClawRouter** — LLM-роутер, снижает затраты до 78% через intelligent routing. 6,247 GitHub stars (MIT)
- **AI Model Gateway** — 41+ LLM (GPT-5, Claude, Gemini, Grok, DeepSeek) через единый endpoint
- **RunCode (brcc)** — AI coding agent, 289 GitHub stars
- **BlockRun MCP** — MCP-сервер для Claude Code, 98+ stars

**Как работает x402:**
1. AI-агент → HTTP запрос к API
2. Сервер → `402 Payment Required` с ценой
3. Агент → подписывает USDC-платеж локально
4. Агент → повторяет запрос с подписью в заголовке
5. Сервер → верифицирует через x402 Facilitator, отдает ответ

**On-chain status:** Платежи видны через x402 Facilitator (`0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6`, помечен на BaseScan как "Coinbase: x402 Facilitator 1"). Нельзя изолировать BlockRunAI от других x402 клиентов без wallet mapping.

**AMA:** Запланирована с командой AX1. Может дать дополнительную информацию для трекинга.

---

### 2. Floe Labs — 🟢 On-chain Active

| Параметр | Значение |
|----------|----------|
| **Тип** | Structured Credit Protocol (P2P Lending for Agents) |
| **Сайт** | [floelabs.xyz](https://www.floelabs.xyz/) |
| **App** | [app.floelabs.xyz](https://app.floelabs.xyz) |
| **Twitter/X** | [@FloeLabs](https://x.com/FloeLabs) |
| **Протоколы** | DeFi, Intent-based lending |
| **Сеть** | Base Mainnet |
| **Контракт (lending)** | `0x17946cD3e180f82e632805e5549EC913330Bb175` (592 txs, active) |
| **FLOE Token** | `0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e` (14 holders, deployed Apr 11, 2026) |

**Что делает:**
Первый "credit DEX" на Base. P2P intent-matching протокол для кредитования. Фиксированные ставки, изолированный риск, прямой matching без пула. $480M deal flow pipeline.

**AI-агент "Lendr":** Настраивает займы на обычном английском через chat и @LendrBot в X.

**On-chain status:** 🟢 Единственный проект секции с полноценными mainnet контрактами. Данные доступны для SQL-запросов.

---

### 3. Agently — 🟡 Shared (ERC-8004)

| Параметр | Значение |
|----------|----------|
| **Тип** | Agent Marketplace + Routing Layer |
| **Сайт** | [use-agently.com](https://use-agently.com/) |
| **Twitter/X** | [@AgentlyHQ](https://x.com/AgentlyHQ) |
| **GitHub** | [github.com/AgentlyHQ/use-agently](https://github.com/AgentlyHQ/use-agently) (68 stars, MIT) |
| **Протоколы** | x402, A2A (Google), MCP, ERC-8004 |
| **Сеть** | Base Mainnet (primary) |
| **Контракт** | Использует ERC-8004 Registry: `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432` (общий) |

**Что делает:**
Маркетплейс и CLI где AI-агенты находят друг друга, общаются (A2A), и оплачивают сервисы (x402). "DNS для AI-агентов". 50+ зарегистрированных агентов на маркетплейсе.

**On-chain status:** 🟡 Активность пересекается с ERC-8004 Registry (уже отслеживается на дашборде). Своего dedicated контракта нет.

---

### 4. 4mica — 🟡 Токен live / Vault — Coming Soon

| Параметр | Значение |
|----------|----------|
| **Тип** | Instant Credit Tabs (x402 Facilitator) |
| **Сайт** | [4mica.xyz](https://4mica.xyz/) |
| **Docs** | [docs.4mica.xyz](https://docs.4mica.xyz/) |
| **Twitter/X** | [@4mica_xyz](https://x.com/4mica_xyz) |
| **GitHub** | [github.com/4mica-Network](https://github.com/4mica-Network) (12 repos) |
| **Протоколы** | x402 (4mica-credit scheme), BLS signatures |
| **4MICA Token (current)** | `0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab` (deployed Apr 18, 2026 via Virtuals Protocol, 13 holders) |
| **4MICA Token (v1)** | `0x231375fbbf6abf2320d64be206c0478d551e2687` (14 holders, 41 transfers) |
| **Vault (core protocol)** | ⏳ Coming Soon — пока только на тестнетах (Base Sepolia, Ethereum Sepolia) |

**Что делает:**
Протокол мгновенных кредитных табов для агентов. "Откройте таб, тратьте сейчас, рассчитывайтесь через 7 дней." Некастодиальные BLS-signed гарантии.

**On-chain status:** 🟡 4MICA токен live на Base mainnet (через Virtuals Protocol). Vault (core protocol) — пока только тестнет. Base Sepolia support добавлен 12 апреля 2026.

---

## СВОДНАЯ ТАБЛИЦА КОНТРАКТОВ

| Project | Address | Network | Type | Status |
|---------|---------|---------|------|--------|
| x402 Facilitator (Coinbase CDP) | `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` | Base Mainnet | x402 Payment Verification | **Active** (shared) |
| Floe Labs (Lending) | `0x17946cD3e180f82e632805e5549EC913330Bb175` | Base Mainnet | Lending Protocol (ERC1967Proxy) | **Active** (592 txs) |
| Floe Labs (FLOE Token) | `0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e` | Base Mainnet | ERC-20 Token | **Active** (14 holders) |
| 4MICA Token (current) | `0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab` | Base Mainnet | ERC-20 (via Virtuals) | **Active** (13 holders) |
| 4MICA Token (v1) | `0x231375fbbf6abf2320d64be206c0478d551e2687` | Base Mainnet | ERC-20 (via Virtuals) | **Active** (14 holders) |
| ERC-8004 Registry | `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432` | Base Mainnet | Identity Registry | **Active** (shared, used by Agently) |
| BlockRunAI | N/A | Base Mainnet | USDC via x402 Facilitator | No dedicated contract |
| Agently | N/A | Base Mainnet | Uses ERC-8004 + x402 | No dedicated contract |
| 4mica (Vault) | TBD | Base Sepolia | Credit Tabs | **⏳ Coming Soon** |

---

## SECTION 5: TOOLS & INFRASTRUCTURE

### TEXT WIDGET S5 (Section Header + Info Boards)

**Тип виджета:** Text Widget
**Ширина:** 12 колонок (full-width)
**Расположение:** РЯД S5-1 — **НАД** gaming секциями

**Текст для copy-paste в Dune:**

```markdown
## Tools & Infrastructure: The Backbone of Agent Economy

**Category: Batches 3.0 Agentic Tooling**

This section highlights infrastructure projects from Base Batches 003 accelerator that enable the agent economy — tools that don't generate activity themselves, but facilitate and route activity through the ecosystem.

These are the "pipes and rails" — payment infrastructure, agent discovery layers, credit protocols, and coordination tools that agents depend on to operate.

---

### BlockRunAI — AI Agent Payment Rail

The payment rail for AI. A marketplace where AI agents autonomously discover, route, and pay for APIs using USDC via x402. Access 41+ LLM models — no API keys, no subscriptions.

| Key Stats | |
|-----------|---|
| **Product** | LLM Gateway + Payment Rail |
| **Protocol** | x402 (HTTP-native payments) |
| **GitHub** | ClawRouter: 6,200+ stars (MIT) |
| **Networks** | Base (primary), Solana |
| **Partners** | Circle, Coinbase, Solana |

[blockrun.ai](https://blockrun.ai) · [@BlockRunAI](https://x.com/BlockRunAI)

---

### Floe Labs — Structured Credit for Agents 🟢

The first credit DEX on Base. P2P intent-matching protocol where agents post lending/borrowing intents with fixed rates and isolated risk. No pools.

| Key Stats | |
|-----------|---|
| **Product** | Credit DEX + AI Lending Agent (Lendr) |
| **Deal Flow** | $480M pipeline |
| **Lending Contract** | [`0x17946c...`](https://basescan.org/address/0x17946cD3e180f82e632805e5549EC913330Bb175) |
| **FLOE Token** | [`0xA2CBA6...`](https://basescan.org/token/0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e) |
| **Status** | **On-chain Active** |

[floelabs.xyz](https://www.floelabs.xyz/) · [@FloeLabs](https://x.com/FloeLabs)

---

### Agently — Agent Discovery & Routing Layer

Marketplace and CLI where AI agents discover each other, communicate (A2A), and transact (x402). "DNS for AI agents."

| Key Stats | |
|-----------|---|
| **Product** | Agent Marketplace + CLI |
| **Protocols** | x402, A2A (Google), MCP, ERC-8004 |
| **Registry** | Shared ERC-8004 (already tracked) |
| **Agents** | 50+ registered |

[use-agently.com](https://use-agently.com/) · [@AgentlyHQ](https://x.com/AgentlyHQ)

---

### 4mica — Instant Credit Tabs for Agents

Open a tab, let agents spend now, settle after 7 days. Non-custodial, BLS-backed cryptographic guarantees.

| Key Stats | |
|-----------|---|
| **Product** | Credit Tabs + x402 Facilitator |
| **4MICA Token** | [`0x33f2df...`](https://basescan.org/token/0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab) — Live on Base |
| **Vault Contract** | ⏳ Coming Soon (testnet) |
| **SDKs** | Rust, TypeScript, Python |

[4mica.xyz](https://4mica.xyz/) · [@4mica_xyz](https://x.com/4mica_xyz)

---

*All four projects are participants of [Base Batches 003](https://base.org/batches) accelerator (announced April 9, 2026). Demo Day: May 19, San Francisco.*

**Protocol Stack:** x402 (payments) + ERC-8004 (identity) + A2A (communication) + MCP (tools)
```

---

### QUERY 5.1: Tools & Infra — On-chain Activity

#### Что он делает
Собирает ончейн-метрики для проектов с mainnet данными: Floe Labs contracts + x402 Facilitator + DEX-торги токенами (FLOE, 4MICA). Минимальный набор каунтеров — без тяжёлых KPI.

#### На какие вопросы отвечает
- Сколько транзакций проходит через x402 Facilitator на Base?
- Какая активность у Floe Labs lending contract?
- Есть ли DEX-торги у FLOE и 4MICA токенов?

#### Название запроса при сохранении
`Tools & Infra - On-chain Activity (Batches 3.0)`

#### SQL-код

```sql
-- Tools & Infrastructure: On-chain Activity (Batches 3.0)
-- V3: Minimal metrics for info board section
-- Tracks: Floe Labs (lending), x402 Facilitator (Coinbase CDP), token DEX
-- Note: BlockRunAI and Agently have no dedicated contracts

WITH tool_contracts AS (
    SELECT address, name FROM (
        VALUES
        -- Floe Labs: Lending Protocol (592+ txs)
        (0x17946cD3e180f82e632805e5549EC913330Bb175, 'Floe Labs (Lending)'),
        -- Floe Labs: FLOE Token
        (0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e, 'Floe Labs (FLOE Token)'),
        -- x402 Facilitator (Coinbase CDP) — all x402 payments on Base
        (0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6, 'x402 Facilitator')
    ) AS t(address, name)
),

-- Aggregate totals since Apr 2026
contract_totals AS (
    SELECT
        SUM(CASE WHEN tc.name = 'x402 Facilitator' THEN 1 ELSE 0 END) AS x402_txs,
        SUM(CASE WHEN tc.name != 'x402 Facilitator' THEN 1 ELSE 0 END) AS project_txs,
        COUNT(DISTINCT t."from") AS unique_users
    FROM base.transactions t
    INNER JOIN tool_contracts tc ON t."to" = tc.address
    WHERE t.block_time >= DATE '2026-04-01'
      AND t.success = true
),

-- Token DEX volume (FLOE + 4MICA on Base)
token_dex AS (
    SELECT
        ROUND(COALESCE(SUM(amount_usd), 0), 2) AS token_volume_usd,
        COUNT(*) AS token_trades
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          -- FLOE token
          token_bought_address = 0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e
          OR token_sold_address = 0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e
          -- 4MICA token (current)
          OR token_bought_address = 0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab
          OR token_sold_address = 0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab
          -- 4MICA token (v1)
          OR token_bought_address = 0x231375fbbf6abf2320d64be206c0478d551e2687
          OR token_sold_address = 0x231375fbbf6abf2320d64be206c0478d551e2687
      )
      AND block_time >= DATE '2026-04-01'
)

SELECT
    ct.x402_txs AS "x402 Facilitator Txs",
    ct.project_txs AS "Project Contract Txs",
    ct.unique_users AS "Unique Users",
    td.token_volume_usd AS "Token DEX Volume (USD)",
    td.token_trades AS "Token Trades"
FROM contract_totals ct
CROSS JOIN token_dex td
```

**Примечания:**
- Минимальный набор метрик — для каунтеров, не для тяжёлой аналитики
- x402 Facilitator показывает ВСЮ x402 активность на Base (не только Batches 003)
- FLOE и 4MICA — единственные токены секции с DEX-данными

---

### QUERY 5.2: x402 Facilitator — Protocol Pulse

#### Что он делает
Отдельный запрос для x402 Facilitator (Coinbase CDP). Показывает масштаб x402 экосистемы на Base — все платежи, которые проходят через facilitator.

> **Ссылка:** https://dune.com/queries/7384630 — существующий query от @BOSSincrypto

#### На какие вопросы отвечает
- Какой объём x402 платежей проходит через Base?
- Как растёт adoption x402 протокола?
- Сколько уникальных отправителей используют x402?

#### Название запроса при сохранении
`x402 Facilitator - Protocol Pulse (Base)`

#### SQL-код

```sql
-- x402 Facilitator: Protocol Pulse on Base
-- Tracks ALL x402 payment verifications through Coinbase CDP Facilitator
-- Address: 0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6
-- Covers: BlockRunAI, Agently, and all other x402 clients on Base

WITH daily_x402 AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS txs,
        COUNT(DISTINCT t."from") AS unique_senders,
        SUM(COUNT(*)) OVER (ORDER BY DATE_TRUNC('day', t.block_time)) AS cumulative_txs,
        SUM(COUNT(DISTINCT t."from")) OVER (ORDER BY DATE_TRUNC('day', t.block_time)) AS cumulative_users
    FROM base.transactions t
    WHERE t."to" = 0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6
      AND t.success = true
      AND t.block_time >= DATE '2026-01-01'
    GROUP BY 1
)

SELECT
    day,
    txs AS "Daily x402 Txs",
    unique_senders AS "Daily Unique Senders",
    cumulative_txs AS "Cumulative x402 Txs",
    cumulative_users AS "Cumulative Users"
FROM daily_x402
ORDER BY day
```

**Примечания:**
- Контракт помечен на BaseScan как "Coinbase: x402 Facilitator 1"
- Показывает ВСЮ x402 активность, не только Batches 003 проекты
- Дата начала: 2026-01-01 (x402 активен с мая 2025, но для наглядности — с начала года)
- Cumulative линии показывают рост adoption x402 протокола
- **Нужен нормальный контракт** — уточнить у BlockRun на AMA для возможности изоляции их трафика

---

### Визуализации

#### 2 Каунтера (РЯД S5-2, левая часть)

Из Query 5.1:

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **x402 Facilitator Txs** | `x402 Facilitator Txs` | Number | Teal `#14B8A6` | 3 кол. |
| 2 | **On-chain Contract Txs** | `Project Contract Txs` | Number | Sky `#0EA5E9` | 3 кол. |

> Каунтеры минимальны — основная информация в инфобордах.

#### Мини-таблица (РЯД S5-2, правая часть)

Из Query 5.1 — таблица с метриками:

| Настройка | Значение |
|-----------|----------|
| **Тип** | Table |
| **Ширина** | 6 колонок |
| **Заголовок** | `On-chain Metrics` |
| **Колонки** | x402 Facilitator Txs, Project Contract Txs, Unique Users, Token DEX Volume, Token Trades |

#### Line Chart: x402 Protocol Pulse (РЯД S5-3)

Из Query 5.2 — full-width chart:

| Настройка | Значение |
|-----------|----------|
| **Тип** | Mixed (bar + line) |
| **Ширина** | 12 колонок |
| **Заголовок** | `x402 Protocol Pulse on Base` |
| **X-axis** | `day` |
| **Bars (left)** | `Daily x402 Txs` (Teal `#14B8A6`) |
| **Line (right)** | `Cumulative x402 Txs` (Dark Teal `#0F766E`) |
| **Additional** | `Daily Unique Senders` (Sky `#0EA5E9`, dashed line) |
| **Не использовать** | Log scale |

---

## ОБНОВЛЕНИЕ TABLE OF CONTENTS

### Новый Table of Contents (с учётом нового порядка)

**Текст (заменить текущий):**

```markdown
## Dashboard Structure

| # | Section | What It Tracks |
|---|---------|---------------|
| 1 | Ecosystem Pulse | Total activity, unique addresses, ERC-8004 agents, WoW dynamics |
| 2 | Cross-Pollination Index | Network effect: power users, avg projects per user |
| 3 | Daily Activity | Transaction trends, active addresses, cumulative growth |
| 4 | Leaderboard | Activity Score ranking, WoW momentum, holders |
| 5 | ERC-8004 Registry | Agent identity registrations, creator concentration |
| 6 | Virtuals Protocol | Token economics, trading activity, agent token health |
| 7 | Base vs Solana | DEX volume, traders, growth dynamics comparison |
| **8** | **Tools & Infrastructure** | **Batches 3.0: BlockRunAI, Floe Labs, Agently, 4mica — info boards + x402 pulse** |
| 9 | Base Agentic Gaming | Gaming transactions, players, project comparison |
| 10 | OWB Agentic Gaming | DTU, NFT revenue, retention, Agentic Passes |
```

---

## ОБНОВЛЕНИЕ METHODOLOGY (Footer)

### Добавить в существующий Methodology текст

```markdown
### Tools & Infrastructure (V3 — April 2026)

**What we track:** Infrastructure projects from Base Batches 003 accelerator that enable the agent economy — payment rails, agent discovery, credit protocols, and coordination tools.

**Format:** Info boards — project summaries with on-chain status labels. Projects with active mainnet contracts show live metrics; projects still in development are marked "Coming Soon."

**Category definition:** Projects that don't generate on-chain activity themselves, but facilitate and route activity through the ecosystem. The "pipes and rails" of the agent economy.

**Tracked projects:**

| Project | Role | On-chain Status |
|---------|------|----------------|
| BlockRunAI | AI agent payment rail + LLM gateway (x402) | Via x402 Facilitator |
| Floe Labs | Structured credit protocol for agents | 🟢 Active (lending + token) |
| Agently | Agent marketplace + routing layer (A2A, MCP) | Shared ERC-8004 registry |
| 4mica | Instant credit tabs (x402 facilitator) | Token live; Vault coming soon |

**x402 Facilitator (Coinbase CDP):** `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` — central verification contract for ALL x402 payments on Base. Tracks the health of the entire agent payment ecosystem.

**Data limitations:**
- x402 Facilitator tracks ALL x402 ecosystem payments, not just Batches 003 projects
- BlockRunAI payments cannot be isolated from other x402 clients without wallet mapping
- Agently activity overlaps with ERC-8004 Registry section
- 4mica Vault contracts are testnet-only (token is live)
- Off-chain activity (API calls, LLM inference) not captured

**Inclusion criteria:**
- Participant of Base Batches 003 accelerator program
- Building infrastructure for agent economy on Base
- Focused on tooling (payments, discovery, credit) rather than token speculation
- Active development (GitHub commits, product releases)

**Color:** Teal (#14B8A6)
```

---

## ПОРЯДОК ДЕЙСТВИЙ НА DUNE — ЧЕКЛИСТ

### Предварительная подготовка

- [ ] **Шаг 0:** Прочитать весь этот документ
- [ ] **Шаг 0.1:** Проверить контракты на BaseScan:
  - x402 Facilitator: https://basescan.org/address/0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6
  - Floe Labs Lending: https://basescan.org/address/0x17946cD3e180f82e632805e5549EC913330Bb175
  - FLOE Token: https://basescan.org/token/0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e
  - 4MICA Token: https://basescan.org/token/0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab
- [ ] **Шаг 0.2:** Проверить существующий x402 query: https://dune.com/queries/7384630

### Создание запросов (27 апреля — пре-шаблон)

- [ ] **Шаг 1:** Создать (или обновить) Query 5.1 `Tools & Infra - On-chain Activity (Batches 3.0)`
  - Скопировать SQL из раздела [Query 5.1](#query-51-tools--infra--on-chain-activity)
  - Запустить (Run) и проверить результат
  - Если мало данных — это нормально, каунтеры покажут то что есть

- [ ] **Шаг 2:** Создать (или обновить) Query 5.2 `x402 Facilitator - Protocol Pulse (Base)`
  - Скопировать SQL из раздела [Query 5.2](#query-52-x402-facilitator--protocol-pulse)
  - Или обновить существующий: https://dune.com/queries/7384630
  - Запустить (Run) — должны быть данные с 2026-01-01

### Создание визуализаций (27 апреля)

- [ ] **Шаг 3:** Из Query 5.1 создать 2 Counter-визуализации:
  - Counter 1: x402 Facilitator Txs (Teal `#14B8A6`)
  - Counter 2: On-chain Contract Txs (Sky `#0EA5E9`)

- [ ] **Шаг 4:** Из Query 5.2 создать Mixed Chart (bar + line):
  - X: day, Bars: Daily x402 Txs (Teal), Line: Cumulative Txs (Dark Teal `#0F766E`)
  - Additional: Daily Unique Senders (Sky, dashed)
  - Заголовок: "x402 Protocol Pulse on Base"

### Размещение на дашборде (28 апреля — пре-финал)

- [ ] **Шаг 5:** Добавить Text Widget S5 (Info Boards)
  - Скопировать markdown из раздела [Text Widget S5](#text-widget-s5-section-header--info-boards)
  - Разместить на 12 колонок
  - **ВАЖНО:** Разместить НАД секциями gaming (gaming — последние)

- [ ] **Шаг 6:** Разместить 2 каунтера + мини-таблицу (РЯД S5-2)
  - Каунтеры: по 3 колонки
  - Таблица: 6 колонок

- [ ] **Шаг 7:** Разместить x402 Protocol Pulse chart (РЯД S5-3, 12 колонок)

- [ ] **Шаг 8:** Обновить Table of Contents
  - Добавить строку 8: Tools & Infrastructure
  - Перенумеровать gaming секции (9, 10)

- [ ] **Шаг 9:** Обновить Methodology footer
  - Добавить блок "Tools & Infrastructure (V3)"

### Финальная проверка (29 апреля — финал)

- [ ] **Шаг 10:** Проверить все виджеты
  - Инфоборды читаемы, ссылки работают
  - Каунтеры отображают данные (или 0 если нет)
  - x402 chart показывает данные
  - Секция расположена НАД gaming

- [ ] **Шаг 11:** Проверить мобильную версию

- [ ] **Шаг 12:** Ревью с командой перед релизом

---

## ДОПОЛНИТЕЛЬНЫЕ ЗАМЕТКИ

### Расширение в будущем (V4+)

По мере развития проектов можно добавить:
- [ ] BlockRunAI: после AMA уточнить wallet address для изоляции их txs из x402 потока
- [ ] 4mica: когда Vault запустится на mainnet — добавить контракт + метрики
- [ ] Agently: отслеживать ERC-8004 registrations, связанные с маркетплейсом
- [ ] Новые проекты Batches 003: OPAL, Credifi, Liminal и др.
- [ ] BlockRun: ожидаем дополнительную информацию от команды (запрошена через AMA)

### Связь с другими секциями

| Проект | Связь | Как |
|--------|-------|-----|
| BlockRunAI | Section 1 (Ecosystem Pulse) | x402 платежи → USDC transfers на Base |
| Agently | ERC-8004 Registry | Использует ERC-8004 для discovery |
| Floe Labs | Section 1 (Ecosystem Pulse) | Lending txs → общий подсчет |
| 4mica | ERC-8004 Registry | Может использовать для ID агентов |
| x402 Facilitator | Все секции | Общий "пульс" агентских платежей |

---

*Документ создан: Апрель 2026*
*Версия: V3.1 (инфоборды)*
*Формат: DuneSQL (Trino-based)*
*Совместимо с: https://dune.com/ax1research/base-agentic-ecosystem*
*Тестовый дашборд: https://dune.com/bossincrypto/test*
*Проекты: Base Batches 003 (BlockRunAI, Floe Labs, Agently, 4mica)*
