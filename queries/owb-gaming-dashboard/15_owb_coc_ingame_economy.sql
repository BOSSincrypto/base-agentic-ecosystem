-- OWB Agentic Gaming Dashboard - Query 15: CoC In-Game Economy
-- Tracks the CoC (Clash of Coins) in-game currency and oCOIN activity
-- COC Token: 0x4c3DEa2858e66c1e116b1eB54b4404025F84cFE9
-- oCOIN Token: 0x5B8F638330d7D6bD9D43811fe702F6894e97EF03
-- Save as: "OWB Gaming - In-Game Economy"

WITH coc_daily AS (
    SELECT
        block_date AS day,
        COUNT(*) AS transfers,
        COUNT(DISTINCT "from") AS senders,
        COUNT(DISTINCT "to") AS receivers,
        SUM(amount) AS volume_coc
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x4c3DEa2858e66c1e116b1eB54b4404025F84cFE9
      AND block_date >= DATE '2026-01-01'
    GROUP BY 1
),

ocoin_daily AS (
    SELECT
        block_date AS day,
        COUNT(*) AS transfers,
        COUNT(DISTINCT "from") AS senders,
        COUNT(DISTINCT "to") AS receivers,
        SUM(amount) AS volume_ocoin
    FROM tokens.transfers
    WHERE blockchain = 'base'
      AND contract_address = 0x5B8F638330d7D6bD9D43811fe702F6894e97EF03
      AND block_date >= DATE '2026-01-01'
    GROUP BY 1
),

date_spine AS (
    SELECT day FROM UNNEST(sequence(DATE '2026-01-01', current_date, interval '1' day)) AS t(day)
)

SELECT
    ds.day,
    COALESCE(cd.transfers, 0) AS "COC Transfers",
    COALESCE(cd.senders, 0) AS "COC Unique Senders",
    COALESCE(cd.receivers, 0) AS "COC Unique Receivers",
    ROUND(COALESCE(cd.volume_coc, 0), 2) AS "COC Volume",
    COALESCE(od.transfers, 0) AS "oCOIN Transfers",
    COALESCE(od.senders, 0) AS "oCOIN Unique Senders",
    ROUND(COALESCE(od.volume_ocoin, 0), 2) AS "oCOIN Volume",
    -- Combined in-game economy activity
    COALESCE(cd.transfers, 0) + COALESCE(od.transfers, 0) AS "Total In-Game Txs",
    AVG(COALESCE(cd.transfers, 0) + COALESCE(od.transfers, 0))
        OVER (ORDER BY ds.day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS "In-Game Txs 7d MA",
    SUM(COALESCE(cd.transfers, 0) + COALESCE(od.transfers, 0))
        OVER (ORDER BY ds.day) AS "Cumulative In-Game Txs"
FROM date_spine ds
LEFT JOIN coc_daily cd ON ds.day = cd.day
LEFT JOIN ocoin_daily od ON ds.day = od.day
WHERE ds.day < current_date
ORDER BY ds.day ASC
