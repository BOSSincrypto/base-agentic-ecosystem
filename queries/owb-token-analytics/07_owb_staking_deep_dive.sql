-- =====================================================================
-- OWB Token Analytics - Query 7: Staking Deep Dive
-- Tracks staking contract with proper event topics
-- Staking Contract: 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
-- Events:
--   Stake: 0x1449c6dd7851abc30abf37f57715f492010519147cc2652fbc38202c18a6ee90
--   Unstake: 0x7fc4727e062e336010f2c282598ef5f14facb3de68cf8195c2f23e1454b2b74e
--   Rewards: 0x106f923f993c2149d49b4255ff723acafa1f2d94393f561d3eda32ae348f7241
-- =====================================================================

WITH staking_events AS (
    SELECT
        date_trunc('day', block_time) AS day,
        CASE
            WHEN topic0 = 0x1449c6dd7851abc30abf37f57715f492010519147cc2652fbc38202c18a6ee90 THEN 'stake'
            WHEN topic0 = 0x7fc4727e062e336010f2c282598ef5f14facb3de68cf8195c2f23e1454b2b74e THEN 'unstake'
            WHEN topic0 = 0x106f923f993c2149d49b4255ff723acafa1f2d94393f561d3eda32ae348f7241 THEN 'rewards'
        END AS event_type,
        tx_from,
        tx_hash
    FROM base.logs
    WHERE contract_address = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      AND topic0 IN (
          0x1449c6dd7851abc30abf37f57715f492010519147cc2652fbc38202c18a6ee90,
          0x7fc4727e062e336010f2c282598ef5f14facb3de68cf8195c2f23e1454b2b74e,
          0x106f923f993c2149d49b4255ff723acafa1f2d94393f561d3eda32ae348f7241
      )
      AND block_time >= DATE '2026-01-01'
),

daily_staking AS (
    SELECT
        day,
        SUM(CASE WHEN event_type = 'stake' THEN 1 ELSE 0 END) AS stake_count,
        SUM(CASE WHEN event_type = 'unstake' THEN 1 ELSE 0 END) AS unstake_count,
        SUM(CASE WHEN event_type = 'rewards' THEN 1 ELSE 0 END) AS rewards_claimed,
        COUNT(DISTINCT CASE WHEN event_type = 'stake' THEN tx_from END) AS unique_stakers,
        COUNT(DISTINCT CASE WHEN event_type = 'unstake' THEN tx_from END) AS unique_unstakers,
        COUNT(DISTINCT CASE WHEN event_type = 'rewards' THEN tx_from END) AS unique_reward_claimers,
        COUNT(DISTINCT tx_from) AS total_unique_users
    FROM staking_events
    GROUP BY 1
),

-- OWB token flows to/from staking contract
owb_staked AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e18) AS owb_staked_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "to" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

owb_unstaked AS (
    SELECT
        date_trunc('day', evt_block_time) AS day,
        SUM(CAST(value AS DOUBLE) / 1e18) AS owb_unstaked_amount
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND "from" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      AND evt_block_time >= DATE '2026-01-01'
    GROUP BY 1
),

-- Current staking TVL
current_tvl AS (
    SELECT
        SUM(CASE WHEN "to" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
                 THEN CAST(value AS DOUBLE) / 1e18
                 ELSE -CAST(value AS DOUBLE) / 1e18
            END) AS staking_tvl_owb
    FROM erc20_base.evt_Transfer
    WHERE contract_address = 0xEF5997c2cf2f6c138196f8A6203afc335206b3c1
      AND (
          "to" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
          OR "from" = 0x692d11c779d43BBC12Cb8565C7f71a54A47D117c
      )
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(st.stake_count, 0) AS "Stakes",
    COALESCE(st.unstake_count, 0) AS "Unstakes",
    COALESCE(st.rewards_claimed, 0) AS "Rewards Claimed",
    COALESCE(st.unique_stakers, 0) AS "Unique Stakers",
    COALESCE(st.unique_unstakers, 0) AS "Unique Unstakers",
    COALESCE(st.unique_reward_claimers, 0) AS "Reward Claimers",
    COALESCE(st.total_unique_users, 0) AS "Total Staking Users",
    ROUND(COALESCE(os.owb_staked_amount, 0), 0) AS "OWB Staked",
    ROUND(COALESCE(ou.owb_unstaked_amount, 0), 0) AS "OWB Unstaked",
    ROUND(COALESCE(os.owb_staked_amount, 0) - COALESCE(ou.owb_unstaked_amount, 0), 0) AS "Net Staking Flow",
    -- Cumulative net staking
    ROUND(SUM(COALESCE(os.owb_staked_amount, 0) - COALESCE(ou.owb_unstaked_amount, 0))
        OVER (ORDER BY ds.day), 0) AS "Cumulative Net Staked",
    -- Cumulative rewards
    SUM(COALESCE(st.rewards_claimed, 0)) OVER (ORDER BY ds.day) AS "Cumulative Rewards Claims",
    -- 7d MA
    ROUND(AVG(COALESCE(st.stake_count, 0) + COALESCE(st.unstake_count, 0) + COALESCE(st.rewards_claimed, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 1) AS "Staking Activity 7d MA"
FROM date_spine ds
LEFT JOIN daily_staking st ON ds.day = st.day
LEFT JOIN owb_staked os ON ds.day = os.day
LEFT JOIN owb_unstaked ou ON ds.day = ou.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
