WITH tiv_counter AS (
    SELECT
        *,
        COUNT(*) OVER(PARTITION BY tiv_2015) AS cnt_1,
        COUNT(*) OVER(PARTITION BY lat, lon) AS cnt_2
    FROM insurance
)

SELECT
    ROUND(
        SUM(tiv_2016), 2
    ) AS tiv_2016
FROM tiv_counter
WHERE cnt_1 >= 2 AND cnt_2 = 1;
