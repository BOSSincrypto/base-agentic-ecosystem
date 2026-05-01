-- Section 5: CoC x402 Agentic Payments Deep Dive
-- Isolates AI agent payments in Clash of Coins using dual-topic filter:
--   Transfer (USDC to payTo) + AuthorizationUsed (x402) in same tx
-- Source: Hempanda research, query #7400157
-- Reference: https://x402.clashofcoins.com/shop/x402/offers
--
-- Save as: "CoC x402 - Agentic Payments (V1)"

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
