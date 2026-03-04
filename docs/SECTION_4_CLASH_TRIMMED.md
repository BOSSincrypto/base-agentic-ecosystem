# РАЗДЕЛ 4: OWB / Clash of Coins — Урезанная Версия (5-6 Виджетов)

> **Замена** текущей раздутой Section 4 (19+ виджетов) на компактную версию с 6 виджетами.
> **Дашборд:** `https://dune.com/agiai/base-agentic-gaming`
> **Цель:** Ключевые метрики Clash of Coins на кончиках пальцев, без перегрузки.

---

## ЧТО УБИРАЕМ

Из текущего Section 4 **удаляем**:

| Было | Убираем | Почему |
|------|---------|--------|
| 3 MRR каунтера + 1 chart + 1 pie | Оставляем 1 каунтер MRR | ARPU и Active Paying Addresses — дублируют Bot Census |
| 5 Bot Census каунтеров | Оставляем 2 ключевых | Total Bots + Monthly Active достаточно; New Bots и Avg Claims — детали |
| 4 Telemetry каунтера | Оставляем 1 (Total Txs 30d) | Avg Daily и Avg Volume — производные, легко считаются |
| Bot Activity Distribution chart | **Оставляем** | Единственная визуализация, показывающая состав аудитории |
| Daily Active Bots chart | Убираем | Поглощается общим Daily Activity chart |
| New vs Returning chart | Убираем | Красиво, но не критично |
| DEX Volume chart | Убираем | Уже есть в Section 1-2 overview |
| Contract Breakdown pie | Убираем | Детальность для nerds, не для overview |
| Hourly Heatmap | Убираем | Интересно, но занимает целый ряд |
| 3 text widgets (sub-headers) | Убираем 2, оставляем 1 | Один компактный header достаточно |

**Итого после обрезки:**
- 1 text widget (header)
- 5 каунтеров
- 1 chart (Bot Activity Distribution)
= **7 элементов** (или 6 если убрать text header)

---

## НОВАЯ КАРТА LAYOUT (SECTION 4)

```
=====================================================================
  SECTION 4: CLASH OF COINS (OWB) — COMPACT
=====================================================================

РЯД S4-1: [ТЕКСТ-РАЗДЕЛИТЕЛЬ — 12 колонок]
          "Clash of Coins (OWB): Agentic Economy Snapshot"

РЯД S4-2: [5 КАУНТЕРОВ — распределение по 2-3 колонки каждый]
          | MRR Proxy (USD) | Total Bots | Monthly Active Bots |
          | Total Txs (30d) | WoW Growth % |

РЯД S4-3: [ГРАФИК — Bot Activity Distribution — 12 колонок]
          Horizontal bar: frequency cohorts (one-time / casual / regular / power / whale)
```

**Всего: 3 ряда. 7 элементов (1 text + 5 counters + 1 chart).**

---

## TEXT WIDGET: Section 4 Header (РЯД S4-1)

**Как добавить:** Edit dashboard → Add text widget → вставь текст → растяни на 12 колонок.

```markdown
---

## Clash of Coins (OWB): Agentic Economy Snapshot

**OWB** is the first large-scale GameAI project on Base — 30K+ DAU, $1M agentic tournament, Agentic-as-a-Service platform. Below: 5 key metrics + bot composition analysis.

Contracts: [OWB Token](https://basescan.org/address/0xEF5997c2cf2f6c138196f8a6203afc335206b3c1) · [ClaimRewards](https://basescan.org/address/0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40) · [oCOIN](https://basescan.org/address/0x5B8F638330d7D6bD9D43811fe702F6894e97EF03) · [Aerodrome Pool](https://basescan.org/address/0x995985c9027e8a90c823a5e0a9112fea72d1f4dd)
```

---

## QUERY 4.1: Clash of Coins — Key Metrics (ЕДИНСТВЕННЫЙ ОСНОВНОЙ ЗАПРОС)

### Что он делает
Один консолидированный запрос, который выдаёт все 5 KPI-каунтеров для Section 4. Объединяет MRR proxy, bot census и transaction telemetry в один результат.

### Название при сохранении
`OWB Clash - Key Metrics (Compact)`

### SQL-код

```sql
-- OWB Clash of Coins: Consolidated Key Metrics (Compact Section 4)
-- Outputs 5 KPI values for counter widgets
-- MRR Proxy + Total Bots + Monthly Active Bots + Txs 30d + WoW Growth

WITH owb_contracts AS (
    SELECT address FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40),
        (0x5B8F638330d7D6bD9D43811fe702F6894e97EF03)
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
      AND t.block_time >= DATE '2025-01-01'
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

### Как оформить: 5 Каунтеров (РЯД S4-2)

Из единственной строки результата создай **5 Counter-визуализаций**:

| # | Заголовок | Колонка | Формат | Цвет | Ширина |
|---|-----------|---------|--------|------|--------|
| 1 | **MRR Proxy (USD)** | `MRR Proxy (USD)` | USD, 0 десятичных | Emerald `#22C55E` | 2-3 кол. |
| 2 | **Total Bots** | `Total Bots (All-Time)` | Number | Orange `#F97316` | 2-3 кол. |
| 3 | **Monthly Active Bots** | `Monthly Active Bots` | Number | Cyan `#06B6D4` | 2-3 кол. |
| 4 | **Total Txs (30d)** | `Total Txs (30d)` | Number | Pink `#EC4899` | 2-3 кол. |
| 5 | **WoW Growth** | `WoW Growth %` | Percentage (1 дес.) | Green `#10B981` (если >0) / Red `#EF4444` (если <0) | 2-3 кол. |

