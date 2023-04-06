WITH salary_ranker AS(
    SELECT
        id,
        company,
        salary,
        ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) s_rank,
        COUNT(*) OVER(PARTITION BY company) as total
    FROM employee
)

SELECT
    s.id,
    s.company,
    s.salary
FROM salary_ranker s
WHERE s_rank >= total/2 AND s_rank <= total/2+1;