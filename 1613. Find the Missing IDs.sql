WITH RECURSIVE nums AS (
    SELECT 1 AS value
    UNION ALL
    SELECT value + 1 AS value
    FROM nums
    WHERE nums.value < (select max(customer_id) from Customers)
)

SELECT 
    value as ids 
FROM nums 
WHERE value NOT IN (SELECT DISTINCT customer_id FROM customers)
ORDER BY value;
