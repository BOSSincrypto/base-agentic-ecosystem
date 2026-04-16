-- =====================================================================
-- OWB Token Analytics - Query 17: Net Flow Analysis
-- Daily accumulation vs distribution + 7d MA
-- Cumulative net flow - key demand signal
-- Large transfers (>100K OWB) tracking
-- =====================================================================

WITH daily_transfers AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        "from" AS sender,
        "to" AS receiver,
        CAST(value AS DOUBLE) / 1e18 AS amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND evt_block_time >= DATE '2026-01-01'
      AND "from" != 0x0000000000000000000000000000000000000000
      AND "to" != 0x0000000000000000000000000000000000000000
),

-- Classify transfers
classified AS (
    SELECT
        day,
        amount,
        CASE
            WHEN receiver IN (
                0xf252f51919dfca2c9c0ea279f11183580edee4d6,  -- Uniswap V3 Pool
                0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD   -- Aerodrome Pool
            ) THEN 'DEX Flow'
            WHEN sender IN (
                0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD
            ) THEN 'DEX Flow'
            WHEN amount >= 100000 THEN 'Large Transfer'
            ELSE 'Wallet Transfer'
        END AS flow_type
    FROM daily_transfers
),

-- Net flow: positive = accumulation, negative = distribution
-- Using transfers TO wallets (not contracts) vs FROM wallets
wallet_flow AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CASE
            WHEN "to" NOT IN (
                0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD,
                0x692d11c779d43BBC12Cb8565C7f71a54A47D117c,
                0x0000000000000000000000000000000000000000
            ) THEN CAST(value AS DOUBLE) / 1e18
            ELSE 0
        END) AS inflows_to_wallets,
        SUM(CASE
            WHEN "from" NOT IN (
                0xf252f51919dfca2c9c0ea279f11183580edee4d6,
                0x995985C9027E8a90C823a5E0a9112Fea72d1F4DD,
                0x692d11c779d43BBC12Cb8565C7f71a54A47D117c,
                0x0000000000000000000000000000000000000000
            ) THEN CAST(value AS DOUBLE) / 1e18
            ELSE 0
        END) AS outflows_from_wallets
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- Large transfers (>100K OWB)
large_transfers AS (
    SELECT
        day,
        COUNT(*) AS large_tx_count,
        SUM(amount) AS large_tx_volume
    FROM classified
    WHERE amount >= 100000
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    ROUND(COALESCE(wf.inflows_to_wallets, 0), 0) AS "Wallet Inflows (OWB)",
    ROUND(COALESCE(wf.outflows_from_wallets, 0), 0) AS "Wallet Outflows (OWB)",
    ROUND(COALESCE(wf.inflows_to_wallets, 0) - COALESCE(wf.outflows_from_wallets, 0), 0) AS "Net Flow",
    -- Large transfers
    COALESCE(lt.large_tx_count, 0) AS "Large Transfers (>100K)",
    ROUND(COALESCE(lt.large_tx_volume, 0), 0) AS "Large Transfer Volume",
    -- 7d MA
    ROUND(AVG(COALESCE(wf.inflows_to_wallets, 0) - COALESCE(wf.outflows_from_wallets, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "Net Flow 7d MA",
    -- Cumulative net flow
    ROUND(SUM(COALESCE(wf.inflows_to_wallets, 0) - COALESCE(wf.outflows_from_wallets, 0))
        OVER (ORDER BY ds.day), 0) AS "Cumulative Net Flow"
FROM date_spine ds
LEFT JOIN wallet_flow wf ON ds.day = wf.day
LEFT JOIN large_transfers lt ON ds.day = lt.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
