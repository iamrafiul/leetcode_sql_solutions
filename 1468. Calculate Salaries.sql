# With CTE and JOIN
WITH company_category AS(
    SELECT
        company_id,
        CASE
            WHEN MAX(salary) < 1000 THEN 0
            WHEN MAX(salary) BETWEEN 1000 AND 10000 THEN 24
            ELSE 49
        END AS tax
    FROM salaries
    GROUP BY company_id
)

SELECT
    s.company_id,
    s.employee_id,
    s.employee_name,
    ROUND(
        s.salary - (s.salary * (cc.tax / 100))
    ) AS salary
FROM salaries s
LEFT JOIN company_category cc ON s.company_id = cc.company_id;


# With CTE and WINDOW function
WITH company_category AS(
    SELECT
        *,
        CASE
            WHEN MAX(salary) OVER(PARTITION BY company_id) < 1000 THEN 0
            WHEN MAX(salary) OVER(PARTITION BY company_id) BETWEEN 1000 AND 10000 THEN 24
            ELSE 49
        END AS tax
    FROM salaries
)
SELECT
    s.company_id,
    s.employee_id,
    s.employee_name,
    ROUND(
        s.salary - (s.salary * (s.tax / 100))
    ) AS salary
FROM company_category s;
