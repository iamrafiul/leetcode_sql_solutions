SELECT employee_id FROM employees WHERE employee_id NOT IN (SELECT employee_id FROM salaries)
UNION ALL
SELECT employee_id FROM salaries WHERE employee_id NOT IN (SELECT employee_id FROM employees)
ORDER BY employee_id;
