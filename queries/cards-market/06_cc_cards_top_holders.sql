-- Section 7.4c: $CARDS — Top 20 Holders by Balance
-- Net balance computed from all transfers of $CARDS token.
-- Chain: Solana | Engine: medium | Date: all-time
--
-- NOTE: confirm $CARDS decimals for balance scaling.
--       If token uses decimals, divide net by 1e<DECIMALS>.
--
-- Visualization: Horizontal bar chart
--   Y: holder (truncated address) | X: pct_supply (% labels)
--
-- Save as: "CC Deep Dive — 7.4c $CARDS Top Holders"

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
