# РАЗДЕЛ 5: Tools & Infrastructure — Полная Инструкция

> **Дашборд:** `Base Agentic: The Birth of AI Economy`
> **URL:** https://dune.com/ax1research/base-agentic-ecosystem
> **Новый раздел:** Section 5 (Tools & Infrastructure — Agentic Infra on Base)
> **Дата:** Май 2026

---

## СОДЕРЖАНИЕ

1. [Общий план](#общий-план)
2. [Отслеживаемые контракты](#отслеживаемые-контракты)
3. [Проблемы текущего запроса V3.2 и их исправление](#проблемы-текущего-запроса-v32-и-их-исправление)
4. [Text Widget S5: Section Header](#text-widget-s5-section-header)
5. [Query 5.1: Combined KPIs](#query-51-tools--infra--combined-kpis)
6. [Query 5.2: Daily Activity Trend](#query-52-tools--infra--daily-activity-trend)
7. [Query 5.3: CoC x402 Agentic Payments](#query-53-coc-x402--agentic-payments-deep-dive)
8. [Query 5.4: Agently Catalog Growth](#query-54-agently-catalog--agent-growth--composition)
9. [Описания индикаторов](#описания-индикаторов)
10. [Визуализации и оформление](#визуализации-и-оформление)
11. [Карта Layout](#карта-layout)
12. [Цветовая палитра](#цветовая-палитра)
13. [Порядок действий на Dune — Чеклист](#порядок-действий-на-dune--чеклист)

---

## ОБЩИЙ ПЛАН

### Что это за раздел

Section 5 — **Tools & Infrastructure** — отслеживает проекты из Batches 3.0, которые являются *инфраструктурой* агентской экономики на Base. Это не сами агенты, а инструменты, через которые проходит агентская активность: платежи, лендинг, execution.

### Что добавляем

| Section | Queries | Widgets | Rows |
|---------|---------|---------|------|
| **5) Tools & Infrastructure** | 4 queries | 1 text + 5 counters + 5 charts + 2 pies = **13** | 8 рядов |

### Где располагается

Раздел добавляется **ПЕРЕД** Base Agentic Gaming (gaming остается последним), **ПОСЛЕ** Base vs Solana.

Текущий порядок на дашборде:
1. Ecosystem Pulse (KPIs)
2. Cross-Pollination Index
3. Daily Activity
4. Leaderboard
5. ERC-8004 Registry
6. Virtuals Protocol
7. Base vs Solana
8. **→ Section 5: Tools & Infrastructure** ← НОВОЕ
9. Section 3: Base Agentic Gaming (как было)
10. Section 4: OWB Compact (как было)
11. Methodology (footer)

---

## ОТСЛЕЖИВАЕМЫЕ КОНТРАКТЫ

### Важно: каждый проект использует СВОЙ источник данных

Нельзя просто собрать все адреса в `base.transactions WHERE "from" IN (...)` — это даёт неверные результаты (например, 155 транзакций BlockRunAI вместо 500K+).

| Project | Address | Тип данных | Таблица в Dune | Примечание |
|---------|---------|------------|----------------|------------|
| **BlockRunAI** | `0xe9030014F5DAe217d0A152f02A043567b16c1aBf` | USDC-транзакции через адрес | `erc20_base.evt_Transfer` | 581K+ транзакций. Адрес подтверждён через x402scan по совету команды BlockRunAI |
| **Floe Labs** | `0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1` | Транзакции к/от фасилитатора | `base.transactions` + `erc20_base.evt_Transfer` | Лендинг-фасилитатор x402. Пока минимальная активность (~20 USD) |
| **CoC x402** | `0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d` | x402 платежи (AuthorizationUsed + Transfer) | `base.logs` (двойной фильтр по топикам) | Агентик платежи в Clash of Coins. Фильтрация по x402 AuthorizationUsed отделяет ботов от людей |
| **Agently** | — (оффчейн) | Каталог агентов: ежедневные регистрации, распределение по чейнам и протоколам | VALUES (hardcoded offchain snapshot) | Оффчейн данные с use-agently.com. Обновляется вручную через VALUES |

### Вспомогательные адреса (не контракты проектов)

| Token | Address | Роль |
|-------|---------|------|
| **USDC (Base)** | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` | Базовый стейблкоин для расчётов |

### Топики событий

| Event | Topic0 | Используется для |
|-------|--------|-----------------|
| **Transfer** (ERC-20) | `0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef` | USDC переводы |
| **AuthorizationUsed** (x402) | `0x98de503528ee59b575ef0c0a2576a82497bfc029a5685b209e9ec333479b10a5` | Подтверждение x402 платежа |

---

## ПРОБЛЕМЫ ТЕКУЩЕГО ЗАПРОСА V3.2 И ИХ ИСПРАВЛЕНИЕ

### Текущий запрос (Query 7406368 — "Combined On-chain Activity V3.2")

**Проблема 1: Неверная таблица и фильтр для BlockRunAI**
```sql
-- БЫЛО (неправильно):
FROM base.transactions t
WHERE t."from" IN (0xe903..., 0x58ed..., 0x8b29...)
```
Результат: 155 транзакций BlockRunAI (вместо 500K+).

Причина: `base.transactions WHERE "from" = BlockRunAI_addr` ищет транзакции, ОТПРАВЛЕННЫЕ контрактом. BlockRunAI *принимает* USDC через ERC-20 Transfer events, которые живут в `erc20_base.evt_Transfer`, а не в `base.transactions`.

**Исправление:**
```sql
-- СТАЛО (правильно):
FROM erc20_base.evt_Transfer
WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913  -- USDC
  AND ("from" = 0xe903... OR "to" = 0xe903...)
```

**Проблема 2: Дата с 2024-01-01 жрёт кредиты впустую**
CoC x402 начал работать только с марта 2026, BlockRunAI — с начала 2026. Фильтр `>= DATE '2024-01-01'` заставляет Dune сканировать 2 лишних года данных.

**Исправление:** `>= TIMESTAMP '2026-01-01'`

**Проблема 3: CoC x402 без фильтрации по AuthorizationUsed**
Без второго топика (AuthorizationUsed) в запрос попадают обычные переводы USDC на адрес CoC, а не только x402 агентские платежи.

**Исправление:** Двойной JOIN по `base.logs` — Transfer + AuthorizationUsed в одной транзакции (как в запросе Hempanda #7400157).

---

## TEXT WIDGET S5: SECTION HEADER (РЯД S5-1)

**Как добавить:** Edit dashboard → Add text widget → вставить текст → растянуть на 12 колонок.

**Текст (скопируй как есть):**

```markdown
---

## Tools & Infrastructure: The Rails of Agentic Economy

Agentic infrastructure projects don't generate activity themselves - they **facilitate** it. These are the rails that connect agents to payments, lending, and execution on Base.

**What we track:**
- **BlockRunAI** - AI agent execution hub. 500K+ USDC transactions routed through its contracts since Jan 2026
- **Floe Labs** - Agent-native lending via x402 facilitator. Early-stage, currently in testing
- **CoC x402 Agentic Payments** - Clash of Coins in-game purchases made by AI agents via x402 protocol. Filtered by AuthorizationUsed event to isolate agent payments from human purchases

**Methodology:** Each project uses a different data source. BlockRunAI is tracked via USDC Transfer events (erc20_base.evt_Transfer). CoC x402 requires dual-topic filtering (Transfer + AuthorizationUsed in same tx). Floe Labs is tracked via direct contract interactions. Date range: Jan 1, 2026 onward.

> Batches 3.0 participants. Source: [x402scan](https://www.x402scan.com/) for BlockRunAI verification.
```

---

## QUERY 5.1: Tools & Infra — Combined KPIs

### Что он делает
Один консолидированный запрос, который выдаёт все 5 KPI-каунтеров для Section 5. Собирает данные из трёх разных источников через UNION ALL.

### Название при сохранении
`Tools & Infra - Combined KPIs (V1)`

### SQL-код

```sql
-- Section 5: Tools & Infrastructure — Combined KPIs
-- Tracks verified agentic infrastructure projects on Base (Batches 3.0)
-- Date range: 2026-01-01+ to save Dune credits
--
-- Data sources:
--   BlockRunAI:  erc20_base.evt_Transfer (USDC through address)
--   Floe Labs:   base.transactions (to/from facilitator) + erc20_base.evt_Transfer
--   CoC x402:    base.logs dual-topic (AuthorizationUsed + Transfer)

-- ============================================================
-- 1) BlockRunAI — USDC transfers through the address
-- ============================================================
WITH blockrun_txs AS (
    SELECT
        'BlockRunAI' AS project,
        evt_block_time AS block_time,
        evt_tx_hash AS tx_hash,
        CASE
            WHEN "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf THEN "to"
            ELSE "from"
        END AS counterparty,
        CAST(value AS DOUBLE) / 1e6 AS usdc_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND (
          "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
          OR "to" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
      )
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

-- ============================================================
-- 2) Floe Labs — transactions to/from facilitator
-- ============================================================
floe_base_txs AS (
    SELECT
        'Floe Labs' AS project,
        block_time,
        hash AS tx_hash,
        CASE
            WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
            ELSE "from"
        END AS counterparty,
        CAST(0 AS DOUBLE) AS usdc_amount
    FROM base.transactions
    WHERE (
        "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
    )
      AND success = true
      AND block_time >= TIMESTAMP '2026-01-01'
),

floe_token_txs AS (
    SELECT
        'Floe Labs' AS project,
        evt_block_time AS block_time,
        evt_tx_hash AS tx_hash,
        CASE
            WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
            ELSE "from"
        END AS counterparty,
        CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
            THEN CAST(value AS DOUBLE) / 1e6
            ELSE CAST(0 AS DOUBLE)
        END AS usdc_amount
    FROM erc20_base.evt_Transfer
    WHERE (
        "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
    )
      AND evt_block_time >= TIMESTAMP '2026-01-01'
),

-- ============================================================
-- 3) CoC x402 — USDC transfers with AuthorizationUsed filter
-- ============================================================
coc_target_transfers AS (
    SELECT
        block_time,
        tx_hash,
        VARBINARY_SUBSTRING(topic1, 13, 20) AS from_address,
        CAST(VARBINARY_TO_UINT256(data) AS DOUBLE) / 1e6 AS usdc_amount
    FROM base.logs
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND topic2 = 0x0000000000000000000000008b29dabd6fbb5a09dacbc7978eaed66a8540721d
      AND block_time >= TIMESTAMP '2026-01-01'
),

coc_authorized_hashes AS (
    SELECT DISTINCT l.tx_hash
    FROM base.logs l
    INNER JOIN (
        SELECT DISTINCT tx_hash FROM coc_target_transfers
    ) t ON l.tx_hash = t.tx_hash
    WHERE l.contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND l.topic0 = 0x98de503528ee59b575ef0c0a2576a82497bfc029a5685b209e9ec333479b10a5
      AND l.block_time >= TIMESTAMP '2026-01-01'
),

coc_x402_txs AS (
    SELECT
        'CoC x402' AS project,
        ct.block_time,
        ct.tx_hash,
        ct.from_address AS counterparty,
        ct.usdc_amount
    FROM coc_target_transfers ct
    INNER JOIN coc_authorized_hashes ca ON ct.tx_hash = ca.tx_hash
),

-- ============================================================
-- Combine all projects
-- ============================================================
all_txs AS (
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM blockrun_txs
    UNION ALL
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM floe_base_txs
    UNION ALL
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM floe_token_txs
    UNION ALL
    SELECT project, block_time, tx_hash, counterparty, usdc_amount FROM coc_x402_txs
),

-- ============================================================
-- KPIs
-- ============================================================
total_kpi AS (
    SELECT
        COUNT(DISTINCT tx_hash) AS total_txs,
        COUNT(DISTINCT counterparty) AS unique_counterparties,
        ROUND(SUM(usdc_amount), 2) AS total_usdc_volume,
        COUNT(DISTINCT project) AS active_projects
    FROM all_txs
),

-- WoW: last 7 full days vs previous 7 full days (excluding today)
wow_current AS (
    SELECT COUNT(DISTINCT tx_hash) AS txs_7d
    FROM all_txs
    WHERE block_time >= DATE_ADD('day', -7, CAST(CURRENT_DATE AS TIMESTAMP))
      AND block_time < CAST(CURRENT_DATE AS TIMESTAMP)
),

wow_prev AS (
    SELECT COUNT(DISTINCT tx_hash) AS txs_prev_7d
    FROM all_txs
    WHERE block_time >= DATE_ADD('day', -14, CAST(CURRENT_DATE AS TIMESTAMP))
      AND block_time < DATE_ADD('day', -7, CAST(CURRENT_DATE AS TIMESTAMP))
)

SELECT
    tk.total_txs             AS "Total Transactions",
    tk.unique_counterparties AS "Unique Counterparties",
    tk.total_usdc_volume     AS "Total USDC Volume",
    tk.active_projects       AS "Active Projects",
    CASE
        WHEN wp.txs_prev_7d > 0
        THEN ROUND(100.0 * (wc.txs_7d - wp.txs_prev_7d) / CAST(wp.txs_prev_7d AS DOUBLE), 1)
        ELSE 0
    END AS "WoW Growth %"
FROM total_kpi tk
CROSS JOIN wow_current wc
CROSS JOIN wow_prev wp
```

### Как оформить: 5 Каунтеров (РЯД S5-2)

Из единственной строки результата создай **5 Counter-визуализаций**:

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **Total Transactions** | `Total Transactions` | Number | Blue `#3B82F6` | 2-3 кол. |
| 2 | **Unique Counterparties** | `Unique Counterparties` | Number | Purple `#8B5CF6` | 2-3 кол. |
| 3 | **USDC Volume** | `Total USDC Volume` | Prefix `$`, 0 дес. | Amber `#F59E0B` | 2-3 кол. |
| 4 | **Active Projects** | `Active Projects` | Number | Green `#10B981` | 2-3 кол. |
| 5 | **WoW Growth** | `WoW Growth %` | Suffix `%`, 1 дес. | Green/Red по знаку | 2-3 кол. |

**Как создать каунтер в Dune:**
1. Открой запрос `Tools & Infra - Combined KPIs (V1)` → Run
2. Нажми **New visualization** → выбери **Counter**
3. В поле **Column** выбери нужную колонку
4. В **Title** впиши название
5. В **Prefix** поставь `$` для USDC Volume
6. В **Suffix** поставь `%` для WoW Growth
7. Повтори для каждого каунтера (5 раз из одного запроса)

---

## QUERY 5.2: Tools & Infra — Daily Activity Trend

### Что он делает
Ежедневная активность по всем трём проектам: транзакции (stacked bars), уникальные адреса, USDC объём. С 7d MA и кумулятивными метриками.

### Название при сохранении
`Tools & Infra - Daily Activity Trend (V1)`

### SQL-код

```sql
-- Section 5: Tools & Infrastructure — Daily Activity Trend
-- Stacked bars by project + 7d MA overlay + cumulative unique counterparties
-- Date range: 2026-01-01+

-- ============================================================
-- BlockRunAI — USDC transfers
-- ============================================================
WITH blockrun_daily AS (
    SELECT
        DATE_TRUNC('day', evt_block_time) AS day,
        'BlockRunAI' AS project,
        COUNT(DISTINCT evt_tx_hash) AS daily_txs,
        COUNT(DISTINCT CASE
            WHEN "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf THEN "to"
            ELSE "from"
        END) AS daily_users,
        ROUND(SUM(CAST(value AS DOUBLE) / 1e6), 2) AS daily_usdc
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND (
          "from" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
          OR "to" = 0xe9030014F5DAe217d0A152f02A043567b16c1aBf
      )
      AND evt_block_time >= TIMESTAMP '2026-01-01'
      AND evt_block_time < CAST(CURRENT_DATE AS TIMESTAMP)
    GROUP BY 1
),

-- ============================================================
-- Floe Labs — base transactions + token transfers
-- ============================================================
floe_daily AS (
    SELECT day, 'Floe Labs' AS project, SUM(txs) AS daily_txs, SUM(users) AS daily_users, SUM(usdc) AS daily_usdc
    FROM (
        SELECT
            DATE_TRUNC('day', block_time) AS day,
            COUNT(DISTINCT hash) AS txs,
            COUNT(DISTINCT CASE
                WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
                ELSE "from"
            END) AS users,
            CAST(0 AS DOUBLE) AS usdc
        FROM base.transactions
        WHERE (
            "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
            OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        )
          AND success = true
          AND block_time >= TIMESTAMP '2026-01-01'
          AND block_time < CAST(CURRENT_DATE AS TIMESTAMP)
        GROUP BY 1

        UNION ALL

        SELECT
            DATE_TRUNC('day', evt_block_time) AS day,
            COUNT(DISTINCT evt_tx_hash) AS txs,
            COUNT(DISTINCT CASE
                WHEN "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1 THEN "to"
                ELSE "from"
            END) AS users,
            ROUND(SUM(CASE
                WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                THEN CAST(value AS DOUBLE) / 1e6
                ELSE 0
            END), 2) AS usdc
        FROM erc20_base.evt_Transfer
        WHERE (
            "from" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
            OR "to" = 0x58edde022ffdad3fb0fb0e7d51eb05aaf66a31f1
        )
          AND evt_block_time >= TIMESTAMP '2026-01-01'
          AND evt_block_time < CAST(CURRENT_DATE AS TIMESTAMP)
        GROUP BY 1
    ) combined
    GROUP BY 1
),

-- ============================================================
-- CoC x402 — dual-topic filter
-- ============================================================
coc_transfers_raw AS (
    SELECT
        block_time,
        tx_hash,
        VARBINARY_SUBSTRING(topic1, 13, 20) AS from_address,
        CAST(VARBINARY_TO_UINT256(data) AS DOUBLE) / 1e6 AS usdc_amount
    FROM base.logs
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND topic2 = 0x0000000000000000000000008b29dabd6fbb5a09dacbc7978eaed66a8540721d
      AND block_time >= TIMESTAMP '2026-01-01'
      AND block_time < CAST(CURRENT_DATE AS TIMESTAMP)
),

coc_auth_hashes AS (
    SELECT DISTINCT l.tx_hash
    FROM base.logs l
    INNER JOIN (SELECT DISTINCT tx_hash FROM coc_transfers_raw) t ON l.tx_hash = t.tx_hash
    WHERE l.contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND l.topic0 = 0x98de503528ee59b575ef0c0a2576a82497bfc029a5685b209e9ec333479b10a5
      AND l.block_time >= TIMESTAMP '2026-01-01'
),

coc_daily AS (
    SELECT
        DATE_TRUNC('day', ct.block_time) AS day,
        'CoC x402' AS project,
        COUNT(DISTINCT ct.tx_hash) AS daily_txs,
        COUNT(DISTINCT ct.from_address) AS daily_users,
        ROUND(SUM(ct.usdc_amount), 2) AS daily_usdc
    FROM coc_transfers_raw ct
    INNER JOIN coc_auth_hashes ca ON ct.tx_hash = ca.tx_hash
    GROUP BY 1
),

-- ============================================================
-- Combine per-project daily
-- ============================================================
all_daily AS (
    SELECT * FROM blockrun_daily
    UNION ALL
    SELECT * FROM floe_daily
    UNION ALL
    SELECT * FROM coc_daily
),

-- Total daily across all projects
daily_total AS (
    SELECT
        day,
        SUM(daily_txs) AS total_txs,
        SUM(daily_users) AS total_users,
        SUM(daily_usdc) AS total_usdc
    FROM all_daily
    GROUP BY 1
)

SELECT
    dt.day,
    dt.total_txs AS "Total Infra Txs",
    dt.total_users AS "Total Unique Addresses",
    ROUND(dt.total_usdc, 2) AS "USDC Volume",
    -- 7d Moving Averages
    ROUND(AVG(dt.total_txs) OVER (ORDER BY dt.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Infra Txs 7d MA",
    -- Cumulative
    SUM(dt.total_txs) OVER (ORDER BY dt.day) AS "Cumulative Txs",
    SUM(dt.total_usdc) OVER (ORDER BY dt.day) AS "Cumulative USDC Volume",
    -- Per-project breakdown
    COALESCE(MAX(CASE WHEN ad.project = 'BlockRunAI' THEN ad.daily_txs END), 0) AS "BlockRunAI Txs",
    COALESCE(MAX(CASE WHEN ad.project = 'Floe Labs' THEN ad.daily_txs END), 0) AS "Floe Labs Txs",
    COALESCE(MAX(CASE WHEN ad.project = 'CoC x402' THEN ad.daily_txs END), 0) AS "CoC x402 Txs",
    -- Per-project USDC
    COALESCE(MAX(CASE WHEN ad.project = 'BlockRunAI' THEN ad.daily_usdc END), 0) AS "BlockRunAI USDC",
    COALESCE(MAX(CASE WHEN ad.project = 'CoC x402' THEN ad.daily_usdc END), 0) AS "CoC x402 USDC"
FROM daily_total dt
LEFT JOIN all_daily ad ON dt.day = ad.day
GROUP BY 1, 2, 3, 4
ORDER BY 1 ASC
```

### Как оформить: 2 Графика (РЯДЫ S5-3 и S5-4)

**График 5.2a — "Tools & Infra: Daily Transaction Activity" (РЯД S5-3, 12 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Stacked Bar Chart** |
| X-axis | `day` |
| Stacked bars | `BlockRunAI Txs` (Blue `#3B82F6`), `Floe Labs Txs` (Slate `#64748B`), `CoC x402 Txs` (Pink `#EC4899`) |
| Line overlay | `Infra Txs 7d MA` (Amber `#F59E0B`, line width 2, dashed) |
| Высота | 350px |
| Заголовок | `Tools & Infra - Daily Transaction Activity` |
| Описание | `Stacked daily transactions across BlockRunAI, Floe Labs, and CoC x402 agentic payments` |

**График 5.2b — "Cumulative USDC Volume" (РЯД S5-4, 6 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Area Chart** |
| X-axis | `day` |
| Y-axis | `Cumulative USDC Volume` (area, Blue `#3B82F6`, opacity 0.3) |
| Высота | 300px |
| Заголовок | `Cumulative USDC Volume` |
| Y-axis label | `USD` |

**График 5.2c — "Cumulative Transactions" (РЯД S5-4, 6 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Line Chart** |
| X-axis | `day` |
| Y-axis | `Cumulative Txs` (line, Purple `#8B5CF6`, width 2) |
| Высота | 300px |
| Заголовок | `Cumulative Transactions` |

---

## QUERY 5.3: CoC x402 — Agentic Payments Deep Dive

### Что он делает
Отдельный запрос специально для x402 агентских платежей в Clash of Coins. Показывает ежедневные USDC-платежи через x402, уникальных плательщиков и средний размер платежа.

Логика фильтрации (из запроса Hempanda #7400157):
1. Находим все Transfer events USDC на адрес CoC payTo (`0x8b29...`)
2. Из них оставляем только транзакции, в которых ТАКЖЕ есть событие AuthorizationUsed (x402)
3. Это изолирует агентские платежи от обычных пользовательских переводов

### Название при сохранении
`CoC x402 - Agentic Payments (V1)`

### SQL-код

```sql
-- Section 5: CoC x402 Agentic Payments Deep Dive
-- Isolates AI agent payments in Clash of Coins using dual-topic filter:
--   Transfer (USDC to payTo) + AuthorizationUsed (x402) in same tx
-- Source: Hempanda research, query #7400157
-- Reference: https://x402.clashofcoins.com/shop/x402/offers

WITH target_transfers AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        tx_hash,
        VARBINARY_SUBSTRING(topic1, 13, 20) AS from_address,
        CAST(VARBINARY_TO_UINT256(data) AS DOUBLE) / 1e6 AS usdc_amount
    FROM base.logs
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND topic0 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
      AND topic2 = 0x0000000000000000000000008b29dabd6fbb5a09dacbc7978eaed66a8540721d
      AND block_time >= TIMESTAMP '2026-01-01'
      AND block_time < CAST(CURRENT_DATE AS TIMESTAMP)
),

authorized_hashes AS (
    SELECT DISTINCT l.tx_hash
    FROM base.logs l
    INNER JOIN (
        SELECT DISTINCT tx_hash FROM target_transfers
    ) t ON l.tx_hash = t.tx_hash
    WHERE l.contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND l.topic0 = 0x98de503528ee59b575ef0c0a2576a82497bfc029a5685b209e9ec333479b10a5
      AND l.block_time >= TIMESTAMP '2026-01-01'
),

x402_payments AS (
    SELECT
        tt.day,
        tt.tx_hash,
        tt.from_address,
        tt.usdc_amount
    FROM target_transfers tt
    INNER JOIN authorized_hashes ah ON tt.tx_hash = ah.tx_hash
)

SELECT
    day,
    COUNT(DISTINCT tx_hash) AS "x402 Payments",
    COUNT(DISTINCT from_address) AS "Unique Payers",
    ROUND(SUM(usdc_amount), 2) AS "USDC Volume",
    ROUND(AVG(usdc_amount), 2) AS "Avg Payment (USD)",
    -- Cumulative
    SUM(COUNT(DISTINCT tx_hash)) OVER (ORDER BY day) AS "Cumulative Payments",
    SUM(SUM(usdc_amount)) OVER (ORDER BY day) AS "Cumulative USDC",
    -- 7d MA
    ROUND(AVG(COUNT(DISTINCT tx_hash)) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Payments 7d MA"
FROM x402_payments
GROUP BY 1
ORDER BY 1 ASC
```

### Как оформить: Таблица + График (РЯД S5-5)

**Визуализация 5.3a — "CoC x402 Agentic Payments" (Table, 12 колонок)**

| Колонка | Формат |
|---------|--------|
| `day` | Date (YYYY-MM-DD) |
| `x402 Payments` | Number |
| `Unique Payers` | Number |
| `USDC Volume` | USD ($), 2 дес. |
| `Avg Payment (USD)` | USD ($), 2 дес. |
| `Cumulative Payments` | Number |
| `Cumulative USDC` | USD ($), 2 дес. |

Сортировка по умолчанию: `day` DESC (новые сверху).

**Визуализация 5.3 — "CoC x402 Agentic Payments" (Bar + Line, 12 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Bar Chart** с **Line overlay** |
| X-axis | `day` |
| Bars | `x402 Payments` (Pink `#EC4899`) |
| Line 1 | `Payments 7d MA` (Amber `#F59E0B`, dashed) |
| Высота | 300px |
| Заголовок | `CoC x402: Daily Agentic Payments` |
| Описание | `Pure signal: only x402-verified AI agent purchases in Clash of Coins. Human payments filtered out via AuthorizationUsed events.` |

---

## QUERY 5.4: Agently Catalog — Agent Growth & Composition

### Что он делает
Отслеживает рост каталога агентов на платформе Agently (use-agently.com). Данные оффчейн — ежедневные регистрации новых агентов, кумулятивный рост, распределение по блокчейнам и протоколам. Данные хардкодятся через VALUES и обновляются вручную.

### Описание для дашборда
> The agent registry in motion — daily onboarding velocity, cumulative growth, and ecosystem composition by chain and protocol.

### Название при сохранении
`Agently Catalog - Agent Growth & Composition (V1)`

### SQL-код

```sql
-- Section 5: Agently Catalog — Agent Onboarding & Ecosystem Composition
-- Offchain data from https://use-agently.com/ (Hempanda research, query #7401373)
-- Shows daily agent registrations, cumulative growth, chain & protocol distribution
--
-- Save as: "Agently Catalog - Agent Growth & Composition (V1)"

WITH daily AS (
    SELECT * FROM (
        VALUES
            (DATE '2026-04-23', 2),
            (DATE '2026-04-22', 6),
            (DATE '2026-04-21', 1),
            (DATE '2026-04-20', 2),
            (DATE '2026-04-19', 1),
            (DATE '2026-04-17', 1),
            (DATE '2026-04-16', 2),
            (DATE '2026-04-13', 1),
            (DATE '2026-04-12', 2),
            (DATE '2026-04-11', 16),
            (DATE '2026-04-10', 5),
            (DATE '2026-04-09', 7),
            (DATE '2026-04-08', 6),
            (DATE '2026-04-07', 2),
            (DATE '2026-04-06', 5),
            (DATE '2026-04-05', 2),
            (DATE '2026-04-04', 6),
            (DATE '2026-04-03', 3),
            (DATE '2026-04-02', 1),
            (DATE '2026-04-01', 7),
            (DATE '2026-03-31', 18),
            (DATE '2026-03-30', 1),
            (DATE '2026-03-29', 1),
            (DATE '2026-03-28', 5),
            (DATE '2026-03-27', 11),
            (DATE '2026-03-26', 8),
            (DATE '2026-03-25', 11),
            (DATE '2026-03-24', 46),
            (DATE '2026-03-23', 75),
            (DATE '2026-03-22', 110),
            (DATE '2026-03-21', 35),
            (DATE '2026-03-20', 9),
            (DATE '2026-03-19', 4),
            (DATE '2026-03-18', 51),
            (DATE '2026-03-17', 11),
            (DATE '2026-03-16', 15),
            (DATE '2026-03-15', 14),
            (DATE '2026-03-14', 5),
            (DATE '2026-03-13', 22),
            (DATE '2026-03-12', 3),
            (DATE '2026-03-11', 20),
            (DATE '2026-03-10', 11),
            (DATE '2026-03-09', 5),
            (DATE '2026-03-08', 77),
            (DATE '2026-03-07', 102),
            (DATE '2026-03-06', 123),
            (DATE '2026-03-05', 32),
            (DATE '2026-03-04', 9),
            (DATE '2026-03-03', 273),
            (DATE '2026-03-02', 12),
            (DATE '2026-03-01', 101),
            (DATE '2026-02-28', 9),
            (DATE '2026-02-27', 8),
            (DATE '2026-02-26', 154),
            (DATE '2026-02-25', 116),
            (DATE '2026-02-24', 45),
            (DATE '2026-02-23', 4),
            (DATE '2026-02-22', 11),
            (DATE '2026-02-21', 13),
            (DATE '2026-02-20', 10),
            (DATE '2026-02-19', 27),
            (DATE '2026-02-18', 9),
            (DATE '2026-02-17', 5),
            (DATE '2026-02-16', 3),
            (DATE '2026-02-15', 4),
            (DATE '2026-02-14', 10),
            (DATE '2026-02-13', 7),
            (DATE '2026-02-12', 4),
            (DATE '2026-02-11', 11),
            (DATE '2026-02-10', 30),
            (DATE '2026-02-09', 45),
            (DATE '2026-02-08', 33),
            (DATE '2026-02-07', 10),
            (DATE '2026-02-06', 8),
            (DATE '2026-02-05', 13),
            (DATE '2026-02-04', 9),
            (DATE '2026-02-03', 17),
            (DATE '2026-02-02', 24),
            (DATE '2026-02-01', 23),
            (DATE '2026-01-31', 7),
            (DATE '2026-01-30', 13),
            (DATE '2026-01-29', 8)
    ) AS t(day, agents_added)
)

SELECT
    day,
    agents_added AS "New Agents",
    SUM(agents_added) OVER (ORDER BY day) AS "Cumulative Agents",
    ROUND(AVG(agents_added) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "7d MA",

    -- chain constants (latest snapshot)
    1583 AS "Base Agents",
    275 AS "BNB Agents",
    128 AS "Ethereum Agents",
    7 AS "Arbitrum Agents",
    4 AS "Polygon Agents",
    3 AS "Optimism Agents",

    -- protocol constants (latest snapshot)
    1496 AS "MCP Agents",
    1117 AS "A2A Agents",
    513 AS "Web Agents",
    369 AS "OASF Agents",
    2 AS "Email Agents"

FROM daily
ORDER BY day ASC
```

### Как оформить: 3 визуализации (РЯДЫ S5-6, S5-7, S5-8)

**Визуализация 5.4a — "Agently: Agent Onboarding Velocity" (Bar + Area, РЯД S5-6, 12 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Combo Chart** (Bar + Area) |
| X-axis | `day` |
| Bars | `New Agents` (Cyan `#06B6D4`) |
| Area | `Cumulative Agents` (Green `#10B981`, opacity 0.15, right Y-axis) |
| Line overlay | `7d MA` (Amber `#F59E0B`, dashed, width 2) |
| Высота | 350px |
| Заголовок | `Agently: Agent Onboarding Velocity` |
| Описание | `Daily new agent registrations (bars) with cumulative growth (area) and 7-day moving average (line). Offchain data from use-agently.com catalog.` |

**Как создать в Dune:**
1. Открой запрос → New visualization → **Bar Chart**
2. X-axis: `day`
3. Add series: `New Agents` → тип: Bar, цвет: `#06B6D4`
4. Add series: `Cumulative Agents` → тип: Area, цвет: `#10B981`, opacity: 0.15, ось: Right Y
5. Add series: `7d MA` → тип: Line, цвет: `#F59E0B`, style: dashed

**Визуализация 5.4b — "Agents by Blockchain" (Pie/Donut, РЯД S5-7, 6 колонок)**

Для пирога нужно создать **отдельную визуализацию** из того же запроса. Dune берёт первую строку, а chain-колонки — константы, одинаковые в каждой строке.

| Параметр | Значение |
|----------|----------|
| Тип | **Pie Chart** (donut) |
| Слайсы | Создай вручную из первой строки: Base (1583), BNB (275), Ethereum (128), Arbitrum (7), Polygon (4), Optimism (3) |
| Цвета | Base: `#3B82F6`, BNB: `#F59E0B`, Ethereum: `#8B5CF6`, Arbitrum: `#06B6D4`, Polygon: `#EC4899`, Optimism: `#EF4444` |
| Заголовок | `Agents by Blockchain` |
| Описание | `79% of registered agents are on Base — the dominant chain for agentic infrastructure.` |

> **Примечание:** Dune pie charts работают по колонкам одной строки. В данном случае колонки `Base Agents`, `BNB Agents`, `Ethereum Agents` и т.д. — это как раз то, что нужно. Выбери **Counter/Pie** визуализацию и укажи колонки как series.

**Визуализация 5.4c — "Agents by Protocol" (Pie/Donut, РЯД S5-7, 6 колонок)**

| Параметр | Значение |
|----------|----------|
| Тип | **Pie Chart** (donut) |
| Слайсы | MCP (1496), A2A (1117), Web (513), OASF (369), Email (2) |
| Цвета | MCP: `#3B82F6`, A2A: `#10B981`, Web: `#8B5CF6`, OASF: `#F59E0B`, Email: `#64748B` |
| Заголовок | `Agents by Protocol` |
| Описание | `MCP and A2A protocols dominate — together powering 75% of all registered agents.` |

---

## ОПИСАНИЯ ИНДИКАТОРОВ

Краткие описания для каждого индикатора — использовать в **Description** поле виджетов на Dune.

### Query 5.1: Tools & Infra — Combined KPIs
> **Dashboard description:** Headline metrics across all agentic infrastructure on Base — total throughput, reach, and weekly momentum in one glance. Covers BlockRunAI, Floe Labs, and CoC x402 agentic payments.

### Query 5.2: Tools & Infra — Daily Activity Trend
> **Dashboard description:** Who's building the rails? Daily breakdown of transaction volume by project, revealing which infrastructure captures the most agent traffic. BlockRunAI dominates with 500K+ USDC transfers routed through its contracts.

### Query 5.3: CoC x402 — Agentic Payments
> **Dashboard description:** Pure signal: only x402-verified AI agent purchases in Clash of Coins. Human payments filtered out via dual-topic filtering (Transfer + AuthorizationUsed in same tx). Shows daily payment count, USDC volume, and unique payers.

### Query 5.4: Agently Catalog — Agent Growth & Composition
> **Dashboard description:** The agent registry in motion — daily onboarding velocity, cumulative growth, and ecosystem composition by chain and protocol. Base hosts 79% of all agents. MCP and A2A protocols power 75% of the catalog. Offchain data from use-agently.com.

---

## ВИЗУАЛИЗАЦИИ И ОФОРМЛЕНИЕ

### Все визуализации Section 5

| # | Тип | Источник | Заголовок |
|---|-----|----------|-----------|
| S5-Text | Text Widget | — | Tools & Infrastructure: The Rails of Agentic Economy |
| S5-C1 | Counter | Query 5.1 | Total Transactions |
| S5-C2 | Counter | Query 5.1 | Unique Counterparties |
| S5-C3 | Counter | Query 5.1 | USDC Volume |
| S5-C4 | Counter | Query 5.1 | Active Projects |
| S5-C5 | Counter | Query 5.1 | WoW Growth |
| S5-G1 | Stacked Bar | Query 5.2 | Tools & Infra - Daily Transaction Activity |
| S5-G2 | Area Chart | Query 5.2 | Cumulative USDC Volume |
| S5-G3 | Line Chart | Query 5.2 | Cumulative Transactions |
| S5-G4 | Bar + Line | Query 5.3 | CoC x402: Daily Agentic Payments |
| S5-G5 | Bar + Area + Line | Query 5.4 | Agently: Agent Onboarding Velocity |
| S5-P1 | Pie (Donut) | Query 5.4 | Agents by Blockchain |
| S5-P2 | Pie (Donut) | Query 5.4 | Agents by Protocol |

**Итого: 13 элементов (1 text + 5 counters + 5 charts + 2 pies) в 8 рядах.**

---

## КАРТА LAYOUT

```
=====================================================================
  SECTION 5: TOOLS & INFRASTRUCTURE
=====================================================================

РЯД S5-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — 12 колонок]
          "Tools & Infrastructure: The Rails of Agentic Economy"

РЯД S5-2: [5 КАУНТЕРОВ из Query 5.1]
          | Total Transactions | Unique Counterparties | USDC Volume |
          | Active Projects | WoW Growth % |

РЯД S5-3: [ГРАФИК 5.2a — 12 колонок]
          Daily Transaction Activity (stacked bars by project + 7d MA)

РЯД S5-4: [ГРАФИК 5.2b — 6 кол.]  [ГРАФИК 5.2c — 6 кол.]
          Cumulative USDC Volume     Cumulative Transactions

РЯД S5-5: [ГРАФИК 5.3 — 12 колонок]
          CoC x402: Daily Agentic Payments (bar + line)

РЯД S5-6: [ГРАФИК 5.4a — 12 колонок]
          Agently: Agent Onboarding Velocity (bars + area + 7d MA line)

РЯД S5-7: [PIE 5.4b — 6 кол.]        [PIE 5.4c — 6 кол.]
          Agents by Blockchain          Agents by Protocol

РЯД S5-8: (резерв для будущих индикаторов)
```

---

## ЦВЕТОВАЯ ПАЛИТРА

| Element | Color | HEX |
|---------|-------|-----|
| BlockRunAI | Blue | `#3B82F6` |
| Floe Labs | Slate | `#64748B` |
| CoC x402 | Pink/Magenta | `#EC4899` |
| USDC Volume / Money | Amber | `#F59E0B` |
| Growth / Positive | Green | `#10B981` |
| Decline / Negative | Red | `#EF4444` |
| Counterparties | Purple | `#8B5CF6` |
| Agently Bars | Cyan | `#06B6D4` |
| Agently Cumulative | Green | `#10B981` |
| Cumulative Lines | Dark Blue `#1E40AF`, Dark Pink `#BE185D` |
| 7d MA Lines | Amber `#F59E0B` (dashed) |

---

## ПОРЯДОК ДЕЙСТВИЙ НА DUNE — ЧЕКЛИСТ

### Фаза 1: Создание запросов

- [ ] **1.1** Открой [dune.com](https://dune.com) → New Query
- [ ] **1.2** Вставь SQL из Query 5.1 → Run → Сохрани как `Tools & Infra - Combined KPIs (V1)`
- [ ] **1.3** Создай 5 Counter визуализаций из результата Query 5.1 (по таблице выше)
- [ ] **1.4** Новый запрос → Вставь SQL из Query 5.2 → Run → Сохрани как `Tools & Infra - Daily Activity Trend (V1)`
- [ ] **1.5** Создай 3 визуализации: Stacked Bar (5.2a), Area (5.2b), Line (5.2c)
- [ ] **1.6** Новый запрос → Вставь SQL из Query 5.3 → Run → Сохрани как `CoC x402 - Agentic Payments (V1)`
- [ ] **1.7** Создай визуализацию Bar + Line (5.3): bars = x402 Payments, line = 7d MA
- [ ] **1.8** Новый запрос → Вставь SQL из Query 5.4 → Run → Сохрани как `Agently Catalog - Agent Growth & Composition (V1)`
- [ ] **1.9** Создай визуализацию 5.4a: Bar+Area+Line (New Agents bars, Cumulative area, 7d MA line)
- [ ] **1.10** Создай визуализацию 5.4b: Pie/Donut (Agents by Blockchain)
- [ ] **1.11** Создай визуализацию 5.4c: Pie/Donut (Agents by Protocol)

### Фаза 2: Размещение на дашборде

- [ ] **2.1** Открой https://dune.com/ax1research/base-agentic-ecosystem → Edit
- [ ] **2.2** Найди место ПОСЛЕ Base vs Solana и ПЕРЕД Base Agentic Gaming
- [ ] **2.3** Добавь Text Widget (S5-1): скопируй текст из секции выше → растяни на 12 колонок
- [ ] **2.4** Добавь 5 каунтеров (S5-2): перетяни визуализации из Query 5.1
- [ ] **2.5** Добавь Stacked Bar chart (S5-3): визуализация 5.2a на 12 колонок
- [ ] **2.6** Добавь 2 графика (S5-4): Area (5.2b, 6 кол.) + Line (5.2c, 6 кол.)
- [ ] **2.7** Добавь Bar + Line chart (S5-5): визуализация 5.3 на 12 колонок
- [ ] **2.8** Добавь график Agently (S5-6): визуализация 5.4a на 12 колонок
- [ ] **2.9** Добавь 2 пирога (S5-7): Agents by Blockchain (6 кол.) + Agents by Protocol (6 кол.)
- [ ] **2.10** Проверь порядок: Section 5 → Section 3 (Gaming) → Section 4 (OWB)

### Фаза 3: Проверка и финализация

- [ ] **3.1** Обнови все 4 запроса — проверь что данные корректны
- [ ] **3.2** Проверь что BlockRunAI показывает 500K+ транзакций (а не 155)
- [ ] **3.3** Проверь что CoC x402 показывает только x402 платежи (не все USDC-переводы)
- [ ] **3.4** Проверь что Floe Labs показывает минимальную активность (это нормально — проект в тестировании)
- [ ] **3.5** Обнови Methodology footer: добавь описание Section 5 и его методологии
- [ ] **3.6** Проверь все каунтеры — формат, цвет, prefix/suffix
- [ ] **3.7** Сохрани дашборд

### Фаза 4 (опционально): Удаление старого запроса

- [ ] **4.1** Если старый запрос 7406368 ("Combined On-chain Activity V3.2") больше не нужен — убери его с дашборда
- [ ] **4.2** Или замени его на Query 5.2 (Daily Activity Trend), который делает то же самое, но правильно

---

## ИЗВЕСТНЫЕ ОГРАНИЧЕНИЯ

| Ограничение | Пояснение |
|-------------|-----------|
| **BlockRunAI: только USDC** | Мы трекаем только USDC-транзакции через адрес. Если BlockRunAI работает с другими токенами — это не учтено |
| **Floe Labs: минимальная активность** | Проект в тестировании. ~20 USD суммарных оборотов. Метрики покажут рост по мере запуска |
| **CoC x402: с марта 2026** | x402 платежи в CoC начались ~25.03.2026. Данные до этой даты будут пустыми |
| **4Mica: нет данных** | Контракт не найден. Добавим когда появится информация от команды |
| **Agently: оффчейн** | Данные с use-agently.com доступны только оффчейн. Обновляется вручную через VALUES в Query 5.4 |
| **Фасилитаторы Coinbase CDP** | x402 фасилитаторы ротируются на стороне Coinbase. Полный список может измениться |

---

## БУДУЩИЕ ДОРАБОТКИ (V2)

1. **Добавить другие фасилитаторы x402** — Coinbase CDP ротирует адреса, нужен полный список
2. **Agently — автоматизация обновлений** — сейчас VALUES обновляются вручную; нужен скрипт для авто-синхронизации с use-agently.com
3. **4Mica** — добавить когда станет известен контракт
4. **Ethy AI + Axelrod** — крупнейшие Virtuals-агенты по ACP (если решим добавить в Tools & Infra)
5. **TVL агентов** — балансы адресов, управляемых агентами (если появится snapshot data на Base)
6. **Revenue фасилитаторов** — доходы от комиссий x402 (никто пока не собирает эту метрику)

---

## ССЫЛКИ НА СУЩЕСТВУЮЩИЕ ЗАПРОСЫ (для справки)

| Автор | Запрос | Dune URL | Описание |
|-------|--------|----------|----------|
| Hempanda | BlockRunAI | `dune.com/queries/7396448` | 581K+ USDC транзакций через BlockRunAI |
| Hempanda | Floe Labs | `dune.com/queries/7397253` | Лендинг контракт Floe Labs |
| Hempanda | CoC x402 | `dune.com/queries/7400157` | Агентик платежи CoC через x402 |
| Hempanda | Agently | `dune.com/queries/7401373` | Offchain каталог агентов Agently |
| BOSSincrypto | Combined V3.2 | `dune.com/queries/7406368` | Комбинированный (содержит ошибки — см. раздел "Проблемы") |
