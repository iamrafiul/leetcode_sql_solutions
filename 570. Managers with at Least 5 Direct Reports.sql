# Solution 1
SELECT
    m.name
FROM employee e
JOIN employee m ON m.id = e.managerId
GROUP by m.name
HAVING count(distinct e.id) >= 5;


# Solution 2
WITH manager_stat AS (
    SELECT
        managerId
    FROM employee
    GROUP BY managerId
    HAVING COUNT(id) >= 5
)

SELECT 
    e.name
FROM manager_stat m
LEFT JOIN employee e ON m.managerId = e.id
WHERE e.name IS NOT null;