**Как создать каунтер в Dune:**
1. Открой запрос `OWB Clash - Key Metrics (Compact)` → Run
2. Нажми **New visualization** → выбери **Counter**
3. В поле **Column** выбери нужную колонку (напр. `MRR Proxy (USD)`)
4. В **Title** впиши название
5. В **Prefix** поставь `$` для USD-метрик
6. В **Suffix** поставь `%` для WoW Growth
7. Повтори для каждого каунтера (5 раз из одного запроса)

---

## QUERY 4.2: Bot Activity Distribution (ЕДИНСТВЕННЫЙ CHART)

### Что он делает
Распределение ботов по частоте активности за 30 дней. Показывает, кто "одноразовый", кто "казуальный", а кто "whale bot".

### Название при сохранении
`OWB Clash - Bot Activity Distribution`

### SQL-код

```sql
-- OWB Clash of Coins: Bot Activity Distribution (30d Frequency Cohorts)
-- Who are the most active agents?

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

### Как оформить: Horizontal Bar Chart (РЯД S4-3 — 12 колонок)

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

## ИТОГО: ПОЛНЫЙ СПИСОК ЗАПРОСОВ SECTION 4 (TRIMMED)

| # | Название в Dune | Визуализации | Rows на dashboard |
|---|----------------|-------------|-------------------|
| 4.1 | `OWB Clash - Key Metrics (Compact)` | 5 Counters | 1 ряд |
| 4.2 | `OWB Clash - Bot Activity Distribution` | 1 Horizontal Bar | 1 ряд |
| — | Text widget (header) | 1 Text | 1 ряд |
| **Total** | **2 queries** | **7 elements** | **3 ряда** |

**Было: 7 queries → 19+ виджетов → 12 рядов**
**Стало: 2 queries → 7 виджетов → 3 ряда**

---

## ЧТО УДАЛИТЬ С ТЕКУЩЕГО ДАШБОРДА

На `https://dune.com/agiai/base-agentic-gaming` нужно удалить следующие виджеты Section 4:

1. **Удалить text widget** "OWB Agentic Gaming: GameAI Economy on Base" → заменить на компактный header выше
2. **Удалить каунтеры**: Monthly Revenue (MRR Proxy), Active Paying Addresses, ARPU → заменить на 5 новых каунтеров
3. **Удалить chart**: Monthly Revenue Trend (bar+line) + Revenue Sources pie
4. **Удалить text widget** "Bot / Agent Census"
5. **Удалить каунтеры**: Total Bots (All-Time), Daily Active Bots, Monthly Active Bots, New Bots (30d), Avg Claims / Bot → заменены новыми каунтерами
6. **Удалить charts**: OWB Daily Active Bots, New vs Returning Bots
7. **Оставить chart**: Bot Activity Distribution (30d) — он остаётся!
8. **Удалить text widget** "OWB Smart Contract Telemetry"
9. **Удалить каунтеры**: Total Txs (30d), Unique Addresses (30d), Avg Daily Volume, Avg Daily Txs
10. **Удалить charts**: OWB DEX Volume (USD), OWB Daily Transaction Activity, Activity by Contract pie
11. **Удалить chart**: Hourly Activity Heatmap (если был добавлен)

**Порядок действий:**
1. Удали все виджеты Section 4 (см. список выше)
2. Создай Query 4.1 (`OWB Clash - Key Metrics (Compact)`) → Run → Save
3. Создай 5 Counter визуализаций из Query 4.1
4. Query 4.2 (`OWB Clash - Bot Activity Distribution`) — уже существует, если создавали ранее. Если нет — создай.
5. Добавь text widget (compact header)
6. Расставь по layout: text → 5 каунтеров → bar chart
7. Готово. 3 ряда вместо 12.

---

## ЦВЕТОВАЯ ПАЛИТРА (БЕЗ ИЗМЕНЕНИЙ)

| Element | Color | HEX |
|---------|-------|-----|
| MRR / Revenue | Emerald | `#22C55E` |
| Bot Metrics | Orange | `#F97316` |
| Active / Engagement | Cyan | `#06B6D4` |
| Activity / Txs | Pink | `#EC4899` |
| Growth (positive) | Green | `#10B981` |
| Decline (negative) | Red | `#EF4444` |

---

## ЕСЛИ ПОЗЖЕ ЗАХОЧЕТСЯ ВЕРНУТЬ ДЕТАЛИ

Все "убранные" queries остаются в репозитории — их можно вернуть на дашборд в любой момент:

| Что убрали | Где найти SQL | Когда может понадобиться |
|------------|--------------|------------------------|
| MRR Proxy (полный) | `queries/owb-gaming-dashboard/10_owb_mrr_proxy.sql` | Когда нужен breakdown по источникам |
| Bot Daily Trend | `queries/owb-gaming-dashboard/09_owb_bot_daily_trend.sql` | Когда нужна динамика bot vs human |
| Top Bot Wallets | `queries/owb-gaming-dashboard/13_owb_bot_top_wallets.sql` | Когда нужен drill-down по конкретным ботам |
| Hourly Heatmap | `queries/owb-gaming-dashboard/14_owb_bot_hourly_heatmap.sql` | Когда нужна почасовая аналитика |
| In-Game Economy | `queries/owb-gaming-dashboard/15_owb_coc_ingame_economy.sql` | Когда нужен анализ oCOIN/COC токенов |

---

*Документ создан: 4 марта 2026*
*Trimmed version: 19+ widgets → 7 widgets, 7 queries → 2 queries*
