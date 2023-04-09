# Solution with two CTEs and DENSE_RANK
WITH salary_ranker AS(
    SELECT
        employee_id,
        name,
        salary,
        DENSE_RANK() OVER(PARTITION BY salary ORDER BY salary) as s_rank
    FROM employees
)
,salary_count AS (
    SELECT
        employee_id,
        name,
        salary,
        COUNT(salary) AS occurance
    FROM employees
    GROUP BY salary
)

SELECT 
    sr.employee_id,
    sr.name,
    sr.salary,
    DENSE_RANK() OVER(ORDER BY sr.salary) AS team_id
FROM salary_ranker sr
LEFT JOIN salary_count sc ON sr.salary = sc.salary
WHERE sc.occurance > 1;


# Solution with one CTEs using HAVING and DENSE_RANK
WITH valid_salary AS (
    SELECT
        salary
    FROM employees
    GROUP BY salary
    HAVING COUNT(salary) > 1
)

SELECT 
    e.*,
    DENSE_RANK() OVER(ORDER BY e.salary) AS team_id
FROM employees e 
WHERE e.salary IN (SELECT salary FROM valid_salary)
ORDER BY team_id, employee_id;
