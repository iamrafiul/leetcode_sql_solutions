WITH exp_ranker AS(
    SELECT
        p.project_id,
        p.employee_id,
        RANK() OVER(PARTITION BY project_id ORDER BY experience_years DESC) AS e_rank
    FROM project p
    LEFT JOIN employee e ON e.employee_id = p.employee_id
)

SELECT
    p.project_id,
    p.employee_id
FROM exp_ranker p
WHERE p.e_rank = 1
ORDER BY p.project_id, p.employee_id;
