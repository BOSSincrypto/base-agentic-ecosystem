-- Q8: Phygitals — Weekly Volume by Bucket
-- Timeline of weekly volumes, tiers grouped into spend buckets
-- Source: dune.com/queries/7458642 (adapted)
-- Engine: Medium (Solana)

WITH base AS (
    SELECT
        DATE_TRUNC('week', block_time) AS week,
        amount_usd,
        CASE
            WHEN amount_usd BETWEEN 0.01  AND 31     THEN '1_Micro ($1-$25)'
            WHEN amount_usd BETWEEN 31    AND 402    THEN '2_Low ($50-$350)'
            WHEN amount_usd BETWEEN 402   AND 1502   THEN '3_Mid ($400-$1500)'
            WHEN amount_usd BETWEEN 1502  AND 17505  THEN '4_High ($2000-$17500)'
            WHEN amount_usd > 17505                  THEN '5_Whale ($20000+)'
            ELSE '6_Other'
        END AS bucket
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2025-04-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
      AND from_owner NOT IN (
          '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'
      )
      AND amount_usd > 0.01
)

SELECT
    week,
    ROUND(SUM(CASE WHEN bucket = '1_Micro ($1-$25)'      THEN amount_usd ELSE 0 END), 2) AS micro,
    ROUND(SUM(CASE WHEN bucket = '2_Low ($50-$350)'      THEN amount_usd ELSE 0 END), 2) AS low,
    ROUND(SUM(CASE WHEN bucket = '3_Mid ($400-$1500)'    THEN amount_usd ELSE 0 END), 2) AS mid,
    ROUND(SUM(CASE WHEN bucket = '4_High ($2000-$17500)' THEN amount_usd ELSE 0 END), 2) AS high,
    ROUND(SUM(CASE WHEN bucket = '5_Whale ($20000+)'     THEN amount_usd ELSE 0 END), 2) AS whale,
    ROUND(SUM(amount_usd), 2) AS total_volume_usd,
    COUNT(*) AS total_spins
FROM base
GROUP BY 1
ORDER BY 1
