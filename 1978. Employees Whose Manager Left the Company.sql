SELECT
    e1.employee_id
FROM employees e1
WHERE e1.salary < 30000 AND 
    e1.manager_id NOT IN (SELECT employee_id from employees)
ORDER BY e1.employee_id;
