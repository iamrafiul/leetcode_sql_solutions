WITH salary_rank AS (
    SELECT
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS s_rank
    FROM employee
)
SELECT
    MAX(salary) AS SecondHighestSalary
FROM salary_rank
WHERE s_rank = 2;
