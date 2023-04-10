WITH row_numbering AS (
    SELECT
        id,
        drink,
        ROW_NUMBER() OVER() AS row_num
    FROM CoffeeShop
)
, block AS (
    SELECT *,
    SUM(
        CASE WHEN drink is NULL THEN 0 ELSE 1 
    END) OVER(ORDER BY row_num) AS block
    FROM row_numbering
)

SELECT
    id,
    first_value(drink) OVER(PARTITION BY block) AS drink
FROM block;
