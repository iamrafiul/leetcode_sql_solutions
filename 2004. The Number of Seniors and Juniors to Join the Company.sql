# Solution 1
WITH exp_rank AS(
    SELECT
        experience,
        salary,
        SUM(salary) OVER(PARTITION BY experience ORDER BY salary, employee_id) AS total_salary
    FROM candidates
),

senior_salary AS (
    SELECT
        experience,
        total_salary,
        COUNT(*) as accepted_candidates,
        CASE
            WHEN COUNT(*) = 0 THEN 70000 ELSE (70000 - MAX(total_salary)) END
        as remaining_budget
    FROM exp_rank
    WHERE experience = 'Senior' AND total_salary <= 70000
),

junior_salary AS (
    SELECT
        experience,
        COUNT(*) as accepted_candidates
    FROM exp_rank
    WHERE experience = 'Junior' AND total_salary <= (SELECT remaining_budget FROM senior_salary)
)

SELECT
    'Senior' AS experience,
    accepted_candidates
FROM senior_salary

UNION

SELECT
    'Junior' AS experience,
    accepted_candidates
FROM junior_salary;


# Solution 1(Different way of calculating junior salaries)
WITH employee_ranker AS(
    SELECT
        employee_id,
        experience,
        SUM(salary) OVER(PARTITION BY experience ORDER BY salary) AS running_total
    FROM candidates
    ORDER BY experience, running_total
)
, senior_count AS (
    SELECT
        employee_id,
        running_total
    FROM employee_ranker 
    WHERE running_total <= 70000 AND experience = 'Senior'
)
, junior_count AS (
    SELECT
        employee_id
    FROM employee_ranker
    WHERE running_total <= (70000 - IFNULL((SELECT MAX(running_total) FROM senior_count), 0))
    AND experience = 'Junior'
)

SELECT 'Senior' as experience, COUNT(*) AS accepted_candidates FROM senior_count
UNION ALL
SELECT 'Junior' as experience, COUNT(*) AS accepted_candidates FROM junior_count;
