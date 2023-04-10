WITH salary_ranker AS (
    SELECT
        *,
        SUM(salary) OVER(PARTITION BY experience ORDER BY salary) AS budget
    FROM candidates
)
, seniors AS(
    SELECT 
        employee_id, 
        budget 
    FROM salary_ranker where experience="senior"and budget <= 70000
)
, juniors AS(
    SELECT 
        employee_id, 
        budget
    FROM salary_ranker 
    WHERE budget <= 70000 - (SELECT IFNULL(MAX(budget), 0) FROM seniors)
)

SELECT employee_id FROM seniors
UNION
SELECT employee_id FROM juniors;
