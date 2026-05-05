-- Section 6: Upshot — USDC Deposits & Withdrawals on Base
-- Contract: 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
-- Based on Hempanda query #7425705
--
-- Save as: "Upshot — Deposits & Withdrawals (V1)"

WITH upshot_flows AS (
    SELECT
        DATE_TRUNC('week', evt_block_time) AS week,
        evt_tx_hash AS tx_hash,
        "from" AS sender,
        "to" AS receiver,
        CAST(value AS DOUBLE) / 1e6 AS usdc_amount,
        CASE
            WHEN "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b THEN 'deposit'
            WHEN "from" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b THEN 'withdrawal'
        END AS flow_type
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
      AND (
          "from" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
          OR "to" = 0x939dbbcf075de12d9d8df08ef727591ddebbc13b
      )
      AND evt_block_time >= TIMESTAMP '2026-02-01'
),

weekly_flows AS (
    SELECT
        week,
        COUNT(DISTINCT tx_hash) AS total_txs,
        COUNT(DISTINCT CASE WHEN flow_type = 'deposit' THEN sender END) AS depositors,
        COUNT(DISTINCT CASE WHEN flow_type = 'withdrawal' THEN receiver END) AS withdrawers,
        ROUND(SUM(CASE WHEN flow_type = 'deposit' THEN usdc_amount ELSE 0 END), 2) AS deposits_usd,
        ROUND(SUM(CASE WHEN flow_type = 'withdrawal' THEN usdc_amount ELSE 0 END), 2) AS withdrawals_usd,
        ROUND(
            SUM(CASE WHEN flow_type = 'deposit' THEN usdc_amount ELSE 0 END)
          - SUM(CASE WHEN flow_type = 'withdrawal' THEN usdc_amount ELSE 0 END),
        2) AS net_flow_usd
    FROM upshot_flows
    GROUP BY 1
)

SELECT
    week AS "Week",
    total_txs AS "Total Txs",
    depositors AS "Unique Depositors",
    withdrawers AS "Unique Withdrawers",
    deposits_usd AS "Deposits USD",
    withdrawals_usd AS "Withdrawals USD",
    net_flow_usd AS "Net Flow USD",
    SUM(deposits_usd) OVER (ORDER BY week) AS "Cumulative Deposits USD",
    SUM(withdrawals_usd) OVER (ORDER BY week) AS "Cumulative Withdrawals USD",
    SUM(net_flow_usd) OVER (ORDER BY week) AS "TVL Proxy USD"
FROM weekly_flows
WHERE week < DATE_TRUNC('week', now())
ORDER BY 1
