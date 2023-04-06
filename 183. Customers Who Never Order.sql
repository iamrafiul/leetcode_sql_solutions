SELECT
    name AS Customers
FROM customers 
WHERE id NOT IN (
    SELECT DISTINCT customerId from orders
);
