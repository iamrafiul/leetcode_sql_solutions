SELECT
    d.dept_name,
    COUNT(DISTINCT s.student_id) as student_number
FROM department d
LEFT JOIN student s ON d.dept_id = s.dept_id
GROUP by d.dept_name
ORDER BY student_number DESC, d.dept_name;
