# Without CTE, two JOINs
SELECT
    e.id,
    e.month,
    e.salary + IFNULL(e1.salary, 0) + IFNULL(e2.salary , 0) AS salary
FROM employee e
LEFT JOIN employee e1 ON e.id = e1.id AND e.month - 1 = e1.month
LEFT JOIN employee e2 ON e.id = e2.id AND e.month - 2 = e2.month
WHERE e.month != (SELECT MAX(month) FROM employee WHERE id = e.id)
ORDER BY e.id, e.month DESC;


# With CTE and LAG
WITH salary_serial AS (
    SELECT
        id,
        LAG(month, 2) OVER(PARTITION BY id) AS prev2,
        LAG(month, 1) OVER(PARTITION BY id) AS prev1,
        month,
        IFNULL(LAG(salary, 2) OVER(PARTITION BY id ORDER BY month), 0) AS prevs2,
        IFNULL(LAG(salary, 1) OVER(PARTITION BY id ORDER BY month), 0) AS prevs1,
        salary
    FROM employee
)
SELECT
    id,
    month,
    SUM(
        (CASE WHEN prev2 + 2 = month THEN prevs2 ELSE 0 END) 
        +
        (CASE WHEN prev1 + 1 = month THEN prevs1 ELSE 0 END)
        +
        salary
    ) AS Salary
FROM salary_serial
WHERE 
    (id, month) NOT IN (SELECT id, MAX(month) FROM employee GROUP BY id)
GROUP BY id, month
ORDER BY id, month desc;


# With CTE and without LAG
WITH cum_salary AS(
    SELECT
        e.id,
        e.month,
        e.salary,
        e1.salary AS salary_1,
        e2.salary AS salary_2
    FROM employee e
    LEFT JOIN employee e1 ON e.id = e1.id AND e.month - 1 = e1.month
    LEFT JOIN employee e2 ON e.id = e2.id AND e.month - 2 = e2.month
    WHERE e.month != (SELECT MAX(month) FROM employee WHERE id = e.id)
    GROUP BY e.id, e.month
)

SELECT
    id, 
    month,
    salary + IFNULL(salary_1, 0) + IFNULL(salary_2, 0) AS salary
FROM cum_salary c
ORDER BY id, month DESC;
