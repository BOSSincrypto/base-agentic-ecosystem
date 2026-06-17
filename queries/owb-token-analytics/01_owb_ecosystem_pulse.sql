-- =====================================================================
-- OWB Token Analytics - Query 1: Ecosystem Pulse (Master KPIs)
-- Dashboard: https://dune.com/bossincrypto/owb-token-analytics-base-onewayblock
-- All 21 OWB contracts aggregated into top-level KPI counters
-- Chain: Base | Start: 2026-01-01
-- =====================================================================

WITH owb_contracts AS (
    SELECT address, label, category FROM (
        VALUES
        -- Core Token
        (0xEF5997c2cf2f6c138196f8A6203afc335206b3c1, 'OWB Token', 'Token'),
        (0xD5590F6CeCeF03b796fd904541727C2fe6346C06, 'vOWB Token', 'Token'),
        -- Agentic Layer
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'Agentic Claim 1', 'Agentic'),
        (0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203, 'Agentic Claim 2', 'Agentic'),
        -- Game Economy
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'Claim Rewards', 'Gaming'),
        (0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088, 'vOWB Swap', 'Tokenomics'),
        (0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b, 'NFT Sale (Web)', 'NFT'),
        (0xf46A1D3eAA84558887169CF2CEE343491364c8BA, 'NFT Sale (Base App)', 'NFT'),
        -- Staking & Vesting
        (0x692d11c779d43BBC12Cb8565C7f71a54A47D117c, 'Staking', 'Staking'),
        (0xBbf1c72B783AB17e1585802D0Bd99d9b87A04404, 'Vesting', 'Staking'),
        -- Treasury
        (0x8b29DABD6fBb5A09DAcbC7978eaed66A8540721d, 'Treasury', 'Treasury'),
        -- Referral
        (0x842C14301B1B7319F7f3dbbcf5465CE1B15bA386, 'Referral Share', 'Referral'),
        -- NFT Collections
        (0x177f1AcdDc2833978B2965D50Ae17038D275D1f2, 'NFT Buildings', 'NFT'),
        (0x4Ce43ad4FE0B39529848929A3d36843ba6025F8B, 'NFT Buildings S1', 'NFT'),
        (0xf6aF7eBe28a587638140fE8AD0829b4536bBA549, 'NFT Founders', 'NFT'),
        (0x744E408a2709C453789DAB5c23e62eed16D9c9ED, 'NFT Skins', 'NFT'),
        (0x49046E2988A78222693c04AD049b68e5A4801034, 'NFT Passes', 'NFT'),
        -- Seasonal Claims & Drops
        (0xCa01825a7Ebec9A7E2E74C3F4b942ce61570D868, 'S2 Claim', 'Drops'),
        (0x8fA8E118deCEc48Bb7c9FFacE245efBeD4eCB667, 'S1 First Claim', 'Drops'),
        (0x5a9FA56078d72e16937879Cc6ada403ED12F2814, 'S1 Second Claim', 'Drops'),
        (0x6d19e9bC21A2120fF6fe71aaD28EcD9d05ed6973, 'RetroDrop', 'Drops'),
        (0x6541BAcBF182E58031BB6a329e74F6492b4a7aAf, 'GameFI Drop', 'Drops')
    ) AS t(address, label, category)
),

-- Current OWB price from Dune prices
current_price AS (
    SELECT price AS owb_price_usd
    FROM prices.usd_latest
    WHERE blockchain = 'base'
      AND contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
),

-- Total ecosystem transactions (YTD)
ecosystem_txs AS (
    SELECT
        COUNT(*) AS total_txs,
        COUNT(DISTINCT t."from") AS unique_wallets
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
),

-- Rolling 7d vs previous 7d (avoids calendar week edge issues)
last_7d AS (
    SELECT
        COUNT(*) AS txs_7d,
        COUNT(DISTINCT t."from") AS users_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= now() - interval '7' day
      AND t.success = true
),

prev_7d AS (
    SELECT
        COUNT(*) AS txs_prev_7d,
        COUNT(DISTINCT t."from") AS users_prev_7d
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= now() - interval '14' day
      AND t.block_time < now() - interval '7' day
      AND t.success = true
),

-- DEX volume (30d) across all pools
dex_vol AS (
    SELECT COALESCE(SUM(amount_usd), 0) AS dex_volume_30d
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= now() - interval '30' day
),

-- Net positive balance holders
holders AS (
    SELECT COUNT(*) AS holder_count
    FROM (
        SELECT wallet, SUM(net_amount) AS balance
        FROM (
            SELECT "to" AS wallet, CAST(value AS DOUBLE) / 1e18 AS net_amount
            FROM erc20_base.evt_Transfer
            WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
            UNION ALL
            SELECT "from" AS wallet, -CAST(value AS DOUBLE) / 1e18 AS net_amount
            FROM erc20_base.evt_Transfer
            WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
        ) t
        WHERE wallet != 0x0000000000000000000000000000000000000000
        GROUP BY 1
        HAVING SUM(net_amount) > 0
    )
),

-- Total unique swaps (all time)
total_swaps AS (
    SELECT COUNT(*) AS swap_count
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
),

-- 24h metrics
vol_24h AS (
    SELECT
        COALESCE(SUM(amount_usd), 0) AS volume_24h,
        COUNT(DISTINCT tx_from) AS traders_24h
    FROM dex.trades
    WHERE blockchain = 'base'
      AND (
          token_bought_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
          OR token_sold_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      )
      AND block_time >= now() - interval '24' hour
)

SELECT
    cp.owb_price_usd AS "Current Price",
    ROUND(cp.owb_price_usd * 1e9, 0) AS "Market Cap (FDV)",
    h.holder_count AS "Total Holders",
    et.total_txs AS "Total Ecosystem Txs (YTD)",
    et.unique_wallets AS "Unique Wallets (YTD)",
    ROUND(dv.dex_volume_30d, 0) AS "DEX Volume (30d USD)",
    ROUND(v24.volume_24h, 0) AS "24h Volume",
    v24.traders_24h AS "24h Active Traders",
    ts.swap_count AS "Total Swaps (All Time)",
    l7.txs_7d AS "Txs (Last 7d)",
    p7.txs_prev_7d AS "Txs (Prev 7d)",
    CASE
        WHEN p7.txs_prev_7d > 0
        THEN ROUND(100.0 * (l7.txs_7d - p7.txs_prev_7d) / p7.txs_prev_7d, 1)
        ELSE 0
    END AS "WoW Txs Growth %",
    l7.users_7d AS "Users (Last 7d)",
    p7.users_prev_7d AS "Users (Prev 7d)",
    CASE
        WHEN p7.users_prev_7d > 0
        THEN ROUND(100.0 * (l7.users_7d - p7.users_prev_7d) / p7.users_prev_7d, 1)
        ELSE 0
    END AS "WoW Users Growth %"
FROM current_price cp
CROSS JOIN ecosystem_txs et
CROSS JOIN last_7d l7
CROSS JOIN prev_7d p7
CROSS JOIN dex_vol dv
CROSS JOIN holders h
CROSS JOIN total_swaps ts
CROSS JOIN vol_24h v24
