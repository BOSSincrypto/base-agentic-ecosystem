# OWB Token Pool Research: December 4-10, 2025

## Token Overview
| Parameter | Value |
|---|---|
| **Token** | OWB (Clash of Coins) |
| **Contract** | `0xEF5997c2cf2f6c138196f8a6203afc335206b3c1` |
| **Chain** | Base |
| **Total Supply** | 1,000,000,000 OWB |
| **Circulating Supply (current)** | ~142,500,272 OWB (~14.25%) |

---

## Main Liquidity Pools (as of Feb 23, 2026)

| # | Pool | DEX | Fee | TVL (USD) | Address |
|---|---|---|---|---|---|
| 1 | OWB/USDC | Aerodrome | - | $185,258 | `0x995985c9027e8a90c823a5e0a9112fea72d1f4dd` |
| 2 | OWB/USDC | Uniswap V3 | 0.01% | $129,627 | `0xf252f51919dfca2c9c0ea279f11183580edee4d6` |
| 3 | OWB/USDC | Uniswap V4 | 0.3% | $54,108 | `0xc37144e227dde7cf27f42d81ffa7099c8b4c71f...` |
| 4 | OWB/USDC | KyberSwap | 3% | $23,206 | `0xe66e3fc16c25d4a46b7e330a0bb0a1707ee9d2d1...` |
| 5 | OWB/USDC | Uniswap V3 | 1% | $15,322 | `0x36638635aa41f049b250bd24784da63ba0d358f2` |
| | **TOTAL** | | | **~$415,500** | |

> Note: The main Uniswap V3 0.01% pool was created on **March 31, 2025** and has **100% locked liquidity**.

---

## Price Data (Dec 4-10, 2025)

### Daily OHLCV - Main Pool (Uniswap V3, 0.01% fee)

| Date | Open | High | Low | Close | Volume (USD) |
|---|---|---|---|---|---|
| Dec 04 | $0.0300 | $0.0308 | $0.0192 | $0.0225 | $98,524 |
| Dec 05 | $0.0225 | $0.0242 | $0.0196 | $0.0218 | $61,294 |
| Dec 06 | $0.0218 | $0.0242 | $0.0205 | $0.0214 | $26,565 |
| Dec 07 | $0.0214 | $0.0249 | $0.0186 | $0.0225 | $34,594 |
| Dec 08 | $0.0225 | $0.0230 | $0.0205 | $0.0209 | $24,164 |
| Dec 09 | $0.0209 | $0.0258 | $0.0202 | $0.0231 | $40,711 |
| Dec 10 | $0.0231 | $0.0292 | $0.0227 | $0.0253 | $75,891 |

**Summary:**
- **Average close price:** $0.0225
- **7-day price range:** $0.0186 - $0.0308
- **7-day total volume (main pool):** $361,743
- **Price Dec 4 open -> Dec 10 close:** $0.0300 -> $0.0253 (**-15.7%**)

### Daily OHLCV - Aerodrome Pool

| Date | Open | High | Low | Close | Volume (USD) |
|---|---|---|---|---|---|
| Dec 04 | $0.0300 | $0.0308 | $0.0193 | $0.0226 | $150,964 |
| Dec 05 | $0.0226 | $0.0242 | $0.0196 | $0.0220 | $78,827 |
| Dec 06 | $0.0220 | $0.0242 | $0.0205 | $0.0213 | $48,812 |
| Dec 07 | $0.0213 | $0.0246 | $0.0186 | $0.0226 | $53,993 |
| Dec 08 | $0.0226 | $0.0229 | $0.0205 | $0.0209 | $47,886 |
| Dec 09 | $0.0209 | $0.0259 | $0.0204 | $0.0230 | $61,852 |
| Dec 10 | $0.0230 | $0.0291 | $0.0229 | $0.0253 | $76,108 |

**7-day total volume (Aerodrome):** $518,442

### Combined Volume (All Pools, CoinGecko)

| Date | Total Volume (USD) |
|---|---|
| Dec 04 | $197,208 |
| Dec 05 | $248,503 |
| Dec 06 | $140,455 |
| Dec 07 | $75,997 |
| Dec 08 | $87,786 |
| Dec 09 | $71,667 |
| Dec 10 | $102,610 |
| **TOTAL** | **$924,226** |

