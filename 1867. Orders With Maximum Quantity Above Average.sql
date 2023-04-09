# Standard solution with CTE and sub-query
WITH order_sorter AS (
    SELECT
        order_id,
        MAX(quantity) max_quantity,
        AVG(quantity) avg_quantity
    FROM OrdersDetails
    GROUP BY order_id
)

SELECT
    order_id
FROM order_sorter
WHERE max_quantity > (SELECT MAX(avg_quantity) FROM order_sorter);


# A tricky but useful solution with WINDOW function
WITH order_sorter AS (
    SELECT
        order_id,
        MAX(quantity) max_quantity,
        MAX(AVG(quantity)) OVER() avg_quantity
    FROM OrdersDetails
    GROUP BY order_id
)

SELECT
    order_id
FROM order_sorter
WHERE max_quantity > avg_quantity;
