# With sub-query and RANK
SELECT
    employee_id,
    department_id
FROM (
    SELECT
        employee_id,
        department_id,
        RANK() OVER(PARTITION BY employee_id ORDER BY primary_flag) AS d_rank
    FROM employee
) cte
WHERE cte.d_rank = 1;


# Solution with long CASE conditions - 1
WITH dept_count AS (
    SELECT
        e.employee_id,
        COUNT(department_id) as dept_count
    FROM employee e
    GROUP BY e.employee_id
)

SELECT
    d.employee_id,
    CASE
        WHEN d.dept_count > 1 THEN (SELECT department_id FROM employee e WHERE e.employee_id = d.employee_id AND e.primary_flag = 'Y') 
        ELSE (SELECT department_id FROM employee e WHERE e.employee_id = d.employee_id)
    END AS department_id
FROM dept_count d;


# Solution with long CASE conditions - 2
SELECT
    d.employee_id,
    CASE
        WHEN COUNT(department_id) > 1 THEN 
            (SELECT department_id FROM employee e WHERE e.employee_id = d.employee_id AND e.primary_flag = 'Y') 
        ELSE (SELECT department_id FROM employee e WHERE e.employee_id = d.employee_id LIMIT 1)
    END AS department_id
FROM employee d
GROUP BY d.employee_id;