---

## TVL / Reserves Estimation (Dec 4-10, 2025)

> **Important:** Historical on-chain TVL data is not available through free public APIs (GeckoTerminal, DeFiLlama, DexScreener only track recent data). The estimates below are derived from on-chain data patterns and proportional analysis.

### Method: Proportional TVL Estimation

**Current state (Feb 23, 2026):**
- Price: $0.0844
- Main pool (Uni V3) TVL: ~$129,600
- Main pool reserves: ~768,324 OWB + ~64,738 USDC
- Aerodrome TVL: ~$185,258
- Total all pools: ~$415,500

**Dec 4-10, 2025 estimation basis:**
- Average price in Dec 4-10: **$0.0225** (3.75x lower than current $0.0844)
- The pool was ~8 months old at that point (created March 31, 2025)
- Liquidity was likely lower (early stage of pool growth)

### Estimated TVL Range (Dec 4-10, 2025)

Based on the relationship between price, volume, and typical Uniswap V3 liquidity depth:

| Pool | Estimated TVL (Dec 4-10) | Confidence |
|---|---|---|
| Uniswap V3 0.01% | **$30,000 - $60,000** | Medium |
| Aerodrome | **$40,000 - $80,000** | Medium |
| Other pools | **$5,000 - $15,000** | Low |
| **Total estimated** | **$75,000 - $155,000** | Medium |

### Estimated Reserves (Main Uni V3 Pool)

At average close price $0.0225:

| Asset | Estimated Amount | Estimated Value |
|---|---|---|
| OWB | ~800,000 - 1,500,000 | ~$18,000 - $34,000 |
| USDC | ~$15,000 - $30,000 | ~$15,000 - $30,000 |

> These are rough estimates. For exact data, use the Dune SQL queries below.

---

## Depth Estimation at +/-2%, +/-5%, +/-10%

For a Uniswap V3 concentrated liquidity pool, depth depends on where liquidity providers have placed their positions. Since the 0.01% fee pool has 100% locked liquidity, the positions are relatively stable.

### Estimated Depth (Dec 4-10, 2025 at ~$0.0225)

Based on typical Uni V3 0.01% pool characteristics and the volume-to-TVL ratio observed:

| Depth Level | Estimated Bid Depth | Estimated Ask Depth | Total 2-sided |
|---|---|---|---|
| +/-2% | ~$2,000 - $5,000 | ~$2,000 - $5,000 | ~$4,000 - $10,000 |
| +/-5% | ~$5,000 - $12,000 | ~$5,000 - $12,000 | ~$10,000 - $24,000 |
| +/-10% | ~$10,000 - $25,000 | ~$10,000 - $25,000 | ~$20,000 - $50,000 |

> These are estimates based on typical Uni V3 depth profiles. For exact numbers, you would need to reconstruct the tick-level liquidity from on-chain position data at that point in time (see Dune queries below).

---

## Concentrated Liquidity Ranges (Uniswap V3)

The main pool (0.01% fee) is a Uniswap V3 pool, meaning liquidity is concentrated in specific price ranges (ticks).

**Current observation (Feb 2026):**
- Pool has 100% locked liquidity
- This suggests a single large position or protocol-managed liquidity
- For a 0.01% fee tier, the tick spacing is 1 (very granular)

To get the exact active tick ranges during Dec 4-10, use Dune SQL Query B below.

---

## Dune SQL Queries for Exact Historical Data

> **Approach:** Queries A and C use `dex.trades` (Dune Spellbook) — a curated table with pre-decoded, human-readable amounts. This avoids raw byte parsing (`varbinary_to_int256 / 1e18`) which causes precision issues in DuneSQL. Query B uses decoded Uniswap V3 event tables.

### Query A: Daily Volume, Net Flows & Reserves Drift (via dex.trades)

Uses Dune Spellbook `dex.trades` table — amounts are pre-decoded, no raw byte parsing needed:

