# Without LEAD/LAG, two joins
SELECT
    DISTINCT c.num AS ConsecutiveNums
FROM Logs AS c
JOIN Logs AS c1 ON c.num = c1.num AND c.id + 1 = c1.id
JOIN Logs AS c2 ON c1.num = c2.num AND c1.id + 1 = c2.id


# With LEAD/LAG, no joins
WITH cons_calc AS (
    SELECT
        id,
        num,
        LAG(num, 1) OVER() AS prev_num,
        LEAD(num, 1) OVER() AS next_num
    FROM logs
)
SELECT
    DISTINCT c.num AS ConsecutiveNums
FROM cons_calc AS c
WHERE num = prev_num AND num = next_num;
