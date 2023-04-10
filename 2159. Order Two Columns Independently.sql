# Separate CTEs for first and second column and the JOIN
WITH first_cols AS (
    SELECT
        first_col,
        ROW_NUMBER() OVER(ORDER BY first_col) AS c_rank
    FROM data 
),
second_cols AS (
    SELECT
        second_col,
        ROW_NUMBER() OVER(ORDER BY second_col DESC) AS c_rank
    FROM data 
)
SELECT
    f.first_col,
    s.second_col
FROM first_cols f
LEFT JOIN second_cols s ON f.c_rank = s.c_rank;


# Single CTE for both columns and self JOIN
WITH col_ranker AS (
    SELECT
        first_col,
        ROW_NUMBER() OVER(ORDER BY first_col) AS f_rank,
        second_col,
        ROW_NUMBER() OVER(ORDER BY second_col DESC) AS c_rank
    FROM data
)

SELECT
    c1.first_col,
    c2.second_col
FROM col_ranker c1
JOIN col_ranker c2 ON c1.f_rank = c2.c_rank
ORDER BY c1.f_rank;