```sql
-- OWB/USDC: Daily Volume & Net Reserve Flows (Dec 1-11, 2025)
-- Uses dex.trades (Spellbook) — pre-decoded, human-readable amounts
-- OWB contract: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
-- USDC contract: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
-- Pool: 0xf252f51919dfca2c9c0ea279f11183580edee4d6

WITH trades AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        amount_usd,
        -- Pool RECEIVES token_sold, GIVES token_bought
        -- Net USDC into pool: + when trader sells USDC, - when trader buys USDC
        CASE
            WHEN token_sold_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
            THEN token_sold_amount
            ELSE 0
        END AS usdc_into_pool,
        CASE
            WHEN token_bought_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
            THEN token_bought_amount
            ELSE 0
        END AS usdc_out_of_pool,
        -- Net OWB into pool
        CASE
            WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN token_sold_amount
            ELSE 0
        END AS owb_into_pool,
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN token_bought_amount
            ELSE 0
        END AS owb_out_of_pool
    FROM dex.trades
    WHERE blockchain = 'base'
      AND project_contract_address = 0xf252f51919dfca2c9c0ea279f11183580edee4d6
      AND block_time >= TIMESTAMP '2025-12-01'
      AND block_time < TIMESTAMP '2025-12-12'
),
daily AS (
    SELECT
        day,
        COUNT(*) AS swap_count,
        ROUND(SUM(amount_usd), 2) AS daily_volume_usd,
        ROUND(SUM(usdc_into_pool) - SUM(usdc_out_of_pool), 2) AS net_usdc_flow,
        ROUND(SUM(owb_into_pool) - SUM(owb_out_of_pool), 2) AS net_owb_flow
    FROM trades
    GROUP BY 1
)
SELECT
    day,
    swap_count,
    daily_volume_usd,
    net_usdc_flow,
    net_owb_flow,
    ROUND(SUM(net_usdc_flow) OVER (ORDER BY day), 2) AS cumulative_usdc_flow,
    ROUND(SUM(net_owb_flow) OVER (ORDER BY day), 2) AS cumulative_owb_flow
FROM daily
ORDER BY day
```

### Query B: Liquidity Depth & Price Impact Analysis (via dex.trades)

Analyzes actual trade execution to reveal effective liquidity depth — how much volume was absorbed at each price level:

```sql
-- OWB: Liquidity Depth & Price Impact Analysis (Dec 4-10, 2025)
-- Uses dex.trades (Spellbook) — no raw byte parsing
-- Shows: trade size distribution, price buckets, effective depth
-- OWB contract: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1

WITH owb_trades AS (
    SELECT
        block_time,
        amount_usd,
        -- Calculate execution price per OWB in USD
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND token_bought_amount > 0
            THEN amount_usd / token_bought_amount
            WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND token_sold_amount > 0
            THEN amount_usd / token_sold_amount
            ELSE NULL
        END AS exec_price,
        -- Direction: buy = someone buys OWB, sell = someone sells OWB
        CASE
            WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
            THEN 'buy'
            ELSE 'sell'
        END AS direction,
        project
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= TIMESTAMP '2025-12-04'
      AND block_time < TIMESTAMP '2025-12-11'
      AND amount_usd > 0
),
-- Price buckets: group trades by $0.001 price increments
price_buckets AS (
    SELECT
        FLOOR(exec_price * 1000) / 1000 AS price_bucket,
        direction,
        COUNT(*) AS trade_count,
        ROUND(SUM(amount_usd), 2) AS total_volume_usd,
        ROUND(AVG(amount_usd), 2) AS avg_trade_size,
        ROUND(MAX(amount_usd), 2) AS max_trade_size
    FROM owb_trades
    WHERE exec_price IS NOT NULL
      AND exec_price BETWEEN 0.01 AND 0.05
    GROUP BY 1, 2
)
SELECT
    price_bucket,
    direction,
    trade_count,
    total_volume_usd,
    avg_trade_size,
    max_trade_size
FROM price_buckets
ORDER BY price_bucket, direction
```

**How to read the results:**
- Each row = a $0.001 price bucket (e.g. 0.022 = trades executed at $0.022-$0.023)
- `total_volume_usd` at each bucket = the effective depth at that price level
- Buckets with high volume = concentrated liquidity zones
- Compare buy vs sell volume at each level to see bid/ask imbalance

### Query D: Exact Historical Reserves & TVL (via tokens.transfers + dex.trades)

