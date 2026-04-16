-- =====================================================================
-- OWB Token Analytics - Query 3: Daily Ecosystem Activity
-- Time series of daily transactions across ALL OWB contracts
-- with category breakdown (Token/Agentic/Gaming/NFT/Staking/Drops)
-- 7d MA and cumulative growth
-- =====================================================================

WITH owb_contracts AS (
    SELECT address, label, category FROM (
        VALUES
        (0xEF5997c2cf2f6c138196f8A6203afc335206b3c1, 'OWB Token', 'Token'),
        (0xD5590F6CeCeF03b796fd904541727C2fe6346C06, 'vOWB Token', 'Token'),
        (0x98430ECBe49bf6dB549D6F827d95ed7A3625FAeb, 'Agentic Claim 1', 'Agentic'),
        (0xdbfB8BB5464BEf64F499457d3E5Dfd2AD7368203, 'Agentic Claim 2', 'Agentic'),
        (0x0fbBBd928EA4eDDd2EAfF51D4D412a3b65452F40, 'Claim Rewards', 'Gaming'),
        (0x6fB8a5dE77Cfb16dD4D4a8af8bcfa4D078C5E088, 'vOWB Swap', 'Tokenomics'),
        (0x3C83eF6119EB05Ca44144F05b331dbEE60656d5b, 'NFT Sale (Web)', 'NFT'),
        (0xf46A1D3eAA84558887169CF2CEE343491364c8BA, 'NFT Sale (Base App)', 'NFT'),
        (0x692d11c779d43BBC12Cb8565C7f71a54A47D117c, 'Staking', 'Staking'),
        (0xBbf1c72B783AB17e1585802D0Bd99d9b87A04404, 'Vesting', 'Staking'),
        (0x842C14301B1B7319F7f3dbbcf5465CE1B15bA386, 'Referral Share', 'Referral'),
        (0x177f1AcdDc2833978B2965D50Ae17038D275D1f2, 'NFT Buildings', 'NFT'),
        (0x4Ce43ad4FE0B39529848929A3d36843ba6025F8B, 'NFT Buildings S1', 'NFT'),
        (0xf6aF7eBe28a587638140fE8AD0829b4536bBA549, 'NFT Founders', 'NFT'),
        (0x744E408a2709C453789DAB5c23e62eed16D9c9ED, 'NFT Skins', 'NFT'),
        (0x49046E2988A78222693c04AD049b68e5A4801034, 'NFT Passes', 'NFT'),
        (0xCa01825a7Ebec9A7E2E74C3F4b942ce61570D868, 'S2 Claim', 'Drops'),
        (0x8fA8E118deCEc48Bb7c9FFacE245efBeD4eCB667, 'S1 First Claim', 'Drops'),
        (0x5a9FA56078d72e16937879Cc6ada403ED12F2814, 'S1 Second Claim', 'Drops'),
        (0x6d19e9bC21A2120fF6fe71aaD28EcD9d05ed6973, 'RetroDrop', 'Drops'),
        (0x6541BAcBF182E58031BB6a329e74F6492b4a7aAf, 'GameFI Drop', 'Drops')
    ) AS t(address, label, category)
),

daily_by_category AS (
    SELECT
        date_trunc('day', t.block_time) AS day,
        oc.category,
        COUNT(*) AS txs,
        COUNT(DISTINCT t."from") AS users
    FROM base.transactions t
    INNER JOIN owb_contracts oc ON t."to" = oc.address
    WHERE t.block_time >= DATE '2026-01-01'
      AND t.success = true
    GROUP BY 1, 2
),

date_spine AS (
    SELECT day
    FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
),

daily_agg AS (
    SELECT
        ds.day,
        COALESCE(SUM(CASE WHEN d.category = 'Token' THEN d.txs END), 0) AS "Token Txs",
        COALESCE(SUM(CASE WHEN d.category = 'Agentic' THEN d.txs END), 0) AS "Agentic Txs",
        COALESCE(SUM(CASE WHEN d.category = 'Gaming' THEN d.txs END), 0) AS "Gaming Txs",
        COALESCE(SUM(CASE WHEN d.category = 'NFT' THEN d.txs END), 0) AS "NFT Txs",
        COALESCE(SUM(CASE WHEN d.category = 'Staking' THEN d.txs END), 0) AS "Staking Txs",
        COALESCE(SUM(CASE WHEN d.category = 'Tokenomics' THEN d.txs END), 0) AS "Tokenomics Txs",
        COALESCE(SUM(CASE WHEN d.category = 'Drops' THEN d.txs END), 0) AS "Drops Txs",
        COALESCE(SUM(d.txs), 0) AS "Total Txs",
        COALESCE(SUM(d.users), 0) AS "Total Users"
    FROM date_spine ds
    LEFT JOIN daily_by_category d ON ds.day = d.day
    GROUP BY 1
)

SELECT
    day,
    "Token Txs",
    "Agentic Txs",
    "Gaming Txs",
    "NFT Txs",
    "Staking Txs",
    "Tokenomics Txs",
    "Drops Txs",
    "Total Txs",
    "Total Users",
    -- 7d Moving Average
    ROUND(AVG("Total Txs") OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "Total Txs 7d MA",
    ROUND(AVG("Total Users") OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS "Total Users 7d MA",
    -- Cumulative
    SUM("Total Txs") OVER (ORDER BY day) AS "Cumulative Txs",
    -- Cumulative unique users approximation
    SUM("Total Users") OVER (ORDER BY day) AS "Cumulative Users (Approx)"
FROM daily_agg
WHERE day < current_date
ORDER BY day ASC
