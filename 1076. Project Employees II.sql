WITH employee_count AS (
    SELECT
        project_id,
        COUNT(employee_id) AS total_employee
    FROM project
    GROUP BY project_id
)

SELECT
    project_id
FROM employee_count
WHERE total_employee = (SELECT MAX(total_employee) FROM employee_count);
