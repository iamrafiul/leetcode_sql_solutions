# With CTEs and sub-query
WITH customers_with_zero_type AS (
    SELECT
        DISTINCT customer_id
    FROM orders 
    WHERE order_type = 0
)
, zero_orders_customers AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_type
    FROM orders o
    WHERE customer_id IN 
        (SELECT customer_id FROM customers_with_zero_type) AND 
        o.order_type = 0
)
, nonzero_orders_customers AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_type
    FROM orders o
    WHERE o.customer_id NOT IN 
        (SELECT customer_id FROM customers_with_zero_type)
)

SELECT * FROM zero_orders_customers
UNION
SELECT * FROM nonzero_orders_customers;


# Zero order calculation with LEFT JOIN
WITH customers_with_zero_type AS (
    SELECT
        DISTINCT customer_id
    FROM orders 
    WHERE order_type = 0
)
, zero_orders_customers AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_type
    FROM customers_with_zero_type c
    LEFT JOIN orders o ON 
        o.customer_id = c.customer_id AND 
        o.order_type = 0
)
, nonzero_orders_customers AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_type
    FROM orders o
    WHERE o.customer_id NOT IN 
        (SELECT customer_id FROM customers_with_zero_type)
)

SELECT * FROM zero_orders_customers
UNION
SELECT * FROM nonzero_orders_customers;


# Zero order calculation with RIGHT JOIN
WITH customers_with_zero_type AS (
    SELECT
        DISTINCT customer_id
    FROM orders 
    WHERE order_type = 0
)
, zero_orders_customers AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_type
    FROM orders o
    RIGHT JOIN customers_with_zero_type c ON 
        o.customer_id = c.customer_id AND 
        o.order_type = 0    
)
, nonzero_orders_customers AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_type
    FROM orders o
    WHERE o.customer_id NOT IN (SELECT customer_id FROM customers_with_zero_type)
)

SELECT * FROM zero_orders_customers
UNION
SELECT * FROM nonzero_orders_customers;
