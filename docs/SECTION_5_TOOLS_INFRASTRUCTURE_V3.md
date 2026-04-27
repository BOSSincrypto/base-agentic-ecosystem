# РАЗДЕЛ 5: Tools & Infrastructure - Batches 3.0 (V3)

> **Дашборд:** `Base Agentic: The Birth of AI Economy`
> **URL:** https://dune.com/ax1research/base-agentic-ecosystem
> **Раздел:** Section 5 (Tools & Infrastructure - Batches 3.0)
> **Дата:** Апрель 2026, V3
> **Дедлайн:** 27 апреля (пре-шаблон) - 28 апреля (пре-финал) - 29 апреля (финальный релиз)
> **Источник:** Обсуждение команды AX1, 23-25 апреля 2026

---

## СОДЕРЖАНИЕ

1. [Общий план](#общий-план)
2. [Ключевые изменения V3](#ключевые-изменения-v3)
3. [Исследование проектов](#исследование-проектов)
4. [Section 5: Tools & Infrastructure](#section-5-tools--infrastructure)
   - Text Widget S5 (Section Header + Project Profiles)
   - Query 5.1 - Tools & Infra: On-chain Activity
   - Визуализации и оформление
5. [Обновление Table of Contents](#обновление-table-of-contents)
6. [Обновление Methodology (Footer)](#обновление-methodology-footer)
7. [Порядок действий на Dune - Чеклист](#порядок-действий-на-dune---чеклист)

---

## КЛЮЧЕВЫЕ ИЗМЕНЕНИЯ V3

Согласно обсуждению команды (AX1, Сергей RUA) от 23-25 апреля 2026:

| Изменение | Причина |
|-----------|---------|
| **Новая категория: Tools & Infrastructure** | Добавить проекты, которые "не генерят, а пропускают активность через себя" (@AX1) |
| **Фокус на Batches 3.0 (003)** | Все 4 проекта - участники Base Batches 003 accelerator (объявлено 9 апреля 2026) |
| **BlockRunAI как ключевой** | Главный проект секции, AI agent payment rail + LLM gateway (@AX1) |
| **Информационный подход** | "Не у всех токен запущен, ончейн активности минимум" (@Сергей) - "Да, по стате что получится" (@AX1) |
| **3 дополнительных проекта** | Floe Labs, Agently, 4mica - все Batches 003 |

### Что такое "Tools & Infrastructure"?
Отдельная категория от Infrastructure (Virtuals, Spectral, Clanker...) и Consumer (AWE, FAI, VADER...). Это **агентская инфраструктура нового поколения** - проекты Batches 3.0, которые строят:
- Платежные рельсы для агентов (x402 protocol)
- Маркетплейсы и роутинг для межагентного взаимодействия
- Кредитные протоколы для агентов (DeFi for agents)
- Системы микроплатежей и кредитных табов

**Ключевое отличие от Infrastructure:** эти проекты не запускают свои токены как основной продукт. Они строят "трубы", через которые проходит агентская активность.

---

## ОБЩИЙ ПЛАН

### Что добавляем

| Section | Queries | Widgets | Rows |
|---------|---------|---------|------|
| **5) Tools & Infrastructure (Batches 3.0)** | 3 queries | 1 text (header + profiles) + 4 counters + 1 table + 2 charts = **8-9** | 4-5 рядов |

### Где располагается

Новая секция добавляется **ПОСЛЕ** Section 4 (OWB Agentic Gaming), **ПЕРЕД** Methodology footer.

Текущий порядок на дашборде:
1. Ecosystem Pulse (KPIs)
2. Cross-Pollination Index
3. Daily Activity
4. Leaderboard
5. ERC-8004 Registry
6. Virtuals Protocol
7. Base vs Solana
8. Section 3: Base Agentic Gaming
9. Section 4: OWB Agentic Gaming
10. **-> Section 5: Tools & Infrastructure (Batches 3.0)** <-- НОВОЕ
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
| Growth/Positive | Green | `#10B981` |
| Decline/Negative | Red | `#EF4444` |

### Полная палитра дашборда (с V3)

| Category | Color | HEX |
|----------|-------|-----|
| Infrastructure (V1) | Blue | `#3B82F6` |
| Consumer/Agents (V1) | Purple | `#8B5CF6` |
| Agentic Gaming (V2) | Pink | `#EC4899` |
| OWB (V2) | Orange | `#F97316` |
| **Tools & Infrastructure (V3)** | **Teal** | **`#14B8A6`** |

---

## КАРТА LAYOUT (SECTION 5)

```
=====================================================================
  SECTION 5: TOOLS & INFRASTRUCTURE (BATCHES 3.0)
=====================================================================

РЯД S5-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ - 12 колонок]
          "Tools & Infrastructure: The Backbone of Agent Economy"
          + Project Profiles (BlockRunAI, Floe Labs, Agently, 4mica)

РЯД S5-2: [4 КАУНТЕРА из Query 5.1]
          | x402 Txs | Contract Txs | Unique Users | Token DEX Volume |

РЯД S5-3: [ТАБЛИЦА 5.1 - 7 кол.]  [ГРАФИК 5.1 - 5 кол.]
          On-chain Activity Table     Daily Activity (line chart)

РЯД S5-4: [ГРАФИК 5.3 - 12 кол.]
          x402 Facilitator Daily Activity (line chart)

=====================================================================
```

---

## ИССЛЕДОВАНИЕ ПРОЕКТОВ

### Base Batches 003 - Подтверждение

9 апреля 2026 Base объявила 12 проектов-участников Batches 003 accelerator. Все 4 проекта из нашего списка входят в эту когорту:

> PANews: "Base has announced the list of 12 selected projects for its Batches 003 accelerator program. The selected teams will showcase their work at Demo Day in San Francisco on May 19th."

Участники, релевантные для нашей секции:
- **Blockrun.ai** - AI agent infrastructure
- **Floe Labs** - AI agent credit protocol
- **Agently** - AI agent coordination and transaction routing layer
- **4Mica** - Credit tabs protocol (x402 facilitator)

### Детальные профили проектов

---

### 1. BlockRunAI (Ключевой проект)

| Параметр | Значение |
|----------|----------|
| **Название** | BlockRun / BlockRunAI |
| **Тип** | AI Agent Payment Rail + LLM Gateway |
| **Сайт** | [blockrun.ai](https://blockrun.ai) |
| **Twitter/X** | [@BlockRunAI](https://x.com/BlockRunAI) |
| **GitHub** | [github.com/BlockRunAI](https://github.com/BlockRunAI) |
| **Локация** | San Francisco, CA |
| **Протоколы** | x402, MCP (Model Context Protocol) |
| **Сети** | Base Mainnet (primary), Solana Mainnet, Base Sepolia |
| **Валюта платежей** | USDC |
| **Свой токен** | Нет |
| **Свой контракт** | Нет dedicated контракта. Платежи через x402 Facilitator (Coinbase CDP): `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` |

**Что делает:**
BlockRun - это платежный рельс для AI-агентов. Сервисный маркетплейс, где AI-агенты автономно находят, маршрутизируют и оплачивают API-сервисы с помощью USDC через x402 протокол. Без API-ключей, без подписок.

**Продукты:**
- **ClawRouter** - LLM-роутер, снижает затраты на API до 78% через 7-уровневую компрессию и intelligent routing. 6,247 звезд на GitHub. Open source (MIT).
- **AI Model Gateway** - Доступ к 41+ LLM (GPT-5, Claude, Gemini, Grok, DeepSeek, Kimi и др.) через единый OpenAI-совместимый endpoint
- **RunCode (brcc)** - AI coding agent, запускает Claude Code с любой моделью. 289 звезд на GitHub
- **BlockRun MCP** - MCP-сервер для Claude Code. 98+ звезд
- **Data Marketplace** - Neural web search (Exa), X/Twitter data, prediction markets (Predexon), sandbox compute (Modal)

**Как работает x402:**
1. AI-агент делает HTTP запрос к API
2. Сервер возвращает `402 Payment Required` с ценой
3. Агент подписывает USDC-платеж локально (приватный ключ не покидает машину агента)
4. Агент повторяет запрос с подписью платежа в заголовке
5. Сервер верифицирует оплату через x402 facilitator, отдает ответ

**Ончейн-следы:**
- Платежи проходят как USDC transfers на Base (и Solana) через x402 Facilitator
- **x402 Facilitator (Coinbase CDP):** `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` — верификационный контракт x402, помечен на BaseScan как "Coinbase: x402 Facilitator 1"
- Все x402 платежи (BlockRunAI, Agently, 4mica) проходят через этот facilitator
- По данным x402 исследования BlockRun (Dec 2025): ~63M транзакций, ~$7.5M USDC, 64K+ уникальных покупателей, 10K+ продавцов
- Base занимает ~53% share сети x402
- CDP Facilitator обрабатывает ~$2.5M/month (по данным xpay.sh)

**Почему ключевой:**
- Наибольшее количество GitHub-звезд среди Batches 003 agentic проектов (ClawRouter: 6,247)
- Доверенные партнеры: Circle, Coinbase, Solana
- 1M+ API calls/month
- AMA запланирована с командой AX1 (@AX1)

---

### 2. Floe Labs

| Параметр | Значение |
|----------|----------|
| **Название** | Floe Labs / Floe |
| **Тип** | Structured Credit Protocol (P2P Lending for Agents) |
| **Сайт** | [floelabs.xyz](https://www.floelabs.xyz/) |
| **App** | [app.floelabs.xyz](https://app.floelabs.xyz) |
| **Twitter/X** | [@FloeLabs](https://x.com/FloeLabs) |
| **GitHub** | Closed source (имеет bug bounty на Immunefi, до $50K) |
| **Протоколы** | DeFi, Intent-based lending |
| **Сеть** | Base Mainnet |
| **Валюта** | USDC, USDT (lending), WETH, cbBTC (collateral) |
| **Свой токен** | FLOE: `0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e` (deployed Apr 11, 2026) |
| **Контракт (lending)** | `0x17946cD3e180f82e632805e5549EC913330Bb175` |

**Что делает:**
Floe - первый "credit DEX" на Base. P2P intent-matching протокол для кредитования. Пользователи (или их AI-агенты) публикуют intents на lending/borrowing, которые матчатся ботами или вручную и исполняются ончейн как изолированные loan-контракты.

**Ключевые отличия от пулов (Aave, Compound):**
- Фиксированные ставки (не variable)
- Изолированный риск (один дефолт не влияет на других)
- Прямой matching (без пула-посредника)
- Фиксированный срок и maturity
- $480M в deal flow

**AI-агент "Lendr":**
- AI lending agent - настраивает займы на обычном английском
- Интеграция через chat на сайте и @LendrBot в X

**Ончейн-следы:**
- Контракт кредитования: `0x17946cD3e180f82e632805e5549EC913330Bb175` - **активный на Base**
- FLOE токен: `0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e` - deployed Apr 11, 2026
- Есть данные для SQL-запросов (txs, users, volume)

---

### 3. Agently

| Параметр | Значение |
|----------|----------|
| **Название** | Agently / use-agently |
| **Тип** | Agent Marketplace + Routing Layer |
| **Сайт** | [use-agently.com](https://use-agently.com/) |
| **Marketplace** | [use-agently.com/marketplace](https://use-agently.com/marketplace) |
| **Twitter/X** | [@AgentlyHQ](https://x.com/AgentlyHQ) |
| **GitHub** | [github.com/AgentlyHQ/use-agently](https://github.com/AgentlyHQ/use-agently) (68 звезд, MIT) |
| **Протоколы** | x402, A2A (Agent-to-Agent, Google), MCP, ERC-8004 |
| **Сеть** | Base Mainnet (primary), Ethereum Mainnet |
| **Валюта** | USDC (через x402) |
| **Свой токен** | Нет |
| **Контракт** | Использует ERC-8004 registry: `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432` (общий для всей экосистемы) |

**Что делает:**
Agently - маркетплейс и роутинг-слой для AI-агентов. CLI-инструмент, через который агенты находят друг друга, общаются (A2A), и оплачивают сервисы (x402). "DNS для AI-агентов" - routing and settlement layer.

**Продукты:**
- **CLI (use-agently)** - Управление кошельками, discovery агентов, A2A коммуникация
- **Marketplace** - Каталог агентов (Brave Search, X Research, Exa Search и др.) с фильтрами по протоколу (A2A, MCP) и сети (Base, Ethereum)
- **ERC-8004 Resolution** - Резолвит URI агентов в HTTP endpoints

**Как работает:**
1. `use-agently init` - создает EVM кошелек
2. `use-agently search` - ищет агентов на маркетплейсе
3. `use-agently a2a send --uri <agent-uri>` - отправляет сообщение агенту
4. Платежи через x402 - агент платит USDC за сервисы других агентов

**Ончейн-следы:**
- Привязан к ERC-8004 registry (уже отслеживается на дашборде)
- Сам не имеет dedicated контракта
- Активность проявляется в ERC-8004 registrations и x402 USDC transfers

---

### 4. 4mica

| Параметр | Значение |
|----------|----------|
| **Название** | 4mica (4Mica) |
| **Тип** | Instant Credit Tabs (x402 Facilitator) |
| **Сайт** | [4mica.xyz](https://4mica.xyz/) |
| **Docs** | [docs.4mica.xyz](https://docs.4mica.xyz/) |
| **Twitter/X** | [@4mica_xyz](https://x.com/4mica_xyz) |
| **GitHub** | [github.com/4mica-Network](https://github.com/4mica-Network) (12 repos) |
| **Протоколы** | x402 (4mica-credit scheme), BLS signatures |
| **Сеть** | Base Mainnet (токен), Ethereum Sepolia + Base Sepolia + Polygon Amoy (Vault тестнеты) |
| **Язык** | Rust (core), TypeScript + Python (SDKs) |
| **Свой токен** | 4MICA: `0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab` (deployed Apr 18, 2026 через Virtuals Protocol) |
| **Токен (старый)** | 4MICA (v1): `0x231375fbbf6abf2320d64be206c0478d551e2687` (5.5B supply, 14 holders, 41 transfer) |
| **Контракт (Vault)** | Только тестнеты (pre-alpha). Mainnet deployment TBD |

**Что делает:**
4mica - протокол мгновенных кредитных табов для агентов. "Откройте таб, позвольте пользователям тратить сейчас, рассчитываться через 7 дней" с некастодиальными, collateral-backed гарантиями.

**Архитектура:**
- **Vault (Core Contract)** - ончейн контракт для депозитов и collateral
- **Facilitator (Core Service)** - off-chain сервис для верификации обещаний и агрегации
- **BLS-signed guarantees** - криптографические доказательства для каждого запроса на расход
- **x402 интеграция** - 4mica как facilitator для x402 платежей (scheme: `4mica-credit`)

**Как работает:**
1. Получатель открывает таб (POST /tabs)
2. Пользователь тратит в кредит - подписывает BLS-гарантии без предоплаты
3. Через 7 дней пользователь рассчитывается ончейн
4. Если не рассчитался - Vault выплачивает из collateral

**Ончейн-следы:**
- **4MICA Token (новый):** `0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab` — deployed Apr 18, 2026, 5.7B supply, 13 holders. Создан через Virtuals Protocol (virtualToken)
- **4MICA Token (старый):** `0x231375fbbf6abf2320d64be206c0478d551e2687` — 5.5B supply, 14 holders, 41 transfer
- Vault (core protocol contract) пока только на тестнетах (Sepolia, Base Sepolia)
- Недавно добавлена поддержка Base Sepolia (commit от 12 апреля 2026)
- Активы: ETH, USDC, USDT
- **Vault не имеет mainnet deployment** — но токен уже на Base mainnet

---

## СВОДНАЯ ТАБЛИЦА КОНТРАКТОВ

| Project | Address | Network | Type | Status |
|---------|---------|---------|------|--------|
| x402 Facilitator (Coinbase CDP) | `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` | Base Mainnet | x402 Payment Verification | **Active** (shared by all x402 projects) |
| Floe Labs (Lending) | `0x17946cD3e180f82e632805e5549EC913330Bb175` | Base Mainnet | Lending Protocol (ERC1967Proxy) | **Active** (592 txs) |
| Floe Labs (FLOE Token) | `0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e` | Base Mainnet | ERC-20 Token | **Active** (14 holders, 50 transfers) |
| 4MICA Token (current) | `0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab` | Base Mainnet | ERC-20 (via Virtuals Protocol) | **Active** (13 holders, Apr 18, 2026) |
| 4MICA Token (v1) | `0x231375fbbf6abf2320d64be206c0478d551e2687` | Base Mainnet | ERC-20 (via Virtuals Protocol) | **Active** (14 holders, 41 transfers) |
| ERC-8004 Registry | `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432` | Base Mainnet | Identity Registry | **Active** (shared, used by Agently) |
| BlockRunAI | N/A | Base Mainnet | USDC via x402 Facilitator | No dedicated contract |
| Agently | N/A | Base Mainnet | Uses ERC-8004 + x402 | No dedicated contract |
| 4mica (Vault) | TBD | Base Sepolia | Credit Tabs | **Testnet only** |

---

## SECTION 5: TOOLS & INFRASTRUCTURE

### TEXT WIDGET S5 (Section Header + Project Profiles)

**Тип виджета:** Text Widget
**Ширина:** 12 колонок (full-width)
**Расположение:** РЯД S5-1

**Текст для copy-paste в Dune:**

```markdown
## Tools & Infrastructure: The Backbone of Agent Economy

**Category: Batches 3.0 Agentic Tooling**

This section tracks infrastructure projects from Base Batches 003 accelerator that enable the agent economy - tools that don't generate activity themselves, but facilitate and route activity through the ecosystem.

Unlike token-centric projects in the Leaderboard, these are the "pipes and rails" - payment infrastructure, agent discovery layers, credit protocols, and coordination tools that agents depend on to operate.

---

### Key Project: BlockRunAI

**The payment rail for AI.** A service marketplace where AI agents autonomously discover, route, and pay for APIs using USDC via x402. Access 41+ LLM models, real-time data, and compute - no API keys, no subscriptions. Pay per request.

- ClawRouter: Open-source LLM router (6,200+ GitHub stars)
- RunCode: AI coding agent with 41+ model access
- Networks: Base (primary), Solana
- Partners: Circle, Coinbase, Solana

[blockrun.ai](https://blockrun.ai) | [@BlockRunAI](https://x.com/BlockRunAI)

---

### Floe Labs

**Structured credit for AI agents.** The first credit DEX on Base - P2P intent-matching protocol where agents and users post lending/borrowing intents with fixed rates and isolated risk. No pools.

- AI Agent: Lendr - natural language lending assistant
- $480M deal flow pipeline
- Lending contract live on Base

[floelabs.xyz](https://www.floelabs.xyz/) | [@FloeLabs](https://x.com/FloeLabs)

---

### Agently

**The routing layer for agent economy.** Marketplace and CLI where AI agents discover each other, communicate (A2A), and transact (x402). "DNS for AI agents."

- Protocols: x402, A2A (Google), MCP, ERC-8004
- Agent marketplace with 50+ registered agents
- Works with OpenClaw, Claude Code, Cursor, Copilot

[use-agently.com](https://use-agently.com/) | [@AgentlyHQ](https://x.com/AgentlyHQ)

---

### 4mica

**Instant credit tabs for agents.** Open a tab, let agents spend now, settle after 7 days. Non-custodial, BLS-backed cryptographic guarantees.

- x402 facilitator (4mica-credit scheme)
- SDKs: Rust, TypeScript, Python
- 4MICA token live on Base (via Virtuals Protocol)
- Vault contracts in alpha (testnet)

[4mica.xyz](https://4mica.xyz/) | [@4mica_xyz](https://x.com/4mica_xyz)

---

*All four projects are participants of Base Batches 003 accelerator (announced April 9, 2026). Demo Day: May 19, San Francisco.*

**Protocol Stack:** x402 (payments) + ERC-8004 (identity) + A2A (communication) + MCP (tools)
```

---

### QUERY 5.1: Tools & Infra - On-chain Activity

#### Что он делает
Отслеживает ончейн-активность проектов Tools & Infrastructure на Base:
- Floe Labs (lending contract + FLOE token)
- 4MICA token (deployed via Virtuals Protocol)
- x402 Facilitator (Coinbase CDP) — общий контракт для всех x402 платежей

#### На какие вопросы отвечает
- Какая общая ончейн-активность у проектов Tools & Infrastructure?
- Сколько транзакций проходит через x402 Facilitator?
- Каков объем торгов у FLOE и 4MICA токенов?
- Какова динамика (WoW)?

#### Название запроса при сохранении
`Tools & Infra - On-chain Activity (Batches 3.0)`

#### SQL-код

```sql
-- Tools & Infrastructure: On-chain Activity (Batches 3.0)
-- V3: Tracks on-chain metrics for Batches 003 projects on Base
-- Contracts: Floe Labs (lending), x402 Facilitator (Coinbase CDP)
-- Tokens: FLOE, 4MICA (both versions)
-- Note: BlockRunAI and Agently have no dedicated contracts

WITH tool_contracts AS (
    SELECT address, name FROM (
        VALUES
        -- Floe Labs: Lending Protocol (ERC1967Proxy, 592+ txs)
        (0x17946cD3e180f82e632805e5549EC913330Bb175, 'Floe Labs (Lending)'),
        -- Floe Labs: FLOE Token (ERC-20, 14 holders)
        (0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e, 'Floe Labs (FLOE Token)'),
        -- x402 Facilitator (Coinbase CDP) — all x402 payments verified here
        (0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6, 'x402 Facilitator (Coinbase)')
    ) AS t(address, name)
),

-- Daily transactions to tracked contracts
daily_activity AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        tc.name AS project,
        COUNT(*) AS txs,
        COUNT(DISTINCT t."from") AS unique_users
    FROM base.transactions t
    INNER JOIN tool_contracts tc
        ON t."to" = tc.address
    WHERE t.block_time >= DATE '2026-04-01'
      AND t.success = true
    GROUP BY 1, 2
),

-- Aggregate totals
totals AS (
    SELECT
        SUM(txs) AS total_txs,
        SUM(unique_users) AS total_unique_users
    FROM daily_activity
),

-- x402 Facilitator specific metrics
x402_metrics AS (
    SELECT
        COALESCE(SUM(txs), 0) AS x402_txs,
        COALESCE(SUM(unique_users), 0) AS x402_users
    FROM daily_activity
    WHERE project = 'x402 Facilitator (Coinbase)'
),

-- Combined token DEX volume (FLOE + 4MICA on Base)
token_dex AS (
    SELECT
        ROUND(COALESCE(SUM(amount_usd), 0), 2) AS token_volume_usd,
        COUNT(*) AS token_trades,
        COUNT(DISTINCT taker) AS token_traders
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
),

-- WoW: current 7d vs previous 7d
wow_current AS (
    SELECT
        COALESCE(SUM(txs), 0) AS txs_7d
    FROM daily_activity
    WHERE day >= DATE_TRUNC('day', NOW()) - INTERVAL '7' DAY
      AND day < DATE_TRUNC('day', NOW())
),

wow_prev AS (
    SELECT
        COALESCE(SUM(txs), 0) AS txs_prev_7d
    FROM daily_activity
    WHERE day >= DATE_TRUNC('day', NOW()) - INTERVAL '14' DAY
      AND day < DATE_TRUNC('day', NOW()) - INTERVAL '7' DAY
)

SELECT
    COALESCE(tot.total_txs, 0) AS "Total Txs",
    COALESCE(tot.total_unique_users, 0) AS "Unique Users",
    x4.x402_txs AS "x402 Facilitator Txs",
    x4.x402_users AS "x402 Unique Users",
    td.token_volume_usd AS "Token DEX Volume (USD)",
    td.token_trades AS "Token Trades",
    td.token_traders AS "Token Traders",
    CASE
        WHEN wp.txs_prev_7d > 0
        THEN ROUND(100.0 * (wc.txs_7d - wp.txs_prev_7d) / NULLIF(wp.txs_prev_7d, 0), 1)
        ELSE 0
    END AS "WoW Growth %"
FROM totals tot
CROSS JOIN x402_metrics x4
CROSS JOIN token_dex td
CROSS JOIN wow_current wc
CROSS JOIN wow_prev wp
```

**Примечания:**
- x402 Facilitator (`0xDbDf...`) — центральный контракт верификации x402 платежей Coinbase CDP. Через него проходят ВСЕ x402 платежи на Base (BlockRunAI, Agently, 4mica и другие). Обрабатывает ~$2.5M/month
- 4MICA токен обнаружен в двух версиях: `0x33f2df...` (Apr 18, 2026, 5.7B supply) и `0x231375...` (v1, 5.5B supply). Оба deployed через Virtuals Protocol
- FLOE токен: 14 holders, 50 transfers, deployed Apr 11, 2026
- BlockRunAI платежи проходят через x402 Facilitator (trackable!), но невозможно отделить BlockRunAI от других x402 клиентов
- Agently использует ERC-8004 (уже отслеживается в ERC-8004 Registry)
- WoW: rolling 7d через `DATE_TRUNC('day', NOW())` (как в v2)

---

### QUERY 5.2: Tools & Infra - Daily Trend

#### Что он делает
Показывает дневную динамику активности для line chart.

#### Название запроса при сохранении
`Tools & Infra - Daily Activity Trend`

#### SQL-код

```sql
-- Tools & Infrastructure: Daily Activity Trend
-- V3: Daily transactions and users for Batches 003 projects on Base
-- Includes: Floe Labs contracts + x402 Facilitator + FLOE/4MICA token DEX

WITH tool_contracts AS (
    SELECT address, name FROM (
        VALUES
        (0x17946cD3e180f82e632805e5549EC913330Bb175, 'Floe Labs (Lending)'),
        (0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e, 'Floe Labs (FLOE Token)'),
        (0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6, 'x402 Facilitator')
    ) AS t(address, name)
),

daily_stats AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS daily_txs,
        COUNT(DISTINCT t."from") AS daily_users
    FROM base.transactions t
    INNER JOIN tool_contracts tc
        ON t."to" = tc.address
    WHERE t.block_time >= DATE '2026-04-01'
      AND t.success = true
    GROUP BY 1
),

-- x402 Facilitator daily breakdown
daily_x402 AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS x402_txs,
        COUNT(DISTINCT t."from") AS x402_users
    FROM base.transactions t
    WHERE t."to" = 0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6
      AND t.block_time >= DATE '2026-04-01'
      AND t.success = true
    GROUP BY 1
),

-- Combined token DEX trades (FLOE + 4MICA)
daily_dex AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        COUNT(*) AS dex_trades,
        ROUND(COALESCE(SUM(amount_usd), 0), 2) AS dex_volume_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          -- FLOE
          token_bought_address = 0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e
          OR token_sold_address = 0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e
          -- 4MICA (current)
          OR token_bought_address = 0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab
          OR token_sold_address = 0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab
          -- 4MICA (v1)
          OR token_bought_address = 0x231375fbbf6abf2320d64be206c0478d551e2687
          OR token_sold_address = 0x231375fbbf6abf2320d64be206c0478d551e2687
      )
      AND block_time >= DATE '2026-04-01'
    GROUP BY 1
)

SELECT
    COALESCE(ds.day, COALESCE(dx.day, dd.day)) AS day,
    COALESCE(ds.daily_txs, 0) AS "Contract Txs",
    COALESCE(ds.daily_users, 0) AS "Active Users",
    COALESCE(dx.x402_txs, 0) AS "x402 Facilitator Txs",
    COALESCE(dx.x402_users, 0) AS "x402 Users",
    COALESCE(dd.dex_trades, 0) AS "Token DEX Trades",
    COALESCE(dd.dex_volume_usd, 0) AS "Token Volume (USD)"
FROM daily_stats ds
FULL OUTER JOIN daily_x402 dx ON ds.day = dx.day
FULL OUTER JOIN daily_dex dd ON ds.day = dd.day
ORDER BY 1
```

---

### QUERY 5.3: x402 Facilitator - Protocol Pulse

#### Что он делает
Отдельный запрос специально для x402 Facilitator (Coinbase CDP). Показывает масштаб x402 экосистемы на Base — все платежи, которые проходят через facilitator, включая BlockRunAI, Agently, и любых других x402 клиентов.

#### Название запроса при сохранении
`x402 Facilitator - Protocol Pulse (Base)`

#### SQL-код

```sql
-- x402 Facilitator: Protocol Pulse on Base
-- Tracks ALL x402 payment verifications through Coinbase CDP Facilitator
-- Address: 0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6
-- This covers BlockRunAI, Agently, and all other x402 clients

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

**Примечания к Query 5.3:**
- Этот запрос показывает ВСЮ x402 активность на Base, не только Batches 003 проекты
- Дата начала: 2026-01-01 (x402 facilitator активен с мая 2025, но для наглядности берём с начала года)
- Cumulative линии показывают рост принятия x402 протокола
- Хороший индикатор здоровья всей агентской экономики на Base

---

### Визуализации: 3 Каунтера (РЯД S5-2)

Из Query 5.1 создаем **4 Counter-визуализации**:

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **x402 Facilitator Txs** | `x402 Facilitator Txs` | Number | Teal `#14B8A6` | 3 кол. |
| 2 | **Total Contract Txs** | `Total Txs` | Number | Sky `#0EA5E9` | 3 кол. |
| 3 | **Unique Users** | `Unique Users` | Number | Indigo `#6366F1` | 3 кол. |
| 4 | **Token DEX Volume** | `Token DEX Volume (USD)` | USD, 0 десятичных | Green `#10B981` | 3 кол. |

**Как создать каунтер в Dune:**
1. Открой запрос `Tools & Infra - On-chain Activity (Batches 3.0)` -> Run
2. Нажми **New visualization** -> выбери **Counter**
3. В поле **Column** выбери нужную колонку (напр. `Total Txs`)
4. В **Title** впиши название
5. В **Prefix** поставь `$` для USD-метрик
6. В **Suffix** поставь `%` для WoW Growth (если добавляешь 4-й каунтер)
7. Повтори для каждого каунтера

### Визуализация: Таблица (РЯД S5-3, левая часть)

Из Query 5.1 создаем таблицу с ключевыми метриками:

| Настройка | Значение |
|-----------|----------|
| **Тип** | Table |
| **Ширина** | 7 колонок |
| **Заголовок** | `Tools & Infrastructure: On-chain Metrics` |
| **Колонки** | Total Txs, Unique Users, x402 Facilitator Txs, Token DEX Volume (USD), Token Trades, WoW Growth % |

### Визуализация: Line Chart (РЯД S5-3, правая часть)

Из Query 5.2 создаем line chart:

| Настройка | Значение |
|-----------|----------|
| **Тип** | Line Chart |
| **Ширина** | 5 колонок |
| **Заголовок** | `Daily Activity: Tools & Infrastructure` |
| **X-axis** | `day` |
| **Y-axis (left)** | `Contract Txs` (Teal `#14B8A6`), `x402 Facilitator Txs` (Indigo `#6366F1`) |
| **Y-axis (right)** | `Token Volume (USD)` (Green `#10B981`) |
| **Additional lines** | `Active Users` (Sky `#0EA5E9`, dashed) |
| **Не использовать** | Log scale (не считывается визуально) |

---

## ОБНОВЛЕНИЕ TABLE OF CONTENTS

### Текущий Table of Contents на дашборде (V2)

Найти текущий текст Table of Contents и заменить на обновленный:

**Старый текст (найти на Dune):**
```
(Текущий Table of Contents без Section 5)
```

**Новый текст (заменить):**
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
| 8 | Base Agentic Gaming | Gaming transactions, players, project comparison |
| 9 | OWB Agentic Gaming | DTU, NFT revenue, retention, Agentic Passes |
| **10** | **Tools & Infrastructure** | **Batches 3.0 agentic tooling: BlockRunAI, Floe Labs, Agently, 4mica** |
```

---

## ОБНОВЛЕНИЕ METHODOLOGY (Footer)

### Добавить в существующий Methodology текст

Найти секцию Methodology footer на дашборде и **добавить** следующий блок:

```markdown
### Tools & Infrastructure (V3 - April 2026)

**What we track:** Infrastructure projects from Base Batches 003 accelerator that enable the agent economy - payment rails, agent discovery, credit protocols, and coordination tools.

**Category definition:** Projects that don't generate on-chain activity themselves, but facilitate and route activity through the ecosystem. The "pipes and rails" of the agent economy.

**Tracked projects:**

| Project | Role | On-chain Data |
|---------|------|--------------|
| BlockRunAI | AI agent payment rail + LLM gateway (x402) | No dedicated contract; USDC micropayments |
| Floe Labs | Structured credit protocol for agents | Lending contract + FLOE token (active) |
| Agently | Agent marketplace + routing layer (A2A, MCP) | Uses shared ERC-8004 registry |
| 4mica | Instant credit tabs (x402 facilitator) | 4MICA token live on Base; Vault testnet only |

**Data limitations:**
- x402 Facilitator tracks ALL x402 ecosystem payments, not just Batches 003 projects
- BlockRunAI payments go through x402 Facilitator but cannot be isolated from other x402 clients
- Agently activity overlaps with ERC-8004 Registry section
- 4mica has token on Base (via Virtuals Protocol) but Vault contracts are still testnet-only
- Stats reflect available on-chain data; these projects have significant off-chain activity not captured here

**Inclusion criteria:**
- Participant of Base Batches 003 accelerator program
- Building infrastructure for agent economy on Base
- Focused on tooling (payments, discovery, credit) rather than token speculation
- Active development (GitHub commits, product releases)

**Color:** Teal (#14B8A6)
```

---

## ПОРЯДОК ДЕЙСТВИЙ НА DUNE - ЧЕКЛИСТ

### Предварительная подготовка (до 27 апреля)

- [ ] **Шаг 0:** Прочитать весь этот документ
- [ ] **Шаг 0.1:** Проверить актуальность контрактов:
  - x402 Facilitator (Coinbase CDP): https://basescan.org/address/0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6
  - Floe Labs Lending: https://basescan.org/address/0x17946cD3e180f82e632805e5549EC913330Bb175
  - FLOE Token: https://basescan.org/token/0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e
  - 4MICA Token (current): https://basescan.org/token/0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab
  - 4MICA Token (v1): https://basescan.org/token/0x231375fbbf6abf2320d64be206c0478d551e2687

### Создание запросов (27 апреля - пре-шаблон)

- [ ] **Шаг 1:** Создать Query 5.1 `Tools & Infra - On-chain Activity (Batches 3.0)`
  - Скопировать SQL из раздела [Query 5.1](#query-51-tools--infra---on-chain-activity)
  - Запустить (Run) и проверить результат
  - Если Floe Labs еще не имеет достаточно транзакций - это нормально, каунтеры покажут 0

- [ ] **Шаг 2:** Создать Query 5.2 `Tools & Infra - Daily Activity Trend`
  - Скопировать SQL из раздела [Query 5.2](#query-52-tools--infra---daily-trend)
  - Запустить (Run) и проверить наличие данных

- [ ] **Шаг 2.1:** Создать Query 5.3 `x402 Facilitator - Protocol Pulse (Base)`
  - Скопировать SQL из раздела [Query 5.3](#query-53-x402-facilitator---protocol-pulse)
  - Запустить (Run) — должны быть данные с 2026-01-01

### Создание визуализаций (27 апреля)

- [ ] **Шаг 3:** Из Query 5.1 создать 4 Counter-визуализации:
  - Counter 1: x402 Facilitator Txs (Teal)
  - Counter 2: Total Contract Txs (Sky)
  - Counter 3: Unique Users (Indigo)
  - Counter 4: Token DEX Volume ($, Green)

- [ ] **Шаг 4:** Из Query 5.2 создать Line Chart:
  - X: day, Y-left: Contract Txs (Teal) + x402 Txs (Indigo), Y-right: Token Volume (Green)
  - Дополнительно: Active Users (Sky, dashed)

- [ ] **Шаг 4.1:** Из Query 5.3 создать Line Chart (full-width, 12 кол.):
  - X: day, Y-left: Daily x402 Txs (Teal, bars), Y-right: Cumulative x402 Txs (dark teal `#0F766E`, line)
  - Заголовок: "x402 Protocol Pulse on Base"

### Размещение на дашборде (28 апреля - пре-финал)

- [ ] **Шаг 5:** Добавить Text Widget S5 (Section Header + Project Profiles)
  - Скопировать markdown из раздела [Text Widget S5](#text-widget-s5-section-header--project-profiles)
  - Разместить на 12 колонок, ПОСЛЕ Section 4 (OWB Agentic Gaming)

- [ ] **Шаг 6:** Разместить 4 каунтера (РЯД S5-2)
  - По 3 колонки каждый

- [ ] **Шаг 7:** Разместить таблицу (7 кол.) и line chart (5 кол.) в РЯД S5-3

- [ ] **Шаг 7.1:** Разместить x402 Protocol Pulse chart (12 кол.) в РЯД S5-4

- [ ] **Шаг 8:** Обновить Table of Contents
  - Добавить строку 10: Tools & Infrastructure

- [ ] **Шаг 9:** Обновить Methodology footer
  - Добавить блок "Tools & Infrastructure (V3)"

### Финальная проверка (29 апреля - финал)

- [ ] **Шаг 10:** Проверить все виджеты на дашборде
  - Тексты читаемы
  - Ссылки работают
  - Каунтеры отображают данные (или 0 если нет активности)
  - Line chart не пустой

- [ ] **Шаг 11:** Проверить мобильную версию
  - Виджеты не наезжают друг на друга
  - Текст не обрезается

- [ ] **Шаг 12:** Ревью с командой перед финальным релизом

---

## ДОПОЛНИТЕЛЬНЫЕ ЗАМЕТКИ

### Что делать если у Floe Labs нет данных?

Если на момент реализации FLOE токен или lending контракт не имеют значимой активности:
1. Каунтеры покажут 0 - это нормально и ожидаемо
2. Текстовый виджет с описаниями проектов - основная ценность секции
3. Можно временно скрыть каунтеры и chart, оставив только текст

### Расширение в будущем (V4+)

По мере развития проектов можно добавить:
- [ ] BlockRunAI: после AMA уточнить wallet address для изоляции BlockRunAI txs из общего x402 потока
- [ ] 4mica: когда Vault запустится на Base mainnet - добавить в `tool_contracts` CTE
- [ ] Agently: отслеживать ERC-8004 registrations, связанные с маркетплейсом Agently
- [ ] Новые проекты Batches 003: OPAL, Credifi, Liminal и др. если будут relевантны для agentic dashboard
- [ ] x402 Protocol Pulse: глобальная метрика x402 транзакций на Base (если появится indexer)
- [ ] Agent Economy Cross-reference: связь между Tools & Infra проектами и другими секциями дашборда

### Связь с другими секциями дашборда

| Этот проект | Связь с секцией | Как связаны |
|-------------|----------------|-------------|
| BlockRunAI | Section 1 (Ecosystem Pulse) | x402 платежи увеличивают общий объем USDC transfers на Base |
| Agently | Section 5 (ERC-8004 Registry) | Agently использует ERC-8004 для discovery агентов |
| Floe Labs | Section 1 (Ecosystem Pulse) | Lending txs входят в общий подсчет Base transactions |
| 4mica | Section 5 (ERC-8004 Registry) | Может использовать ERC-8004 для идентификации агентов |

### AMA с BlockRunAI

@AX1 упоминал запланированную AMA с BlockRunAI ("там же +- у нас АМА с blockrun"). После AMA может появиться дополнительная информация о:
- Wallet addresses для отслеживания x402 платежей
- Статистика по API calls и пользователям
- Планы по mainnet deployment контрактов

---

*Документ создан: Апрель 2026*
*Версия: V3*
*Формат: DuneSQL (Trino-based)*
*Совместимо с: https://dune.com/ax1research/base-agentic-ecosystem*
*Проекты: Base Batches 003 (BlockRunAI, Floe Labs, Agently, 4mica)*
