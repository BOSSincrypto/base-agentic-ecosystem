# РАЗДЕЛ 5: Tools & Infrastructure - Batches 3.0 (V3)

> **Дашборд:** `Base Agentic: The Birth of AI Economy`
> **URL:** https://dune.com/ax1research/base-agentic-ecosystem
> **Раздел:** Section 5 (Tools & Infrastructure - Batches 3.0)
> **Дата:** Апрель-Май 2026, V3
> **Дедлайн:** Пятница вечер (перенесён с 29 апреля)
> **Источник:** Обсуждение команды AX1, 23–30 апреля 2026
> **Тестовый дашборд:** https://dune.com/bossincrypto/test
> **Исследование:** @Hempanda (deep research, 28–30 апреля 2026)

---

## СОДЕРЖАНИЕ

1. [Ключевые изменения V3](#ключевые-изменения-v3)
2. [Критические исправления (Hempanda research, Apr 28-30)](#критические-исправления)
3. [Общий план](#общий-план)
4. [Инфоборды проектов](#инфоборды-проектов)
   - BlockRunAI (ключевой) — ⚠️ контракт не подтверждён
   - Floe Labs (facilitator only) — слабые метрики
   - Agently (off-chain data) — ~2K агентов, не 7770
   - 4mica — ❌ нет верифицированного контракта
   - **NEW:** Clash of Coins x402 — реальная агентская активность
5. [Section 5: Tools & Infrastructure](#section-5-tools--infrastructure)
   - Text Widget S5 (Section Header + Info Boards)
   - Query 5.1 — BlockRunAI On-chain Activity (@Hempanda)
   - Query 5.2 — Floe Labs Lending Activity (@Hempanda)
   - Query 5.3 — Agently Off-chain Catalog (@Hempanda)
   - Query 5.4 — Clash of Coins x402 Agent Activity (@Hempanda)
   - Визуализации и оформление
6. [Обновление Table of Contents](#обновление-table-of-contents)
7. [Обновление Methodology (Footer)](#обновление-methodology-footer)
8. [Порядок действий на Dune — Чеклист](#порядок-действий-на-dune--чеклист)

---

## КЛЮЧЕВЫЕ ИЗМЕНЕНИЯ V3

Согласно обсуждению команды (AX1, Сергей RUA, BOSSincrypto, Hempanda) от 23–30 апреля 2026:

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
| **Дедлайн перенесён** | "Давай до вечера пятницы дедлайн перенесём" | @BOSSincrypto, 29.04 |
| **Без BlockRun подтверждения** | "blockrun очень медленные, пока задерживается... давай с текущим тогда" | @AX1, 30.04 |

---

## КРИТИЧЕСКИЕ ИСПРАВЛЕНИЯ

> **⚠️ ВАЖНО:** Результаты deep research @Hempanda (28–30 апреля 2026) выявили серьёзные ошибки в предыдущих версиях документа. Все изменения ниже обязательны.

### 1. 4MICA Token — ❌ SCAM

**Старые адреса (УДАЛЕНЫ):**
- ~~`0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab`~~ — **СКАМ, НЕ их токен**
- ~~`0x231375fbbf6abf2320d64be206c0478d551e2687`~~ — **СКАМ, НЕ их токен**

> "@Hempanda: 4Mica токен контракты - там скам, а не их токен (я их настоящего токена не нашёл)" — 29.04, 06:17
>
> "@Hempanda: с 4mica пошерстил гитхаб их, сайт - адреса контракта нет, если есть возможность узнать - было бы хорошо" — 29.04, 06:21

**Статус:** Нет верифицированного контракта. Продолжается поиск.

### 2. FLOE Token — ❌ RUGPULL

**Старый адрес (УДАЛЁН):**
- ~~`0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e`~~ — **РАГПУЛЛ, НЕ их токен**

> "@Hempanda: и с Floe тоже такая же история, там контракт рагпулла" — 29.04, 06:18

**Реальный адрес:** Только facilitator `0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1` — принимает залоги под выдачу кредитов. Но метрики очень слабые.

### 3. Floe Labs Lending — реальный facilitator найден

**Старый lending contract (`0x17946cD3e180f82e632805e5549EC913330Bb175`)** — статус неясен (может быть рабочим, но @Hempanda идентифицировал другой адрес как основной).

**Реальный facilitator:** `0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1`
- 8 транзакций (по данным BaseScan на 30.04.2026)
- Функции: Register Borrow, Approve, Swap, Set Operator
- Баланс: $327.88 (ETH + cbBTC + USDT)
- Первая транзакция: 09.03.2026
- Последняя активность: 29.04.2026

> "@Hempanda: по этим товарищам - floelabs - у них свой отдельный фасилитатор по адресу 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1, который принимает залоги под выдачу кредитов. Судя по транзам, там всё пока очень-очень-очень скромно" — 29.04, 02:19
>
> "@Hempanda: floelabs (лендинг контракт): https://dune.com/queries/7397253 — чарты не рисовал, там всё уныло — видимо, пока тестируют. Обороты — 4 уникальных адреса вернули кредитов на 20 долларов, всего в систему было добавлено залогов на 0.0052 weth и 0.00002 cbBTC (итого 13 долларов)" — 29.04, 05:56

### 4. BlockRunAI — контракт найден, НЕ подтверждён

**Найденный контракт:** `0xe9030014F5DAe217d0A152f02A043567b16c1aBf` ⚠️ **UNCONFIRMED**
- 155 транзакций (по данным BaseScan)
- Баланс: $12,615 USDC (99.98% портфеля)
- Последняя активность: 11.03.2026 (49 дней назад)
- Funded: 12.02.2026
- **Готовый Dune query:** https://dune.com/queries/7396448/

> "@Hempanda: пришлось порыться, но нашёл контракт блокрана" — 29.04, 00:39
>
> "@Hempanda: на всякий случай нужно хотя бы получить подтверждение от них, что 0xe9030014F5DAe217d0A152f02A043567b16c1aBf это всё-таки их адрес контракта =) Мало ли чего я там осинтом нарыл" — 29.04, 00:44

### 5. x402 Facilitators — их МНОГО, они ротируются

**Старое понимание:** Один x402 Facilitator (`0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6`).

**Новое понимание:**
> "@Hempanda: есть нюанс — кодбейз фасилитаторы на х402 часто не хардкодятся в проектах, а ротируются на стороне кодбейза, и там их МНОГО" — 28.04, 02:56

Coinbase CDP Facilitator (`0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6`) — один из многих. @Hempanda собирал полный лист фасилитаторов x402 на Base.

### 6. Agently — реально ~2K агентов (не 7770 как маркетируют)

> "@Hempanda: ну живое оказалось надутое, по факту у них там в базе не 7770 агентов, как они в маркетплейсе указывают, а 2к" — 29.04, 17:06

**Off-chain data доступна:** https://dune.com/queries/7401373/11337310 — каталог агентов по chain/type/виду.

### 7. NEW: Clash of Coins — реальная x402 агентская активность!

> "@Hempanda: но есть и хорошие новости — я нашёл транзы х402 тру агентика на СоС" — 29.04, 17:18

**PayTo address:** `0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d`
- 68 транзакций
- $21,582 USDC баланс
- Funded by Binance (1 yr 288 days ago)
- Реальные x402 агентские платежи!

**Логика:** По адресу https://x402.clashofcoins.com/shop/x402/offers есть инструкция агентам, как платить через x402. В payload указан `"payTo": "0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d"`.

**Dune query:** https://dune.com/queries/7400157/11335903

---

### Итоговый статус от @Hempanda (29.04, 21:33)

> "в сухом остатке:
> • ключевой из них BlockRunAI — дата готова для вставки в даш: https://dune.com/queries/7396448/
> • дополнительные:
>   - floelabs — дата есть, но метрики проекта слабые, можем вставить на будущее: https://dune.com/queries/7397253
>   - agently — дата есть с оффчейна: https://dune.com/queries/7401373/11337310
>   - 4mica — по ним даты нет, продолжаю ковыряться, но вряд ли к выпуску что-то успеем
> • агентик Clash of Coins тут: https://dune.com/queries/7400157/11335903"

---

## ОБЩИЙ ПЛАН

### Формат: Инфоборды

По рекомендации @Сергей — секция оформляется **как инфоборды** (info boards) по проектам:
- Каждый проект получает **текстовый блок-описание** (что делает, ключевые метрики, ссылки)
- Проекты с ончейн-данными → **подраздел с метриками** ниже описания
- Проекты без mainnet данных → **метка "Coming Soon"** или ⚠️ предупреждение
- KPI-каунтеры минимальны — только там, где есть реальные данные

### Что добавляем

| Section | Queries | Widgets | Rows |
|---------|---------|---------|------|
| **5) Tools & Infrastructure (Batches 3.0)** | 4 queries (от @Hempanda) | 1 text (header + 5 info boards) + каунтеры + charts = **6-8** | 4-5 рядов |

### Готовые Dune Queries от @Hempanda

| Query | URL | Проект | Статус |
|-------|-----|--------|--------|
| **BlockRunAI Activity** | https://dune.com/queries/7396448/ | BlockRunAI | ⚠️ Контракт не подтверждён |
| **Floe Labs Lending** | https://dune.com/queries/7397253 | Floe Labs | Метрики слабые |
| **Agently Catalog** | https://dune.com/queries/7401373/11337310 | Agently | Off-chain data |
| **CoC x402 Agent** | https://dune.com/queries/7400157/11335903 | Clash of Coins | Реальная x402 активность |

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
| Clash of Coins x402 | Amber | `#F59E0B` |
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
          + 5 Info Boards (BlockRunAI, Floe Labs, Agently, 4mica, CoC x402)
          + On-chain Status Labels (Active / ⚠️ Unconfirmed / ❌ No Data)

РЯД S5-2: [КАУНТЕРЫ из готовых queries]
          | BlockRunAI Txs (⚠️) | Floe Labs Txs | CoC x402 Txs |

РЯД S5-3: [ГРАФИК — BlockRunAI Activity — 12 колонок]
          Из @Hempanda query: https://dune.com/queries/7396448/

РЯД S5-4: [ГРАФИК — CoC x402 Agent Activity — 12 колонок]
          Из @Hempanda query: https://dune.com/queries/7400157/11335903

РЯД S5-5: [ТАБЛИЦА Agently — 6 кол.] [Floe Labs metrics — 6 кол.]
          Off-chain каталог + Lending summary

=====================================================================
```

---

## ИНФОБОРДЫ ПРОЕКТОВ

### Статус ончейн-данных (ОБНОВЛЁН по @Hempanda research)

| Проект | Статус | Что есть на Base Mainnet | Dune Query |
|--------|--------|--------------------------|------------|
| **BlockRunAI** | ⚠️ Контракт не подтверждён | `0xe9030014...` (155 txs, $12.6K USDC) — ожидает подтверждения от команды | [7396448](https://dune.com/queries/7396448/) |
| **Floe Labs** | 🟡 Слабые метрики | Facilitator `0x58edde02...` (8 txs, $327). FLOE token = РАГПУЛЛ ❌ | [7397253](https://dune.com/queries/7397253) |
| **Agently** | 📊 Off-chain data | ~2K реальных агентов (не 7770). Нет ончейн контракта | [7401373](https://dune.com/queries/7401373/11337310) |
| **4mica** | ❌ Нет данных | Токены на Base — СКАМ. Реальный контракт не найден | — |
| **Clash of Coins x402** | 🟢 Реальная активность! | PayTo: `0x8b29DABD...` (68 txs, $21.5K USDC) — настоящие x402 платежи | [7400157](https://dune.com/queries/7400157/11335903) |

---

### 1. BlockRunAI (Ключевой проект) — ⚠️ Контракт не подтверждён

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
| **Контракт** | ⚠️ `0xe9030014F5DAe217d0A152f02A043567b16c1aBf` — **НЕ ПОДТВЕРЖДЁН** (найден @Hempanda через OSINT) |
| **Dune query** | https://dune.com/queries/7396448/ (@Hempanda) |

**Что делает:**
BlockRun — платежный рельс для AI-агентов. Маркетплейс, где AI-агенты автономно находят, маршрутизируют и оплачивают API-сервисы с помощью USDC через x402 протокол. Без API-ключей, без подписок.

**Ключевые продукты:**
- **ClawRouter** — LLM-роутер, снижает затраты до 78% через intelligent routing. 6,247 GitHub stars (MIT)
- **AI Model Gateway** — 41+ LLM (GPT-5, Claude, Gemini, Grok, DeepSeek) через единый endpoint
- **RunCode (brcc)** — AI coding agent, 289 GitHub stars
- **BlockRun MCP** — MCP-сервер для Claude Code, 98+ stars

**Контракт (BaseScan данные на 30.04.2026):**
- Адрес: `0xe9030014F5DAe217d0A152f02A043567b16c1aBf`
- Транзакций: 155
- Баланс: $12,615 USDC (99.98% портфеля)
- Последняя активность: 11.03.2026 (49 дней назад)
- Funded by: `0x6B32b9b6...8b7660ccD` (12.02.2026)
- Паттерн: регулярные транзы каждые ~30 мин (Feb 12-13), потом отправка ETH (Mar 11)

> ⚠️ **ВНИМАНИЕ:** Контракт найден @Hempanda через OSINT и **требует подтверждения от команды BlockRunAI**. "@Hempanda: мало ли чего я там осинтом нарыл". @AX1 запрашивал информацию у BlockRun, но "blockrun очень медленные, пока задерживается" (30.04). Решено работать с текущими данными.

**AMA:** Запланирована с командой AX1. Может дать подтверждение контракта и дополнительную информацию.

---

### 2. Floe Labs — 🟡 Слабые метрики (facilitator only)

| Параметр | Значение |
|----------|----------|
| **Тип** | Structured Credit Protocol (P2P Lending for Agents) |
| **Сайт** | [floelabs.xyz](https://www.floelabs.xyz/) |
| **App** | [app.floelabs.xyz](https://app.floelabs.xyz) |
| **Twitter/X** | [@FloeLabs](https://x.com/FloeLabs) |
| **Протоколы** | DeFi, Intent-based lending |
| **Сеть** | Base Mainnet |
| **Facilitator** | `0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1` (8 txs, $327 баланс) |
| **~~FLOE Token~~** | ~~`0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e`~~ — ❌ **РАГПУЛЛ, НЕ их токен** |
| **Dune query** | https://dune.com/queries/7397253 (@Hempanda) |

**Что делает:**
Structured credit DEX на Base. P2P intent-matching протокол для кредитования. Фиксированные ставки, изолированный риск, прямой matching без пула.

**Реальные метрики (от @Hempanda, 29.04):**
- 4 уникальных адреса вернули кредитов на **$20**
- В систему добавлено залогов: **0.0052 WETH + 0.00002 cbBTC = ~$13**
- Всего 8 транзакций на facilitator контракте
- Функции: Register Borrow, Approve, Swap, Set Operator

> "@Hempanda: чарты не рисовал, там всё уныло — видимо, пока тестируют" — 29.04, 05:56

**On-chain status:** 🟡 Facilitator рабочий, но метрики минимальны. Можно добавить "на будущее" (@Hempanda).

**BaseScan:** https://basescan.org/address/0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1

---

### 3. Agently — 📊 Off-chain Data Only

| Параметр | Значение |
|----------|----------|
| **Тип** | Agent Marketplace + Routing Layer |
| **Сайт** | [use-agently.com](https://use-agently.com/) |
| **Twitter/X** | [@AgentlyHQ](https://x.com/AgentlyHQ) |
| **GitHub** | [github.com/AgentlyHQ/use-agently](https://github.com/AgentlyHQ/use-agently) (68 stars, MIT) |
| **Протоколы** | x402, A2A (Google), MCP, ERC-8004 |
| **Сеть** | Base Mainnet (primary) |
| **Ончейн контракт** | Нет dedicated контракта |
| **Агентов реально** | ~2,000 (не 7,770 как маркетируют) |
| **Dune query** | https://dune.com/queries/7401373/11337310 (@Hempanda, off-chain) |

**Что делает:**
Маркетплейс и CLI где AI-агенты находят друг друга, общаются (A2A), и оплачивают сервисы (x402). "DNS для AI-агентов".

**Реальные данные (от @Hempanda, 29.04):**
- В каталоге ~2,000 агентов (маркетплейс заявляет 7,770 — надуто)
- Off-chain данные доступны: каталог агентов по chain/type/виду
- Ончейн активности пока нет (не планируется в ближайшее время)
- @Hempanda может выгрузить каталог как Dune constants для чартов

> "@Hempanda: ну живое оказалось надутое, по факту у них там в базе не 7770 агентов, как они в маркетплейсе указывают, а 2к" — 29.04, 17:06
>
> "@Hempanda: по agently - я могу вытащить весь их каталог и сделать константами в дюне чарт по агентам в разрезе чейнов/типов/видов - если надо" — 29.04, 02:11

**On-chain status:** Нет ончейн данных. Только off-chain каталог.

---

### 4. 4mica — ❌ Нет верифицированного контракта

| Параметр | Значение |
|----------|----------|
| **Тип** | Instant Credit Tabs (x402 Facilitator) |
| **Сайт** | [4mica.xyz](https://4mica.xyz/) |
| **Docs** | [docs.4mica.xyz](https://docs.4mica.xyz/) |
| **Twitter/X** | [@4mica_xyz](https://x.com/4mica_xyz) |
| **GitHub** | [github.com/4mica-Network](https://github.com/4mica-Network) (12 repos) |
| **Протоколы** | x402 (4mica-credit scheme), BLS signatures |
| **~~4MICA Token (current)~~** | ~~`0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab`~~ — ❌ **СКАМ** |
| **~~4MICA Token (v1)~~** | ~~`0x231375fbbf6abf2320d64be206c0478d551e2687`~~ — ❌ **СКАМ** |
| **Реальный контракт** | ❌ НЕ НАЙДЕН (проверены GitHub, сайт) |
| **Dune query** | — (нет данных) |

**Что делает:**
Протокол мгновенных кредитных табов для агентов. "Откройте таб, тратьте сейчас, рассчитывайтесь через 7 дней." Некастодиальные BLS-signed гарантии.

> ⚠️ **ВНИМАНИЕ:** Оба адреса 4MICA токенов, ранее указанные в документе — **СКАМ**. @Hempanda проверил GitHub и сайт 4mica — адреса контракта нет. Если есть возможность узнать у команды — было бы хорошо.

> "@Hempanda: 4Mica токен контракты - там скам, а не их токен (я их настоящего токена не нашёл)" — 29.04, 06:17
>
> "@Hempanda: по ним даты нет, продолжаю ковыряться, но вряд ли к выпуску что-то успеем" — 29.04, 21:33

**On-chain status:** ❌ Нет данных. Vault на тестнете. Токен не верифицирован.

---

### 5. NEW: Clash of Coins x402 — 🟢 Реальная агентская активность!

| Параметр | Значение |
|----------|----------|
| **Тип** | x402 Agent Payments (в рамках Clash of Coins) |
| **x402 Shop** | https://x402.clashofcoins.com/shop/x402/offers |
| **PayTo Address** | `0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d` |
| **Транзакций** | 68 |
| **USDC баланс** | $21,582 |
| **Funded by** | Binance (1 yr 288 days ago) |
| **Dune query** | https://dune.com/queries/7400157/11335903 (@Hempanda) |

**Что это:**
@Hempanda нашёл реальные x402 агентские платежи в экосистеме Clash of Coins. По адресу x402 shop есть инструкция агентам, как платить через x402 протокол. В payload указан `"payTo": "0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d"`.

**Пример транзакции:**
https://basescan.org/tx/0xf25dbc071b31bd21c5b11224441f8a9568d6a24742af4875d085e28bfb4e317c

**Почему это важно:**
- Это **реальная x402 агентская активность** на Base — не теоретическая, не тестовая
- Связь с OWB / Clash of Coins (уже трекается на дашборде)
- USDC микроплатежи агентов за in-game items/services
- Подтверждает, что x402 протокол реально используется на Base

**BaseScan:** https://basescan.org/address/0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d

> "@Hempanda: но есть и хорошие новости — я нашёл транзы х402 тру агентика на СоС" — 29.04, 17:18

---

## О x402 FACILITATORS

### Важный нюанс (от @Hempanda)

> "@Hempanda: есть нюанс — кодбейз фасилитаторы на х402 часто не хардкодятся в проектах, а ротируются на стороне кодбейза, и там их МНОГО" — 28.04, 02:56

**Что это значит:**
- x402 Facilitator `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` (Coinbase CDP) — **один из многих**
- Проекты могут менять facilitator без уведомления
- @Hempanda собирал полный лист фасилитаторов x402 на Base (пару месяцев назад)
- Для полной картины x402 экосистемы нужно трекать несколько facilitator адресов

**Для дашборда:**
- Можно оставить Coinbase Facilitator как индикативный
- Но не позиционировать как "ВСЯ x402 активность на Base"
- Более надёжный подход: трекать конкретные payTo-адреса проектов (как CoC `0x8b29DABD...`)

---

## СВОДНАЯ ТАБЛИЦА КОНТРАКТОВ (ОБНОВЛЁННАЯ)

| Project | Address | Network | Type | Status | Source |
|---------|---------|---------|------|--------|--------|
| **BlockRunAI** | `0xe9030014F5DAe217d0A152f02A043567b16c1aBf` | Base Mainnet | Wallet (USDC payments) | ⚠️ **UNCONFIRMED** | @Hempanda OSINT |
| **Floe Labs** (facilitator) | `0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1` | Base Mainnet | Lending facilitator | 🟡 Active (8 txs) | @Hempanda |
| **Clash of Coins x402** (payTo) | `0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d` | Base Mainnet | x402 agent payments | 🟢 **Active** (68 txs) | @Hempanda |
| ERC-8004 Registry | `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432` | Base Mainnet | Identity Registry | Active (shared) | Dashboard V1 |
| x402 Facilitator (Coinbase) | `0xDbDf3D8ED80f84c35d01c6C9F9271761BAd90Ba6` | Base Mainnet | x402 verification | Active (один из многих) | BaseScan |
| **~~FLOE Token~~** | ~~`0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e`~~ | — | — | ❌ **РАГПУЛЛ** | @Hempanda |
| **~~4MICA Token~~** | ~~`0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab`~~ | — | — | ❌ **СКАМ** | @Hempanda |
| **~~4MICA Token v1~~** | ~~`0x231375fbbf6abf2320d64be206c0478d551e2687`~~ | — | — | ❌ **СКАМ** | @Hempanda |
| **Agently** | N/A | — | Off-chain only | 📊 ~2K agents | @Hempanda |
| **4mica** | N/A | — | Нет верифицированного контракта | ❌ Поиск продолжается | @Hempanda |

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

### BlockRunAI — AI Agent Payment Rail ⚠️

The payment rail for AI. A marketplace where AI agents autonomously discover, route, and pay for APIs using USDC via x402. Access 41+ LLM models — no API keys, no subscriptions.

| Key Stats | |
|-----------|---|
| **Product** | LLM Gateway + Payment Rail |
| **Protocol** | x402 (HTTP-native payments) |
| **GitHub** | ClawRouter: 6,200+ stars (MIT) |
| **Networks** | Base (primary), Solana |
| **On-chain** | ⚠️ Contract found (155 txs, $12.6K USDC) — awaiting team confirmation |

[blockrun.ai](https://blockrun.ai) · [@BlockRunAI](https://x.com/BlockRunAI)

**Dune Query:** [dune.com/queries/7396448](https://dune.com/queries/7396448/)

---

### Floe Labs — Structured Credit for Agents 🟡

Structured credit DEX on Base. P2P intent-matching protocol where agents post lending/borrowing intents with fixed rates and isolated risk.

| Key Stats | |
|-----------|---|
| **Product** | Credit DEX + AI Lending Agent |
| **Facilitator** | [`0x58edde02...`](https://basescan.org/address/0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1) |
| **Activity** | 8 txs, ~$20 in loans, ~$13 in collateral |
| **Status** | Testing phase — metrics minimal |

[floelabs.xyz](https://www.floelabs.xyz/) · [@FloeLabs](https://x.com/FloeLabs)

**Dune Query:** [dune.com/queries/7397253](https://dune.com/queries/7397253)

---

### Agently — Agent Discovery & Routing Layer 📊

Marketplace and CLI where AI agents discover each other, communicate (A2A), and transact (x402). "DNS for AI agents."

| Key Stats | |
|-----------|---|
| **Product** | Agent Marketplace + CLI |
| **Protocols** | x402, A2A (Google), MCP, ERC-8004 |
| **Agents** | ~2,000 in catalog (by chain/type) |
| **Data** | Off-chain only — no on-chain contract |

[use-agently.com](https://use-agently.com/) · [@AgentlyHQ](https://x.com/AgentlyHQ)

**Dune Query:** [dune.com/queries/7401373](https://dune.com/queries/7401373/11337310) (off-chain catalog)

---

### 4mica — Instant Credit Tabs for Agents ❌

Open a tab, let agents spend now, settle after 7 days. Non-custodial, BLS-backed cryptographic guarantees.

| Key Stats | |
|-----------|---|
| **Product** | Credit Tabs + x402 Facilitator |
| **SDKs** | Rust, TypeScript, Python |
| **On-chain** | ❌ No verified contract found |
| **Note** | Token contracts on Base are scams — not affiliated with 4mica |

[4mica.xyz](https://4mica.xyz/) · [@4mica_xyz](https://x.com/4mica_xyz)

---

### Clash of Coins — x402 Agent Payments 🟢

Real x402 agent payment activity discovered on Base. Agents pay for in-game items/services via x402 protocol through a dedicated payTo address.

| Key Stats | |
|-----------|---|
| **Protocol** | x402 (HTTP-native payments) |
| **PayTo Address** | [`0x8b29DABD...`](https://basescan.org/address/0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d) |
| **Transactions** | 68 txs, $21.5K USDC |
| **x402 Shop** | [x402.clashofcoins.com/shop/x402/offers](https://x402.clashofcoins.com/shop/x402/offers) |
| **Status** | **Live — real agent x402 payments** |

**Dune Query:** [dune.com/queries/7400157](https://dune.com/queries/7400157/11335903)

---

*All four Batches 003 projects are participants of [Base Batches 003](https://base.org/batches) accelerator (announced April 9, 2026). Demo Day: May 19, San Francisco.*

*Clash of Coins x402 data demonstrates real agent payment activity within the existing OWB ecosystem on Base.*

**Protocol Stack:** x402 (payments) + ERC-8004 (identity) + A2A (communication) + MCP (tools)
```

---

### QUERY 5.1: BlockRunAI — On-chain Activity

> **ГОТОВЫЙ QUERY ОТ @HEMPANDA:** https://dune.com/queries/7396448/
> Рекомендуется использовать query @Hempanda напрямую (он уже протестирован и содержит правильные адреса).

#### Что он делает
Трекает активность контракта BlockRunAI на Base: транзакции, USDC потоки, уникальные адреса.

#### На какие вопросы отвечает
- Сколько транзакций у BlockRunAI контракта?
- Какой объём USDC проходит через адрес?
- Сколько уникальных адресов взаимодействовали?

#### ⚠️ ВАЖНО
Контракт `0xe9030014F5DAe217d0A152f02A043567b16c1aBf` **не подтверждён** командой BlockRunAI. Данные могут быть неточными.

#### Название запроса при сохранении
`BlockRunAI - On-chain Activity (⚠️ Unconfirmed)`

#### SQL-код (fallback — если query @Hempanda недоступен)

```sql
-- BlockRunAI: On-chain Activity
-- ⚠️ Contract NOT CONFIRMED by BlockRunAI team
-- Address found via OSINT by @Hempanda (Apr 29, 2026)
-- Source: https://dune.com/queries/7396448/

WITH blockrun_txs AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS txs,
        COUNT(DISTINCT t."from") AS unique_senders,
        COUNT(DISTINCT t."to") AS unique_receivers
    FROM base.transactions t
    WHERE (t."from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
        OR t."to" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf)
      AND t.success = true
    GROUP BY 1
),

-- USDC transfers involving BlockRunAI address
usdc_flows AS (
    SELECT
        DATE_TRUNC('day', evt_block_time) AS day,
        SUM(CASE
            WHEN "to" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
            THEN CAST(value AS DOUBLE) / 1e6
            ELSE 0
        END) AS usdc_in,
        SUM(CASE
            WHEN "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
            THEN CAST(value AS DOUBLE) / 1e6
            ELSE 0
        END) AS usdc_out
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC on Base
      AND (
          "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
          OR "to" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
      )
    GROUP BY 1
)

SELECT
    COALESCE(b.day, u.day) AS day,
    COALESCE(b.txs, 0) AS "Daily Txs",
    COALESCE(b.unique_senders, 0) AS "Unique Senders",
    ROUND(COALESCE(u.usdc_in, 0), 2) AS "USDC In",
    ROUND(COALESCE(u.usdc_out, 0), 2) AS "USDC Out",
    SUM(COALESCE(b.txs, 0)) OVER (ORDER BY COALESCE(b.day, u.day)) AS "Cumulative Txs"
FROM blockrun_txs b
FULL OUTER JOIN usdc_flows u ON b.day = u.day
ORDER BY 1
```

---

### QUERY 5.2: Floe Labs — Lending Activity

> **ГОТОВЫЙ QUERY ОТ @HEMPANDA:** https://dune.com/queries/7397253
> Рекомендуется использовать query @Hempanda напрямую.

#### Что он делает
Трекает активность Floe Labs facilitator на Base: транзакции по кредитам, залоги, уникальные адреса.

#### На какие вопросы отвечает
- Сколько кредитов выдано/возвращено?
- Какой объём залогов?
- Сколько уникальных borrowers?

#### Название запроса при сохранении
`Floe Labs - Lending Activity (Facilitator)`

#### SQL-код (fallback)

```sql
-- Floe Labs: Lending Activity
-- Facilitator: 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
-- Source: https://dune.com/queries/7397253 (@Hempanda)
-- Note: Metrics very weak — 4 unique addresses, ~$20 in loans, ~$13 in collateral

WITH floe_txs AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS txs,
        COUNT(DISTINCT t."from") AS unique_users
    FROM base.transactions t
    WHERE (t."from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        OR t."to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1)
      AND t.success = true
    GROUP BY 1
),

-- Token transfers (WETH, cbBTC, USDT) involving Floe facilitator
collateral_flows AS (
    SELECT
        DATE_TRUNC('day', evt_block_time) AS day,
        COUNT(*) AS token_transfers,
        COUNT(DISTINCT "from") AS unique_depositors
    FROM erc20_base.evt_Transfer
    WHERE (
        "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
    )
    GROUP BY 1
)

SELECT
    COALESCE(f.day, c.day) AS day,
    COALESCE(f.txs, 0) AS "Daily Txs",
    COALESCE(f.unique_users, 0) AS "Unique Users",
    COALESCE(c.token_transfers, 0) AS "Token Transfers",
    COALESCE(c.unique_depositors, 0) AS "Unique Depositors"
FROM floe_txs f
FULL OUTER JOIN collateral_flows c ON f.day = c.day
ORDER BY 1
```

---

### QUERY 5.3: Agently — Off-chain Agent Catalog

> **ГОТОВЫЙ QUERY ОТ @HEMPANDA:** https://dune.com/queries/7401373/11337310
> Рекомендуется использовать query @Hempanda напрямую (содержит off-chain данные, загруженные как constants).

#### Что он делает
Показывает каталог агентов Agently: распределение по chain, тип, вид. Данные off-chain — извлечены из маркетплейса.

#### На какие вопросы отвечает
- Сколько реальных агентов в каталоге Agently? (~2K, не 7770)
- Как распределены агенты по chains?
- Какие типы/виды агентов представлены?

#### Название запроса при сохранении
`Agently - Agent Catalog (Off-chain)`

#### Примечания
- Данные off-chain — не из блокчейна
- @Hempanda может обновлять каталог через скрипт выгрузки
- "Если надо, сообщи и я накидаю скрипт и выгружу коллегам дату для дэша" (@Hempanda)
- Реально ~2,000 агентов (маркетплейс заявляет 7,770)

---

### QUERY 5.4: Clash of Coins — x402 Agent Payments

> **ГОТОВЫЙ QUERY ОТ @HEMPANDA:** https://dune.com/queries/7400157/11335903
> Рекомендуется использовать query @Hempanda напрямую.

#### Что он делает
Трекает реальные x402 агентские платежи в экосистеме Clash of Coins. Агенты платят за items/services через x402 протокол на PayTo адрес.

#### На какие вопросы отвечает
- Сколько x402 платежей прошло через Clash of Coins?
- Какой объём USDC?
- Сколько уникальных агентов платят?

#### Название запроса при сохранении
`Clash of Coins - x402 Agent Payments`

#### SQL-код (fallback)

```sql
-- Clash of Coins: x402 Agent Payments
-- PayTo address: 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
-- Source: https://dune.com/queries/7400157/11335903 (@Hempanda)
-- Logic: x402 shop at https://x402.clashofcoins.com/shop/x402/offers
-- agents pay USDC to this address per x402 protocol

WITH coc_x402_txs AS (
    SELECT
        DATE_TRUNC('day', t.block_time) AS day,
        COUNT(*) AS txs,
        COUNT(DISTINCT t."from") AS unique_payers
    FROM base.transactions t
    WHERE t."to" = 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
      AND t.success = true
    GROUP BY 1
),

-- USDC payments to CoC x402 address
usdc_payments AS (
    SELECT
        DATE_TRUNC('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e6) AS usdc_volume,
        COUNT(*) AS usdc_txs,
        COUNT(DISTINCT "from") AS unique_usdc_payers
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC on Base
      AND "to" = 0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
    GROUP BY 1
)

SELECT
    COALESCE(c.day, u.day) AS day,
    COALESCE(c.txs, 0) AS "Daily Txs",
    COALESCE(c.unique_payers, 0) AS "Unique Payers",
    ROUND(COALESCE(u.usdc_volume, 0), 2) AS "USDC Volume",
    COALESCE(u.usdc_txs, 0) AS "USDC Payments",
    SUM(ROUND(COALESCE(u.usdc_volume, 0), 2)) OVER (ORDER BY COALESCE(c.day, u.day)) AS "Cumulative USDC"
FROM coc_x402_txs c
FULL OUTER JOIN usdc_payments u ON c.day = u.day
ORDER BY 1
```

---

### Визуализации

#### Каунтеры (РЯД S5-2)

| # | Заголовок | Источник | Формат | Цвет | Ширина |
|---|-----------|----------|--------|------|--------|
| 1 | **BlockRunAI Txs ⚠️** | Query 5.1 (SUM of Daily Txs) | Number | Teal `#14B8A6` | 4 кол. |
| 2 | **Floe Labs Txs** | Query 5.2 (SUM of Daily Txs) | Number | Sky `#0EA5E9` | 4 кол. |
| 3 | **CoC x402 USDC** | Query 5.4 (SUM of USDC Volume) | Dollar | Amber `#F59E0B` | 4 кол. |

#### Chart: BlockRunAI Activity (РЯД S5-3)

Из Query 5.1 — full-width chart:

| Настройка | Значение |
|-----------|----------|
| **Тип** | Mixed (bar + line) |
| **Ширина** | 12 колонок |
| **Заголовок** | `BlockRunAI: On-chain Activity (⚠️ Unconfirmed Contract)` |
| **X-axis** | `day` |
| **Bars (left)** | `Daily Txs` (Teal `#14B8A6`) |
| **Line (right)** | `Cumulative Txs` (Dark Teal `#0F766E`) |
| **Additional** | `USDC In` (Green `#10B981`), `USDC Out` (Red `#EF4444`) |

#### Chart: CoC x402 Agent Payments (РЯД S5-4)

Из Query 5.4 — full-width chart:

| Настройка | Значение |
|-----------|----------|
| **Тип** | Mixed (bar + line) |
| **Ширина** | 12 колонок |
| **Заголовок** | `Clash of Coins: x402 Agent Payments (Real Activity)` |
| **X-axis** | `day` |
| **Bars (left)** | `USDC Volume` (Amber `#F59E0B`) |
| **Line (right)** | `Cumulative USDC` (Dark Amber `#B45309`) |
| **Additional** | `Unique Payers` (Teal `#14B8A6`, dashed) |

#### Tables (РЯД S5-5)

**Left (6 cols): Agently Agent Catalog**
Из Query 5.3 — таблица каталога агентов по chain/type.

**Right (6 cols): Floe Labs Summary**
Из Query 5.2 — таблица с суммарными метриками.

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
| **8** | **Tools & Infrastructure** | **Batches 3.0: BlockRunAI, Floe Labs, Agently, 4mica + CoC x402 agent payments** |
| 9 | Base Agentic Gaming | Gaming transactions, players, project comparison |
| 10 | OWB Agentic Gaming | DTU, NFT revenue, retention, Agentic Passes |
```

---

## ОБНОВЛЕНИЕ METHODOLOGY (Footer)

### Добавить в существующий Methodology текст

```markdown
### Tools & Infrastructure (V3 — April 2026)

**What we track:** Infrastructure projects from Base Batches 003 accelerator that enable the agent economy — payment rails, agent discovery, credit protocols, and coordination tools. Plus real x402 agent payment activity discovered on-chain.

**Format:** Info boards — project summaries with on-chain status labels. Projects with verified on-chain activity show live metrics; projects with unconfirmed data are clearly labeled.

**Category definition:** Projects that don't generate on-chain activity themselves, but facilitate and route activity through the ecosystem. The "pipes and rails" of the agent economy.

**Tracked projects:**

| Project | Role | On-chain Status |
|---------|------|----------------|
| BlockRunAI | AI agent payment rail + LLM gateway (x402) | ⚠️ Contract found, awaiting confirmation |
| Floe Labs | Structured credit protocol for agents | 🟡 Facilitator active (weak metrics) |
| Agently | Agent marketplace + routing layer (A2A, MCP) | 📊 Off-chain data only (~2K agents) |
| 4mica | Instant credit tabs (x402 facilitator) | ❌ No verified contract |
| Clash of Coins x402 | Real x402 agent payments | 🟢 Active (68 txs, $21.5K USDC) |

**Verified Contracts:**
- BlockRunAI: `0xe9030014F5DAe217d0A152f02A043567b16c1aBf` — ⚠️ UNCONFIRMED (found via OSINT)
- Floe Labs facilitator: `0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1` — active, weak metrics
- CoC x402 payTo: `0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d` — real x402 payments

**Removed (scams):**
- ~~FLOE Token `0xA2CBA6b88D86cC2F7469BbEabDd6b4A63c60f75e`~~ — RUGPULL
- ~~4MICA Token `0x33f2df2EfD5dd5FD39e6845ddb63cCa4B4fc50Ab`~~ — SCAM
- ~~4MICA Token v1 `0x231375fbbf6abf2320d64be206c0478d551e2687`~~ — SCAM

**Data limitations:**
- BlockRunAI contract awaiting team confirmation — may need to be updated
- Floe Labs has minimal activity (8 txs, ~$33 total flow)
- x402 facilitators rotate and there are many on Base — single facilitator tracking is incomplete
- Agently data is off-chain (scraped from marketplace catalog)
- 4mica has no verified on-chain presence
- Off-chain activity (API calls, LLM inference) not captured

**Research:** Deep contract analysis by @Hempanda (April 28-30, 2026)

**Color:** Teal (#14B8A6)
```

---

## ПОРЯДОК ДЕЙСТВИЙ НА DUNE — ЧЕКЛИСТ

### Предварительная подготовка

- [ ] **Шаг 0:** Прочитать весь этот документ, обратив внимание на раздел [Критические исправления](#критические-исправления)
- [ ] **Шаг 0.1:** Проверить контракты на BaseScan:
  - BlockRunAI (⚠️): https://basescan.org/address/0xe9030014F5DAe217d0A152f02A043567b16c1aBf
  - Floe Labs facilitator: https://basescan.org/address/0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
  - CoC x402 payTo: https://basescan.org/address/0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d
- [ ] **Шаг 0.2:** Проверить готовые queries от @Hempanda:
  - BlockRunAI: https://dune.com/queries/7396448/
  - Floe Labs: https://dune.com/queries/7397253
  - Agently: https://dune.com/queries/7401373/11337310
  - CoC x402: https://dune.com/queries/7400157/11335903

### Добавление queries на дашборд

- [ ] **Шаг 1:** Добавить Query 5.1 — BlockRunAI
  - Использовать query @Hempanda: https://dune.com/queries/7396448/
  - Или скопировать fallback SQL из раздела [Query 5.1](#query-51-blockrunai--on-chain-activity)
  - ⚠️ Пометить как "Unconfirmed Contract" в заголовке

- [ ] **Шаг 2:** Добавить Query 5.2 — Floe Labs
  - Использовать query @Hempanda: https://dune.com/queries/7397253
  - Или скопировать fallback SQL из раздела [Query 5.2](#query-52-floe-labs--lending-activity)
  - Примечание: данных мало, "можем вставить на будущее" (@Hempanda)

- [ ] **Шаг 3:** Добавить Query 5.3 — Agently
  - Использовать query @Hempanda: https://dune.com/queries/7401373/11337310
  - Off-chain данные — отображать как таблицу/pie chart

- [ ] **Шаг 4:** Добавить Query 5.4 — Clash of Coins x402
  - Использовать query @Hempanda: https://dune.com/queries/7400157/11335903
  - Или скопировать fallback SQL из раздела [Query 5.4](#query-54-clash-of-coins--x402-agent-payments)
  - Это **главная находка** — реальная x402 активность

### Создание визуализаций

- [ ] **Шаг 5:** Из Query 5.1 создать Counter + Chart:
  - Counter: BlockRunAI Txs ⚠️ (Teal `#14B8A6`)
  - Chart: Mixed bar+line (Daily Txs + Cumulative)

- [ ] **Шаг 6:** Из Query 5.4 создать Counter + Chart:
  - Counter: CoC x402 USDC (Amber `#F59E0B`)
  - Chart: Mixed bar+line (USDC Volume + Cumulative)

- [ ] **Шаг 7:** Из Query 5.2 создать Counter:
  - Counter: Floe Labs Txs (Sky `#0EA5E9`)

- [ ] **Шаг 8:** Из Query 5.3 создать Table:
  - Таблица каталога агентов Agently

### Размещение на дашборде

- [ ] **Шаг 9:** Добавить Text Widget S5 (Info Boards)
  - Скопировать markdown из раздела [Text Widget S5](#text-widget-s5-section-header--info-boards)
  - Разместить на 12 колонок
  - **ВАЖНО:** Разместить НАД секциями gaming (gaming — последние)

- [ ] **Шаг 10:** Разместить каунтеры (РЯД S5-2, по 4 колонки каждый)

- [ ] **Шаг 11:** Разместить charts (РЯД S5-3: BlockRunAI, РЯД S5-4: CoC x402)

- [ ] **Шаг 12:** Разместить таблицы (РЯД S5-5: Agently + Floe Labs)

- [ ] **Шаг 13:** Обновить Table of Contents (строка 8: Tools & Infrastructure)

- [ ] **Шаг 14:** Обновить Methodology footer

### Финальная проверка

- [ ] **Шаг 15:** Проверить все виджеты
  - Инфоборды читаемы, ⚠️ метки видны
  - ❌ СКАМ-контракты НИГДЕ не используются
  - Charts отображают данные
  - Секция расположена НАД gaming

- [ ] **Шаг 16:** Проверить мобильную версию

- [ ] **Шаг 17:** Ревью с командой перед релизом

---

## ДОПОЛНИТЕЛЬНЫЕ ЗАМЕТКИ

### Расширение в будущем (V4+)

По мере развития проектов:
- [ ] BlockRunAI: получить подтверждение контракта → убрать метку ⚠️
- [ ] 4mica: найти реальный контракт → добавить метрики
- [ ] Floe Labs: если активность вырастет → расширить чарты
- [ ] Agently: обновлять off-chain каталог периодически
- [ ] x402 Facilitators: добавить больше facilitator адресов (у @Hempanda есть лист)
- [ ] Новые проекты Batches 003: OPAL, Credifi, Liminal и др.

### Связь с другими секциями

| Проект | Связь | Как |
|--------|-------|-----|
| BlockRunAI | Section 1 (Ecosystem Pulse) | x402 платежи → USDC transfers на Base |
| Agently | ERC-8004 Registry | Использует ERC-8004 для discovery |
| Floe Labs | Section 1 (Ecosystem Pulse) | Lending txs → общий подсчёт |
| CoC x402 | Section 4 (OWB) | x402 агентские платежи внутри CoC экосистемы |

### История версий

| Версия | Дата | Что изменилось |
|--------|------|----------------|
| V3.0 | 27.04 | Первоначальный документ: инфоборды, x402 Facilitator |
| V3.1 | 28.04 | Добавлены 4MICA/FLOE токены, x402 Facilitator query |
| **V3.2** | **30.04** | **Критические исправления @Hempanda:** убраны СКАМ-токены, добавлен BlockRunAI контракт (⚠️), Floe facilitator, Agently off-chain, CoC x402 |

---

*Документ обновлён: 30 апреля 2026*
*Версия: V3.2 (по результатам deep research @Hempanda)*
*Формат: DuneSQL (Trino-based)*
*Совместимо с: https://dune.com/ax1research/base-agentic-ecosystem*
*Тестовый дашборд: https://dune.com/bossincrypto/test*
*Проекты: Base Batches 003 (BlockRunAI, Floe Labs, Agently, 4mica) + Clash of Coins x402*
*Исследование: @Hempanda (28-30 апреля 2026)*
