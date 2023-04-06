WITH salary_ranker AS(
    SELECT
        name,
        departmentId,
        salary,
        RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) as s_rank
    FROM employee
)

SELECT
    d.name AS Department,
    s.name AS Employee,
    s.salary AS Salary
FROM salary_ranker s
LEFT JOIN department d ON s.departmentId = d.id
WHERE s.s_rank = 1;
