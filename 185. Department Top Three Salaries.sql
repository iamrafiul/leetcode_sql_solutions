WITH salary_ranker AS (
    SELECT
        e.name AS Employee,
        d.name AS Department,
        e.salary,
        DENSE_RANK() OVER(PARTITION BY e.departmentId ORDER BY e.salary DESC) AS s_rank
    FROM employee e
    LEFT JOIN Department d ON e.departmentId = d.id
)

SELECT
    Department,
    Employee,
    Salary
FROM salary_ranker s
WHERE s.s_rank <= 3;
