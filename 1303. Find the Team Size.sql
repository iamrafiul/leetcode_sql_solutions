# A very good example of how WINDOW functions can
# be useful and significantly reduce code size as
# well as the code complexity


# With sub-query, no WINDOW function
SELECT
    e2.employee_id, 
    e1.team_size
FROM (
    SELECT 
        team_id,
        COUNT(DISTINCT employee_id) AS team_size
    FROM employee
    GROUP BY team_id
) e1
JOIN employee e2 ON e1.team_id = e2.team_id;


# With WINDOW function, without any sub-query
SELECT
    employee_id,
    COUNT(*) OVER(PARTITION BY team_id) as team_size
FROM employee;
