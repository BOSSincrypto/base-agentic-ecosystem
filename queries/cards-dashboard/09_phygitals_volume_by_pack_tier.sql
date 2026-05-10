-- Q9: Phygitals — Volume & Spins by Pack Tier
-- Total revenue by exact pack price tiers, who drives the money
-- Source: dune.com/queries/7458646 (adapted)
-- Engine: Medium (Solana)

WITH base AS (
    SELECT
        amount_usd,
        CASE
            WHEN amount_usd BETWEEN 0.5   AND 1.5    THEN '$1'
            WHEN amount_usd BETWEEN 1.6   AND 2.4    THEN '$2'
            WHEN amount_usd BETWEEN 4.5   AND 5.4    THEN '$5'
            WHEN amount_usd BETWEEN 5.5   AND 6.5    THEN '$6'
            WHEN amount_usd BETWEEN 9.5   AND 10.5   THEN '$10'
            WHEN amount_usd BETWEEN 14.5  AND 15.5   THEN '$15'
            WHEN amount_usd BETWEEN 20    AND 31     THEN '$25'
            WHEN amount_usd BETWEEN 45    AND 55     THEN '$50'
            WHEN amount_usd BETWEEN 73    AND 86     THEN '$80'
            WHEN amount_usd BETWEEN 98    AND 102    THEN '$100'
            WHEN amount_usd BETWEEN 123   AND 127    THEN '$125'
            WHEN amount_usd BETWEEN 148   AND 153    THEN '$150'
            WHEN amount_usd BETWEEN 158   AND 162    THEN '$160'
            WHEN amount_usd BETWEEN 198   AND 202    THEN '$200'
            WHEN amount_usd BETWEEN 240   AND 261    THEN '$250'
            WHEN amount_usd BETWEEN 298   AND 302    THEN '$300'
            WHEN amount_usd BETWEEN 348   AND 352    THEN '$350'
            WHEN amount_usd BETWEEN 398   AND 402    THEN '$400'
            WHEN amount_usd BETWEEN 498   AND 502    THEN '$500'
            WHEN amount_usd BETWEEN 748   AND 752    THEN '$750'
            WHEN amount_usd BETWEEN 798   AND 802    THEN '$800'
            WHEN amount_usd BETWEEN 998   AND 1002   THEN '$1000'
            WHEN amount_usd BETWEEN 1248  AND 1252   THEN '$1250'
            WHEN amount_usd BETWEEN 1498  AND 1502   THEN '$1500'
            WHEN amount_usd BETWEEN 1998  AND 2002   THEN '$2000'
            WHEN amount_usd BETWEEN 2498  AND 2504   THEN '$2500'
            WHEN amount_usd BETWEEN 2998  AND 3002   THEN '$3000'
            WHEN amount_usd BETWEEN 3998  AND 4002   THEN '$4000'
            WHEN amount_usd BETWEEN 4997  AND 5004   THEN '$5000'
            WHEN amount_usd BETWEEN 5997  AND 6003   THEN '$6000'
            WHEN amount_usd BETWEEN 6997  AND 7003   THEN '$7000'
            WHEN amount_usd BETWEEN 7498  AND 7502   THEN '$7500'
            WHEN amount_usd BETWEEN 7995  AND 8005   THEN '$8000'
            WHEN amount_usd BETWEEN 9996  AND 10004  THEN '$10000'
            WHEN amount_usd BETWEEN 12497 AND 12505  THEN '$12500'
            WHEN amount_usd BETWEEN 14998 AND 15005  THEN '$15000'
            WHEN amount_usd BETWEEN 17497 AND 17505  THEN '$17500'
            WHEN amount_usd BETWEEN 19993 AND 20010  THEN '$20000'
            WHEN amount_usd BETWEEN 24997 AND 25010  THEN '$25000'
            WHEN amount_usd BETWEEN 29997 AND 30006  THEN '$30000'
            WHEN amount_usd BETWEEN 34997 AND 35010  THEN '$35000'
            WHEN amount_usd BETWEEN 39997 AND 40015  THEN '$40000'
            WHEN amount_usd BETWEEN 49998 AND 50005  THEN '$50000'
            WHEN amount_usd BETWEEN 69997 AND 70015  THEN '$70000'
            ELSE 'Other'
        END AS pack_tier
    FROM tokens_solana.transfers
    WHERE block_date >= DATE '2026-01-01'
      AND token_mint_address = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v'
      AND to_owner = '62Q9eeDY3eM8A5CnprBGYMPShdBjAzdpBdr71QHsS8dS'
      AND from_owner NOT IN (
          '42oNTirN62M3MkA52KiTTGyf9RnDh2YvqNdpFSgkf97e',
          '5sn2nniGv88bxzxBDkqWP6i8bejsr9WwCpZXq2ZkLHgf'
      )
      AND amount_usd > 0.01
)

SELECT
    pack_tier,
    COUNT(*)                                                                  AS spins,
    ROUND(SUM(amount_usd), 2)                                                 AS volume_usd,
    ROUND(AVG(amount_usd), 2)                                                 AS avg_spin_usd,
    ROUND(100.0 * SUM(amount_usd) / NULLIF(SUM(SUM(amount_usd)) OVER (), 0), 2) AS pct_of_total_volume,
    ROUND(100.0 * COUNT(*)        / NULLIF(SUM(COUNT(*))         OVER (), 0), 2) AS pct_of_total_spins
FROM base
GROUP BY 1
ORDER BY avg_spin_usd ASC