Reconstructs **точные** резервы пула на каждый день, используя все ERC20 трансферы (свопы + добавление/удаление ликвидности) к/от адреса пула. Цена OWB берётся из реальных сделок в `dex.trades`.

**Результат:** Day | USDC in Pool | OWB in Pool | OWB Price (USD) | TVL (USD)

```sql
-- OWB/USDC: Exact Historical Reserves & TVL (Dec 4-10, 2025)
-- Method: ALL ERC20 transfers to/from pools = exact reserves at any point
-- Pools: Uniswap V3 0.01% + Aerodrome (both OWB/USDC on Base)
-- Uniswap V3: 0xf252f51919dfca2c9c0ea279f11183580edee4d6
-- Aerodrome:  0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
-- OWB:  0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
-- USDC: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913

WITH pool_flows AS (
    -- Every token transfer to/from BOTH pools: swaps, LP mints, LP burns
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        CASE
            WHEN "to" = 0xf252f51919dfca2c9c0ea279f11183580edee4d6
                 OR "from" = 0xf252f51919dfca2c9c0ea279f11183580edee4d6
            THEN 'Uniswap V3'
            ELSE 'Aerodrome'
        END AS pool,
        -- USDC flowing INTO pool
        SUM(CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                 AND "to" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS usdc_in,
        -- USDC flowing OUT of pool
        SUM(CASE
            WHEN contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
                 AND "from" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS usdc_out,
        -- OWB flowing INTO pool
        SUM(CASE
            WHEN contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND "to" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS owb_in,
        -- OWB flowing OUT of pool
        SUM(CASE
            WHEN contract_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                 AND "from" IN (
                     0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                     0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
                 )
            THEN amount ELSE 0
        END) AS owb_out
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address IN (
          0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913,
          0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND (
          "to" IN (0xf252f51919dfca2c9c0ea279f11183580edee4d6, 0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD)
          OR "from" IN (0xf252f51919dfca2c9c0ea279f11183580edee4d6, 0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD)
      )
      AND block_time < TIMESTAMP '2025-12-11'
    GROUP BY 1, 2
),

-- Cumulative reserves per pool from creation to each day
reserves_per_pool AS (
    SELECT
        day,
        pool,
        SUM(usdc_in - usdc_out) OVER (PARTITION BY pool ORDER BY day) AS usdc_reserves,
        SUM(owb_in - owb_out) OVER (PARTITION BY pool ORDER BY day) AS owb_reserves
    FROM pool_flows
),

-- Daily volume-weighted average OWB price from actual trades (all pools)
daily_price AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        SUM(amount_usd) / NULLIF(
            SUM(CASE
                WHEN token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                THEN token_bought_amount
                WHEN token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
                THEN token_sold_amount
                ELSE 0
            END), 0
        ) AS avg_owb_price_usd
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      )
      AND block_time >= TIMESTAMP '2025-12-04'
      AND block_time < TIMESTAMP '2025-12-11'
      AND amount_usd > 0
    GROUP BY 1
),

-- Combine both pools + add totals
combined AS (
    SELECT
        r.day,
        r.pool,
        ROUND(r.usdc_reserves, 2) AS usdc_in_pool,
        ROUND(r.owb_reserves, 0) AS owb_in_pool,
        ROUND(p.avg_owb_price_usd, 6) AS owb_price,
        ROUND(r.usdc_reserves + (r.owb_reserves * COALESCE(p.avg_owb_price_usd, 0)), 2) AS tvl_usd
    FROM reserves_per_pool r
    LEFT JOIN daily_price p ON r.day = p.day
    WHERE r.day >= DATE '2025-12-04'
      AND r.day <= DATE '2025-12-10'
)

-- Per-pool rows + TOTAL row per day
SELECT
    day,
    pool AS "Pool",
    usdc_in_pool AS "USDC in Pool",
    owb_in_pool AS "OWB in Pool",
    owb_price AS "OWB Price (avg, USD)",
    tvl_usd AS "TVL (USD)"
FROM combined

UNION ALL

SELECT
    day,
    'TOTAL (both pools)' AS "Pool",
    ROUND(SUM(usdc_in_pool), 2) AS "USDC in Pool",
    ROUND(SUM(owb_in_pool), 0) AS "OWB in Pool",
    MAX(owb_price) AS "OWB Price (avg, USD)",
    ROUND(SUM(tvl_usd), 2) AS "TVL (USD)"
FROM combined
GROUP BY day

ORDER BY day, "Pool"
```

