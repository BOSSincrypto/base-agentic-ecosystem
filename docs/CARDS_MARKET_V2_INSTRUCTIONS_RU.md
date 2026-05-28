# CARDS MARKET V2 — Sections 7, 8, 9: Полная Инструкция

> **Название дашборда:** `Tokenized Cards Market 2026`
> **URL:** https://dune.com/ax1research/cards-market
> **Поддерживается:** [AX1 Community](https://twitter.com/AX1ecosystem)
> **Версия:** V2 rev.2 — оптимизированные запросы (5 вместо 10)

---

## ОБЩАЯ СТРУКТУРА НОВЫХ СЕКЦИЙ

Три новые секции добавляются к существующему дашборду Cards Market:

| Секция | Запрос | Что отслеживает |
|--------|--------|-----------------|
| **Section 7: Collector Crypt Deep Dive** | Запрос 1 (7.1+7.2+7.3), Запрос 2 (7.4a+7.4b), Запрос 3 (7.4c) | Гача: plays, USDC inflow, buyback, net revenue, $CARDS токен |
| **Section 8: Card Type Composition** | Запрос 4 (8.1+8.2) | Тематические категории карт по всем проектам |
| **Section 9: Beezie Deep Dive** | Запрос 5 (9.1+9.2) | Claw-машины по тирам, buyback через swap pool |

**Оптимизация:** 10 отдельных запросов объединены в 5 — каждый сканирует таблицу один раз. Экономия ~50% кредитов Dune.

---

## ЧТО ТЕБЕ НУЖНО СДЕЛАТЬ (ШАГ ЗА ШАГОМ)

---

### ШАГ 1: Открыть дашборд

1. Зайди на https://dune.com/ax1research/cards-market
2. Нажми **"Edit"** (режим редактирования)

---

### ШАГ 2: Создать 5 Queries (запросов)

Для каждого запроса ниже:
1. Нажми **"New"** -> **"Query"**
2. Вставь SQL-код
3. Выбери движок: **medium** (для Solana) или **small** (для Base)
4. Нажми **"Run"** чтобы проверить — убедись что данные вернулись
5. Сохрани с названием, которое указано

---

### ШАГ 3: Добавить виджеты на дашборд

После создания каждого запроса:
1. Открой дашборд в режиме **"Edit"**
2. Нажми **"Add visualization"** и найди сохранённый запрос
3. Настрой визуализацию (тип графика, цвета, оси) как описано ниже
4. Перетащи и расположи виджеты по макету

---

## КАРТА РАСПОЛОЖЕНИЯ ВИДЖЕТОВ НА ДАШБОРДЕ

Новые секции добавляются к существующему дашборду:

```
... (существующие секции дашборда) ...

=== SECTION 8: Card Type Composition (между Market Share и Aftermarket) ===

РЯД 1:  [ТЕКСТ-ЗАГОЛОВОК — на всю ширину (12 колонок)]
         "Card Type Mix: Thematic Composition"

РЯД 2:  [ГРАФИК 8.1 — 5 колонок слева]  [ГРАФИК 8.2 — 7 колонок справа]
         Donut: Overall by Category            Stacked Bar: per Project

=== SECTION 7: Collector Crypt Deep Dive ===

РЯД 3:  [ТЕКСТ-ЗАГОЛОВОК — на всю ширину (12 колонок)]
         "Collector Crypt: Deep Dive"

РЯД 4:  [КАУНТЕР: plays 4wk — 4 кол] [КАУНТЕР: players 4wk — 4 кол] [КАУНТЕР: inflow 4wk — 4 кол]

РЯД 5:  [ГРАФИК 7.1 — 6 колонок слева]  [ГРАФИК 7.2 — 6 колонок справа]
         Bar: Gacha Plays                     Bar: Revenue Inflow

РЯД 6:  [ГРАФИК 7.3 — на всю ширину (12 колонок)]
         Combo: Buyback Outflow (бары) + Net Revenue (линия)

РЯД 7:  [ТЕКСТ-ПОДЗАГОЛОВОК — на всю ширину]
         "$CARDS Token Economy"

РЯД 8:  [ГРАФИК 7.4a — 6 колонок слева]  [ГРАФИК 7.4b — 6 колонок справа]
         Bar+Line: DEX Volume + Traders        Line: VWAP Price

РЯД 9:  [ГРАФИК 7.4c — на всю ширину (12 колонок)]
         H-Bar: Top 20 Holders

=== SECTION 9: Beezie Deep Dive ===

РЯД 10: [ТЕКСТ-ЗАГОЛОВОК — на всю ширину (12 колонок)]
         "Beezie: Claw Machine Economy"

РЯД 11: [ГРАФИК 9.1 — 6 колонок слева]  [ГРАФИК 9.2 — 6 колонок справа]
         Stacked Bar: Claw Inflow by Tier      Bar: Buyback

... (Methodology footer — обновить) ...
```

---

## ЦВЕТОВАЯ ПАЛИТРА

### Section 7 — Rarity (когда будет tier split)

| Элемент | Цвет | HEX |
|---------|-------|-----|
| Low | Серый | `#9CA3AF` |
| Mid | Синий | `#3B82F6` |
| High | Фиолетовый | `#8B5CF6` |
| Epic | Розовый | `#EC4899` |
| Legend | Золотой | `#F59E0B` |
| One | Красный | `#EF4444` |
| Sport | Зелёный | `#10B981` |
| Unmapped | Тёмно-серый | `#374151` |

### Section 8 — Card Type

| Элемент | Цвет | HEX |
|---------|-------|-----|
| Pokemon | Жёлтый | `#FFCB05` |
| Sport | Тёмно-синий | `#1E40AF` |
| Marvel/Disney | Красный | `#DC2626` |
| One Piece | Оранжевый | `#F97316` |
| TCG other | Фиолетовый | `#7C3AED` |
| Figurine/Other | Бирюзовый | `#14B8A6` |
| Unknown | Серый | `#6B7280` |

### Section 9 — Beezie Tiers

| Элемент | Цвет | HEX |
|---------|-------|-----|
| Wildcard | Серый | `#9CA3AF` |
| Silver TCG | Синий | `#3B82F6` |
| Gold TCG | Золотой | `#F59E0B` |
| Platinum TCG | Фиолетовый | `#8B5CF6` |
| No tier | Тёмно-серый | `#374151` |

---

## ТЕКСТОВЫЕ ВИДЖЕТЫ (Markdown)

### Виджет 1: Заголовок Section 8 — Card Type Mix

**Как добавить:** В режиме Edit нажми **"Add text widget"**, вставь текст ниже, растяни на всю ширину (12 колонок).

**Текст (скопируй как есть):**

```markdown
---

## Card Type Mix: Thematic Composition

The cards-on-chain market is not uniform: some projects skew Pokemon, others toward sport, One Piece, or other IP. This section shows what dominates overall and how each project distributes its catalogue.

**What's included:** Courtyard (Polygon NFT marketplace), Collector Crypt (Solana gacha). Phygitals will be added when metadata source is available.

**What's excluded:** Beezie (its on-chain axis is claw tier/price, not IP theme — see Beezie Deep Dive below). Upshot (prediction market, not a card collection).
```

---

### Виджет 2: Заголовок Section 7 — Collector Crypt Deep Dive

**Текст (скопируй как есть):**

```markdown
---

## Collector Crypt: Deep Dive

Collector Crypt is the deepest single-project economy in this dashboard: a multi-tier gacha mint, an active buyback program, and a separate token layer ($CARDS) trading on Solana DEXes. The visualizations below isolate each flow so they read independently — what users pay in, what the project pays back, what gets minted by tier, and the token leg, which is economically distinct from the cards themselves.

**Gacha wallets tracked:** GachaN, GachaZ, Main (3 wallets). A 22-address exclusion list removes team, bots, rarity-label and internal addresses.
```

---

### Виджет 3: Подзаголовок $CARDS Token Economy

**Текст (скопируй как есть):**

```markdown
---

### $CARDS Token Economy

$CARDS is Collector Crypt's project token on Solana, **separate from the gacha layer above**. Token volume reflects speculator activity, not card spend, and should not be aggregated with gacha revenue. The price is derived as Volume-Weighted Average Price (VWAP) from DEX trades.
```

---

### Виджет 4: Заголовок Section 9 — Beezie Deep Dive

**Текст (скопируй как есть):**

```markdown
---

## Beezie: Claw Machine Economy on Base

Beezie runs a claw-machine gacha on Base across four price tiers (Wildcard $30, Silver TCG $50, Gold TCG $250, Platinum TCG $500), with a buyback swap pool and an internal marketplace. Two machine generations exist: an old system with 15 machines taking direct USDC inflow, and a new system routing through Hub V1 → Hub V2.

**20 machines tracked:** 15 old-system (direct inflow) + 5 new-system (via Hub). All USDC on Base chain.
```

---

### Виджет 5: Методология (добавить к существующему Methodology footer)

**Текст (добавь в конец существующего футера):**

```markdown
---

### Methodology: Cards Market V2 Sections

#### Section 7 — Collector Crypt
Money flows computed from `tokens_solana.transfers` on the three gacha wallets (GachaN, GachaZ, Main). Inflow = USDC users send in; buyback outflow = USDC sent back; net = inflow − outflow per week. A 22-address exclusion list removes internal movement. Rarity-tier splits shown for play counts only; per-tier USDC attribution is not reliably recoverable on-chain. $CARDS (CARDScc…) queried separately from dex_solana.trades — represents token speculation, not card spend.

#### Section 8 — Card Type Composition
Cards grouped by IP theme. Courtyard categories from Polygon NFT metadata; Phygitals from Solana mint metadata (stub until source available); Collector Crypt is a coarse Sport-vs-Pokemon split. Beezie excluded (tier axis); Upshot excluded (prediction market).

#### Section 9 — Beezie
Claw inflow is USDC into machine contracts on Base across four tiers (old direct-inflow + new Hub-routed). Buyback is USDC out of the swap pool (0x80d7…).

#### Known Limitations
- **$PKMN token:** Ticker reserved (Oct 2025) but no token is live — no data to show.
- **Courtyard categories:** Dependent on NFT metadata mapping (@remmez). May show "Unknown" until confirmed.
- **Phygitals:** Stub — metadata source pending (@Hempanda).
- **CC rarity routing:** Not confirmed on-chain — 7.1 uses aggregate fallback.
- **Beezie new-system:** Machines may receive USDC from Hub V2 rather than end user directly — unique_players may be undercounted.
```

---

---

# ЗАПРОС 1: CC Core Weekly — Gacha Plays + Inflow + Buyback + Net Revenue (7.1 + 7.2 + 7.3)

## Что он делает
Сканирует `tokens_solana.transfers` **один раз** и классифицирует каждый трансфер как:
- `card_out` — карта отправлена из гачи пользователю (7.1 — plays)
- `usdc_in` — USDC пришёл в гачу от пользователя (7.2 — inflow)
- `usdc_out` — USDC отправлен из гачи пользователю (7.3 — buyback)

Затем агрегирует все три метрики по неделям в одном результате.

## На какие вопросы отвечает
- Сколько людей играет в гачу и получает карты? (7.1)
- Сколько USDC тратят пользователи на гачу? (7.2)
- Сколько USDC возвращается через buyback и какая чистая выручка? (7.3)

## Название запроса при сохранении
`Cards Market — CC Core Weekly (7.1+7.2+7.3)`

## Движок
**medium** (Solana — тяжёлая таблица)

## SQL-код (скопируй и вставь в Dune Query Editor)

```sql
WITH gacha AS (
    SELECT wallet FROM (VALUES
        ('GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'),
        ('GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z'),
        ('96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s')
    ) AS t(wallet)
),

exclusions AS (
    SELECT wallet FROM (VALUES
        ('BAxTk97HsaJqbnbFmTiQTaL4KSRvJ8Y65ArZCsP6vA5M'),
        ('21KhtC7y2JGYvwc8dcGqTdbrudbM8fgMPJsVwxRQqdY8'),
        ('DFEstpYN3fsz93AC9v2ujzPPngPgodqH2xxopuyfSsAE'),
        ('HW2HRqN1pXQGH9GfP9xet4XwqtLqFyYGDNRKjUAVgh9u'),
        ('Low6UekJP3QrFVMfNRTL8CPK2SiGFhvp57sgF2pkmVu'),
        ('Lowq9dkpY43VpjfYeRjtKfGA6JtB7HaMmwQgXkjHLvN'),
        ('Mid9NeCpPNxP59fAdsLgMLy7BYexxXFw52ZP58Jrney'),
        ('miDtj3vgdxVykHzRyFwyG8MXpvK8eQqamSLVdBr7WPt'),
        ('HighJBfnAaqH9cKkeMErQFJZ4ATxQJwxqFupX6zaKTns'),
        ('HiGHqwYddP5N2waqUmXPdaASpMpUEvfqPr2fSawctEb'),
        ('EpicWWZspT1trKndbDDr29ULViN56rN5vofWSKZp8ePF'),
        ('epiC3zkqa1RfcPMMM1Kc8m3GZGDwF2RmjbfA3g1BBjn'),
        ('LGNDXqcm6U57QQ6Ad7icZ6oizkAVKRWrw97KwZy5nVf'),
        ('LGNDfXQFMiRMz3qqTNAREmRFQutMvazqqRrzn5i98uj'),
        ('onePMfirJs2Rx3eixoPnjY6NHiaC74pkQ2k313K2Lxs'),
        ('SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD'),
        ('SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'),
        ('DQPERZ9e86pNJ4mhUnCEP8V75yxZofsipoVrRWT5Wdxd'),
        ('cc3novbXuNSe292qKH2gGhxToaWjuBvJbA7zQf8NVxi'),
        ('GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3'),
        ('GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z'),
        ('96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s')
    ) AS t(wallet)
),

classified AS (
    SELECT
        date_trunc('week', t.block_time) AS week,
        CASE
            WHEN t.from_owner IN (SELECT wallet FROM gacha)
                 AND t.to_owner NOT IN (SELECT wallet FROM exclusions)
                 AND t.token_mint_address != 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
            THEN 'card_out'
            WHEN t.to_owner IN (SELECT wallet FROM gacha)
                 AND t.from_owner NOT IN (SELECT wallet FROM exclusions)
                 AND t.token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
            THEN 'usdc_in'
            WHEN t.from_owner IN (SELECT wallet FROM gacha)
                 AND t.to_owner NOT IN (SELECT wallet FROM exclusions)
                 AND t.token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
            THEN 'usdc_out'
        END AS flow_type,
        t.amount,
        t.tx_id,
        t.from_owner,
        t.to_owner
    FROM tokens_solana.transfers t
    WHERE t.block_date >= DATE '2026-01-01'
      AND (
          t.from_owner IN (SELECT wallet FROM gacha)
          OR t.to_owner IN (SELECT wallet FROM gacha)
      )
)

SELECT
    week,
    approx_distinct(CASE WHEN flow_type = 'card_out' THEN tx_id END)      AS gacha_plays,
    approx_distinct(CASE WHEN flow_type = 'card_out' THEN to_owner END)    AS unique_players,
    COUNT(CASE WHEN flow_type = 'card_out' THEN 1 END)                     AS cards_distributed,
    ROUND(SUM(CASE WHEN flow_type = 'usdc_in' THEN amount / 1e6 ELSE 0 END), 2)   AS usdc_inflow,
    approx_distinct(CASE WHEN flow_type = 'usdc_in' THEN tx_id END)                 AS inflow_transfers,
    approx_distinct(CASE WHEN flow_type = 'usdc_in' THEN from_owner END)             AS unique_payers,
    ROUND(SUM(CASE WHEN flow_type = 'usdc_out' THEN amount / 1e6 ELSE 0 END), 2)   AS buyback_outflow,
    approx_distinct(CASE WHEN flow_type = 'usdc_out' THEN tx_id END)                 AS num_buybacks,
    approx_distinct(CASE WHEN flow_type = 'usdc_out' THEN to_owner END)              AS unique_recipients,
    ROUND(
        SUM(CASE WHEN flow_type = 'usdc_in' THEN amount / 1e6 ELSE 0 END)
      - SUM(CASE WHEN flow_type = 'usdc_out' THEN amount / 1e6 ELSE 0 END),
    2) AS net_revenue
FROM classified
WHERE flow_type IS NOT NULL
GROUP BY 1
ORDER BY week DESC
```

## Как оформить визуализации (3 графика + 3 каунтера из этого запроса)

### Каунтер 1: Total Plays Last 4 Weeks (РЯД 4, 4 колонки слева)

1. Нажми **"New visualization"**
2. Тип: **Counter**
3. **Название:** `Total Gacha Plays (4 wk)`
4. **Column:** `gacha_plays`
5. **Row:** 1 (первая строка = последняя неделя; если нужно суммировать 4 — используй отдельный counter query)

### Каунтер 2: Unique Players Last 4 Weeks (РЯД 4, 4 колонки центр)

1. Тип: **Counter**
2. **Название:** `Unique Players (4 wk)`
3. **Column:** `unique_players`

### Каунтер 3: Total USDC Inflow Last 4 Weeks (РЯД 4, 4 колонки справа)

1. Тип: **Counter**
2. **Название:** `USDC Inflow (4 wk)`
3. **Column:** `usdc_inflow`
4. **Prefix:** `$`
5. **Format:** `0.0a` (сокращённый формат)

### График 7.1: Weekly Gacha Plays (РЯД 5, левая половина)

1. Нажми **"New visualization"**
2. Тип: **Bar Chart**
3. **X-axis:** `week`
4. **Y-axis:** `gacha_plays`
5. Можно добавить вторую серию: `cards_distributed` — тип Line
6. **Цвет баров:** синий `#3B82F6`
7. **Ширина на дашборде:** 6 колонок (левая половина)
8. **Заголовок:** `Weekly Gacha Plays`
9. **Описание (Subtitle):** `Card pulls from 3 gacha wallets to external users. Aggregate — no tier split (rarity routing unconfirmed).`

### График 7.2: Weekly Revenue Inflow (РЯД 5, правая половина)

1. Тип: **Bar Chart**
2. **X-axis:** `week`
3. **Y-axis:** `usdc_inflow`
4. **Цвет баров:** золотой `#F59E0B`
5. **Y-axis format:** `$0.0a`
6. **Ширина:** 6 колонок (правая половина)
7. **Заголовок:** `Weekly USDC Revenue (Gacha Inflow)`
8. **Описание:** `Gross USDC paid by users into gacha wallets. This is what users spend to play — net revenue (after buyback) shown below.`

### График 7.3: Buyback & Net Revenue (РЯД 6, на всю ширину)

1. Тип: **Bar Chart** (combo)
2. **X-axis:** `week`
3. **Y-axis (бары):** `buyback_outflow` — цвет красный `#EF4444`
4. **Добавь вторую серию (линия):** `net_revenue` — тип **Line**, правая ось
5. **Цвет линии:** зелёный `#10B981`
6. **Y-axis format:** `$0.0a`
7. **Ширина:** 12 колонок (полная ширина)
8. **Заголовок:** `Buyback Outflow & Net Revenue`
9. **Описание:** `Bars = USDC paid back to users via buyback. Line = net gacha revenue (inflow minus outflow). Negative weeks = payout-heavy periods.`

---

---

# ЗАПРОС 2: $CARDS Token — DEX Volume + VWAP Price (7.4a + 7.4b)

## Что он делает
Сканирует `dex_solana.trades` **один раз** и считает дневной объём торгов $CARDS + VWAP цену.

## На какие вопросы отвечает
- Какой объём торгов $CARDS на DEX? (7.4a)
- Какая средневзвешенная цена $CARDS? (7.4b)
- Сколько уникальных трейдеров?

## Название запроса при сохранении
`Cards Market — $CARDS DEX Volume + Price (7.4a+7.4b)`

## Движок
**medium** (Solana)

## SQL-код

```sql
SELECT
    date_trunc('day', block_time) AS day,
    ROUND(SUM(amount_usd), 2)     AS dex_volume_usd,
    COUNT(*)                       AS num_trades,
    approx_distinct(trader_id)     AS unique_traders,
    ROUND(
        SUM(amount_usd) / NULLIF(SUM(
            CASE
                WHEN token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
                    THEN token_bought_amount
                WHEN token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
                    THEN token_sold_amount
            END
        ), 0),
        6
    ) AS vwap_price
FROM dex_solana.trades
WHERE block_date >= DATE '2025-09-01'
  AND (
      token_bought_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
      OR token_sold_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
  )
GROUP BY 1
HAVING SUM(amount_usd) > 0
ORDER BY day DESC
```

## Как оформить визуализации (2 графика из этого запроса)

### График 7.4a: $CARDS DEX Volume & Traders (РЯД 8, левая половина)

1. Нажми **"New visualization"**
2. Тип: **Bar Chart** (combo)
3. **X-axis:** `day`
4. **Y-axis (бары):** `dex_volume_usd` — цвет янтарный `#F59E0B`
5. **Добавь вторую серию (линия):** `unique_traders` — тип **Line**, правая ось
6. **Цвет линии:** фиолетовый `#8B5CF6`
7. **Y-axis format (левая):** `$0.0a`
8. **Ширина:** 6 колонок (левая половина)
9. **Заголовок:** `$CARDS Daily DEX Volume`
10. **Описание:** `Token volume reflects speculator activity, not card spend. $CARDS is economically separate from the gacha.`

### График 7.4b: $CARDS VWAP Price (РЯД 8, правая половина)

1. Тип: **Line Chart**
2. **X-axis:** `day`
3. **Y-axis:** `vwap_price`
4. **Цвет линии:** синий `#3B82F6`
5. **Y-axis format:** `$0.000000` (6 знаков)
6. **Ширина:** 6 колонок (правая половина)
7. **Заголовок:** `$CARDS VWAP Price`
8. **Описание:** `Volume-weighted average price derived from DEX trades. Fallback method — will switch to prices.usd_daily if Dune indexes $CARDS.`

---

---

# ЗАПРОС 3: $CARDS Top 20 Holders (7.4c)

## Что он делает
Считает net balance каждого кошелька по всем трансферам $CARDS и выводит топ-20.

## На какие вопросы отвечает
- Кто крупнейшие держатели $CARDS?
- Насколько концентрирован supply?

## Название запроса при сохранении
`Cards Market — $CARDS Top 20 Holders (7.4c)`

## Движок
**medium** (Solana, all-time scan)

## SQL-код

```sql
WITH flows AS (
    SELECT to_owner AS owner, amount AS net
    FROM tokens_solana.transfers
    WHERE token_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'

    UNION ALL

    SELECT from_owner AS owner, -amount AS net
    FROM tokens_solana.transfers
    WHERE token_mint_address = 'CARDSccUMFKoPRZxt5vt3ksUbxEFEcnZ3H2pd3dKxYjp'
),

balances AS (
    SELECT
        owner AS holder,
        SUM(net) AS balance
    FROM flows
    GROUP BY 1
    HAVING SUM(net) > 0
)

SELECT
    holder,
    ROUND(balance, 2) AS balance,
    ROUND(balance * 100.0 / SUM(balance) OVER (), 2) AS pct_supply
FROM balances
ORDER BY balance DESC
LIMIT 20
```

## Как оформить визуализацию (1 график)

### График 7.4c: Top 20 Holders (РЯД 9, на всю ширину)

1. Нажми **"New visualization"**
2. Тип: **Bar Chart** (горизонтальный)
3. **X-axis:** `pct_supply`
4. **Y-axis:** `holder`
5. **Ориентация:** Horizontal
6. **X-axis format:** `0.0%` (процентные лейблы)
7. **Цвет баров:** фиолетовый `#8B5CF6`
8. **Ширина:** 12 колонок (полная ширина)
9. **Заголовок:** `$CARDS Top 20 Holders by % Supply`
10. **Описание:** `Net balance from all transfers. Confirm token decimals before treating raw numbers as final.`

> **ПРИМЕЧАНИЕ:** Адреса в `holder` будут длинные. На дашборде Dune они автоматически обрезаются. Если хочешь красивее — можно добавить `CONCAT(SUBSTR(holder, 1, 6), '...', SUBSTR(holder, -4))` в SELECT.

---

---

# ЗАПРОС 4: Card Type Composition — Overall + Per Project (8.1 + 8.2)

## Что он делает
Объединяет данные Courtyard (Polygon NFT) + Collector Crypt (Solana gacha) по тематическим категориям. Выводит:
- `project = 'ALL'` — для общего donut (8.1)
- `project != 'ALL'` — для per-project stacked bar (8.2)

## На какие вопросы отвечает
- Какие тематики карт доминируют на рынке? (8.1)
- Как каждый проект распределяет свой каталог по IP темам? (8.2)

## Название запроса при сохранении
`Cards Market — Card Type Composition (8.1+8.2)`

## Движок
**medium** (Solana CTE для CC)

## SQL-код

```sql
WITH courtyard_cat AS (
    SELECT
        COALESCE(
            CAST(JSON_EXTRACT_SCALAR(metadata, '$.category') AS VARCHAR),
            'Unknown'
        ) AS category,
        COUNT(*) AS cards_count,
        'Courtyard' AS project
    FROM nft.mints
    WHERE blockchain = 'polygon'
      AND nft_contract_address = 0x251be3a17af4892035c37ebf5890f4a4d889dcad
      AND block_date >= DATE '2026-01-01'
    GROUP BY 1
),

-- Phygitals: stub — включи когда будет metadata source
-- phygitals_cat AS (
--     SELECT category, COUNT(*) AS cards_count, 'Phygitals' AS project
--     FROM <phygitals_mint_metadata_source>
--     WHERE block_date >= DATE '2026-01-01'
--     GROUP BY 1
-- ),

cc_cat AS (
    SELECT
        CASE
            WHEN from_owner IN (
                'SportGmqffp9zC3VZV7Wwz6s2nCkEB5Q3nVwKGU4esD',
                'SPrT7eFrCM9UJ4j7Xf9iktKCoBwJjfykFbiNbRsKQm8'
            ) THEN 'Sport'
            ELSE 'Pokemon'
        END AS category,
        COUNT(*) AS cards_count,
        'Collector Crypt' AS project
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND from_owner IN (
          'GachaNgyXTU3zFogQ8Z5jR2BLXs8215X2AtEH18VxJq3',
          'GachazZscHZ5bn3vnq1yEC4zpYdhAYJBzuKJwSJksc9z',
          '96DULv1BqYfe5wyMr6pVUNC6Uyrtj6yr3tNi6VtfwW9s'
      )
    GROUP BY 1
),

all_cat AS (
    SELECT project, category, cards_count FROM courtyard_cat
    UNION ALL
    SELECT project, category, cards_count FROM cc_cat
),

project_totals AS (
    SELECT project, SUM(cards_count) AS total FROM all_cat GROUP BY 1
),

grand_total AS (
    SELECT SUM(cards_count) AS total FROM all_cat
),

per_project AS (
    SELECT
        a.project,
        a.category,
        SUM(a.cards_count) AS cards_count,
        ROUND(SUM(a.cards_count) * 100.0 / NULLIF(pt.total, 0), 2) AS pct_of_project
    FROM all_cat a
    JOIN project_totals pt ON a.project = pt.project
    GROUP BY a.project, a.category, pt.total
),

overall AS (
    SELECT
        'ALL' AS project,
        category,
        SUM(cards_count) AS cards_count,
        ROUND(SUM(cards_count) * 100.0 / NULLIF((SELECT total FROM grand_total), 0), 2) AS pct_of_project
    FROM all_cat
    GROUP BY category
)

SELECT * FROM per_project
UNION ALL
SELECT * FROM overall
ORDER BY project, cards_count DESC
```

## Как оформить визуализации (2 графика из этого запроса)

### График 8.1: Overall Card Type (РЯД 2, 5 колонок слева)

1. Нажми **"New visualization"**
2. Тип: **Pie Chart** (Donut)
3. **Фильтр:** нажми **"Filter"** → `project` = `ALL`
4. **Labels/Series:** `category`
5. **Values:** `cards_count`
6. **Цвета (в порядке серий):**
   - Pokemon = жёлтый `#FFCB05`
   - Sport = тёмно-синий `#1E40AF`
   - Marvel/Disney = красный `#DC2626`
   - One Piece = оранжевый `#F97316`
   - TCG other = фиолетовый `#7C3AED`
   - Figurine = бирюзовый `#14B8A6`
   - Unknown = серый `#6B7280`
7. **Ширина:** 5 колонок (левая часть)
8. **Заголовок:** `Overall Card Type Distribution`
9. **Описание:** `Thematic breakdown across all projects. "Unknown" = metadata not yet mapped.`

### График 8.2: Per-Project Category Mix (РЯД 2, 7 колонок справа)

1. Тип: **Bar Chart** (горизонтальный, stacked)
2. **Фильтр:** `project` != `ALL`
3. **Y-axis:** `project`
4. **X-axis:** `pct_of_project`
5. **Group by / Series:** `category`
6. Включи **"Stacking"** = ON (100% normalized)
7. **X-axis format:** `0%`
8. **Те же цвета, что и для 8.1**
9. **Ширина:** 7 колонок (правая часть)
10. **Заголовок:** `Category Mix per Project`
11. **Описание:** `100%-normalized: what IP themes dominate each project's catalogue.`

---

---

# ЗАПРОС 5: Beezie Combined — Claw Inflow + Buyback (9.1 + 9.2)

## Что он делает
Сканирует `erc20_base.evt_transfer` **один раз** и классифицирует каждый USDC трансфер как:
- `claw_inflow` — USDC пришёл на claw machine (9.1)
- `buyback` — USDC ушёл из swap pool пользователю (9.2)

## На какие вопросы отвечает
- Сколько USDC приходит в claw machines по тирам? (9.1)
- Сколько Beezie возвращает через buyback? (9.2)
- Сколько уникальных игроков?

## Название запроса при сохранении
`Cards Market — Beezie Claw + Buyback (9.1+9.2)`

## Движок
**small** (Base — лёгкая таблица)

## SQL-код

```sql
WITH machines AS (
    SELECT addr, tier FROM (VALUES
        -- OLD SYSTEM (direct inflow)
        (0x25acd3ccb939703a742187d6f504428c684ea50c, 'Wildcard'),
        (0x8ed22e2569e4a5b4a872299591f0ac016ce19f4e, 'Wildcard'),
        (0xfdf28b9b957baed8f3d9962effa9b0fe1e189d6a, 'Wildcard'),
        (0x92d79b4b48230d44f915d47fea6c5f63c4565a69, 'Wildcard'),
        (0xa34426b958bc792bf2640befa204df579d81b3bf, 'Wildcard'),
        (0x7b8958961517daa2a0bea01249a9ac17f27725d6, 'Silver TCG'),
        (0x7d71dfc365e6518d40cfdb3f10068be0974e9992, 'Silver TCG'),
        (0x686328b1a104819dda8e8fa5681694a7b93e4061, 'Silver TCG'),
        (0x310b050b945c7b9ee66704ca137ddac003371508, 'Silver TCG'),
        (0x406762fc03d59776e2ea3c6546588aaf1813f173, 'Silver TCG'),
        (0x044cec512d7a5d6852a1b1f1bf5bb9f746962073, 'Gold TCG'),
        (0x1334e20c249b2c7b45a6b4bafa2947163d74c8b6, 'Gold TCG'),
        (0x6f4aba86b9e441f77a51fa4d9fc47001e5bf1072, 'Gold TCG'),
        (0x08f49b9d64a807ec00b1ba986dc9392c26029fcb, 'Gold TCG'),
        (0x5dfb0592e11d63fdaa880020e69f81cc122d2c97, 'Platinum TCG'),
        -- NEW SYSTEM (via Hub)
        (0xe0fb034589817d5148464d1ba8a0ea4e6e43dc01, 'Wildcard'),
        (0x2b90c05c353adc0b3fd55da84628fdba2abb28ca, 'Silver TCG'),
        (0x0d31f8616e6319536c86d7b8930bc1ccde92a626, 'Gold TCG'),
        (0x2caafc357e95b90215949dc24a7e55a3c92ddacf, 'Platinum TCG'),
        (0x4e956faac498b665e27c88bcef900f7eafbd4db1, 'No tier')
    ) AS t(addr, tier)
),

classified AS (
    SELECT
        date_trunc('week', tr.evt_block_time) AS week,
        CASE
            WHEN m.addr IS NOT NULL THEN 'claw_inflow'
            WHEN tr."from" = 0x80d7c04b738ef379971a6b73f25b1a71ea1c820d THEN 'buyback'
        END AS flow_type,
        COALESCE(m.tier, 'Buyback') AS tier,
        CAST(tr.value AS DOUBLE) / 1e6 AS usdc_amount,
        tr.evt_tx_hash,
        tr."from" AS sender,
        tr."to" AS recipient
    FROM erc20_base.evt_transfer tr
    LEFT JOIN machines m ON tr."to" = m.addr
    WHERE tr.contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
      AND tr.evt_block_time >= TIMESTAMP '2026-01-01'
      AND (
          m.addr IS NOT NULL
          OR tr."from" = 0x80d7c04b738ef379971a6b73f25b1a71ea1c820d
      )
)

SELECT
    week,
    flow_type,
    tier,
    ROUND(SUM(usdc_amount), 2)        AS usdc_amount,
    approx_distinct(evt_tx_hash)       AS num_txs,
    approx_distinct(
        CASE WHEN flow_type = 'claw_inflow' THEN sender
             WHEN flow_type = 'buyback'      THEN recipient
        END
    ) AS unique_users
FROM classified
WHERE flow_type IS NOT NULL
GROUP BY 1, 2, 3
ORDER BY week DESC, flow_type, tier
```

## Как оформить визуализации (2 графика из этого запроса)

### График 9.1: Claw Inflow by Tier (РЯД 11, левая половина)

1. Нажми **"New visualization"**
2. Тип: **Bar Chart** (stacked)
3. **Фильтр:** `flow_type` = `claw_inflow`
4. **X-axis:** `week`
5. **Y-axis:** `usdc_amount`
6. **Group by / Series:** `tier`
7. Включи **"Stacking"** = ON
8. **Y-axis format:** `$0.0a`
9. **Цвета:**
   - Wildcard = серый `#9CA3AF`
   - Silver TCG = синий `#3B82F6`
   - Gold TCG = золотой `#F59E0B`
   - Platinum TCG = фиолетовый `#8B5CF6`
   - No tier = тёмно-серый `#374151`
10. **Ширина:** 6 колонок (левая половина)
11. **Заголовок:** `Beezie: Weekly Claw Inflow by Tier`
12. **Описание:** `USDC into 20 claw machines (15 old system + 5 new). Tiers: Wildcard $30, Silver $50, Gold $250, Platinum $500.`

### График 9.2: Buyback (РЯД 11, правая половина)

1. Тип: **Bar Chart**
2. **Фильтр:** `flow_type` = `buyback`
3. **X-axis:** `week`
4. **Y-axis:** `usdc_amount`
5. **Цвет баров:** красный `#EF4444`
6. **Y-axis format:** `$0.0a`
7. **Ширина:** 6 колонок (правая половина)
8. **Заголовок:** `Beezie: Weekly Buyback`
9. **Описание:** `USDC out of swap pool (0x80d7…) to users. Buyback program returns value to claw players.`

---

---

## ЧЕКЛИСТ ПОСЛЕ ДОБАВЛЕНИЯ

- [ ] Все 5 запросов созданы и сохранены с правильными названиями
- [ ] Все 5 запросов запущены и возвращают данные (не пустые таблицы)
- [ ] 10 визуализаций настроены (3 каунтера + 7 графиков)
- [ ] 4 текстовых виджета добавлены
- [ ] Методология обновлена в футере
- [ ] Section 8 расположена между Market Share и Aftermarket
- [ ] Section 7 расположена после Section 8
- [ ] Section 9 расположена после Section 7 (если одобрена @ax1ecosystem)
- [ ] Цвета соответствуют палитрам выше
- [ ] Дашборд сохранён и виден публично

---

## OPEN ITEMS (требуют решения команды)

| # | Вопрос | Кто решает | Что блокирует |
|---|--------|-----------|---------------|
| 1 | Подтвердить CC rarity routing (mint hop через rarity-label?) | @Hempanda | 7.1 — tier detail вместо aggregate |
| 2 | Decimals токена $CARDS | @Hempanda | 7.4c — масштабирование balance |
| 3 | Courtyard: маппинг collection → category | @remmez | 8.x — вместо 'Unknown' |
| 4 | Phygitals: metadata source для категорий | @Hempanda | 8.x — stub пока |
| 5 | Beezie new-system: users платят машинам напрямую или через Hub V2? | @Hempanda | 9.1 — unique_players |
| 7 | Добавлять Section 9 (Beezie) в V2 или подождать V3? | @ax1ecosystem | Решение |
