SELECT
    ee.unique_id,
    e.name
FROM employees e
LEFT JOIN EmployeeUNI ee ON e.id = ee.id;