**Как это работает:**
- `tokens.transfers` содержит ВСЕ ERC20 трансферы (свопы + добавление LP + удаление LP)
- Кумулятивная сумма всех входящих минус исходящих трансферов = точный баланс пула
- Считает резервы **отдельно для каждого пула** (Uniswap V3 + Aerodrome) + строку **TOTAL**
- Цена OWB — средневзвешенная по объёму из реальных сделок в `dex.trades` (все пулы Base)
- TVL = USDC резервы + (OWB резервы x цена OWB)

**Результат (3 строки на день: Aerodrome, Uniswap V3, TOTAL):**

| Day | Pool | USDC in Pool | OWB in Pool | OWB Price | TVL (USD) |
|-----|------|-------------|-------------|-----------|-----------|
| Dec 04 | Aerodrome | ... | ... | $0.0225 | ... |
| Dec 04 | Uniswap V3 | ... | ... | $0.0225 | ... |
| Dec 04 | TOTAL (both pools) | ... | ... | $0.0225 | ... |

**Примечание:** Запрос сканирует трансферы от создания пулов до 10 декабря. Может выполняться 30-60 секунд.

---

### Query C: Daily Volume & Unique Traders (via dex.trades)

```sql
-- OWB: Daily Trading Volume and Unique Traders (Dec 4-10, 2025)
-- Uses dex.trades (Spellbook) — all DEX pools on Base combined
-- OWB contract: 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1

SELECT
    DATE_TRUNC('day', block_time) AS day,
    COUNT(*) AS total_swaps,
    COUNT(DISTINCT taker) AS unique_traders,
    ROUND(SUM(amount_usd), 2) AS total_volume_usd,
    -- Volume split by DEX
    ROUND(SUM(CASE WHEN project = 'uniswap' AND version = '3' THEN amount_usd ELSE 0 END), 2) AS uniswap_v3_volume,
    ROUND(SUM(CASE WHEN project = 'aerodrome' THEN amount_usd ELSE 0 END), 2) AS aerodrome_volume,
    ROUND(SUM(CASE WHEN project NOT IN ('uniswap', 'aerodrome') THEN amount_usd ELSE 0 END), 2) AS other_dex_volume
FROM dex.trades
WHERE blockchain = 'base'
  AND (
      token_bought_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
      OR token_sold_address = 0xEF5997c2cf2f6c138196f8a6203afc335206b3c1
  )
  AND block_time >= TIMESTAMP '2025-12-04'
  AND block_time < TIMESTAMP '2025-12-11'
GROUP BY 1
ORDER BY 1
```

---

## Data Sources and Methodology

| Data Point | Source | Reliability |
|---|---|---|
| Daily OHLCV prices | GeckoTerminal API | High (on-chain data) |
| Hourly prices | CoinGecko API | High |
| Daily total volumes | CoinGecko API | High (aggregated) |
| Pool-level volumes | GeckoTerminal API | High (per-pool) |
| Current TVL/Reserves | DexScreener + GeckoTerminal | High |
| Historical TVL estimates | Proportional analysis | Medium (estimated) |
| Depth estimates | Volume/TVL ratio analysis | Low-Medium (estimated) |
| Liquidity depth / price impact | Dune Query B (dex.trades) | High (on-chain trade data) |
| **Exact historical reserves & TVL** | **Dune Query D (tokens.transfers + dex.trades)** | **High (on-chain exact)** |

**Why historical TVL was previously estimated:**
Free public APIs (GeckoTerminal, DeFiLlama, DexScreener) do not provide historical pool-level TVL data for December 2025. DeFiLlama only started tracking OWB pools in February 2026. **Query D теперь даёт точные данные** — он восстанавливает резервы из всех ERC20 трансферов к/от пула, начиная с его создания.

---

*Research compiled on February 23, 2026*
*Data period: December 4-10, 2025*
*Token: OWB (0xEF5997c2cf2f6c138196f8a6203afc335206b3c1) on Base*
