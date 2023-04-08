# CTE with WEEKDAY and JOIN at the end
WITH weekday_distributor AS(
    SELECT
        orders.*,
        CASE
            WHEN WEEKDAY(order_date) = 0 THEN 'Monday'
            WHEN WEEKDAY(order_date) = 1 THEN 'Tuesday'
            WHEN WEEKDAY(order_date) = 2 THEN 'Wednesday'
            WHEN WEEKDAY(order_date) = 3 THEN 'Thursday'
            WHEN WEEKDAY(order_date) = 4 THEN 'Friday'
            WHEN WEEKDAY(order_date) = 5 THEN 'Saturday'
            WHEN WEEKDAY(order_date) = 6 THEN 'Sunday'
        END AS week_day
    FROM orders
)

SELECT 
    items.item_category AS Category,
    SUM(
        CASE
            WHEN week_day = 'Monday' THEN quantity ELSE 0
        END
    ) AS 'Monday',
    SUM(
        CASE
            WHEN week_day = 'Tuesday' THEN quantity ELSE 0
        END
    ) AS 'Tuesday',
    SUM(
        CASE
            WHEN week_day = 'Wednesday' THEN quantity ELSE 0
        END
    ) AS 'Wednesday',
    SUM(
        CASE
            WHEN week_day = 'Thursday' THEN quantity ELSE 0
        END
    ) AS 'Thursday',
    SUM(
        CASE
            WHEN week_day = 'Friday' THEN quantity ELSE 0
        END
    ) AS 'Friday',
    SUM(
        CASE
            WHEN week_day = 'Saturday' THEN quantity ELSE 0
        END
    ) AS 'Saturday',
    SUM(
        CASE
            WHEN week_day = 'Sunday' THEN quantity ELSE 0
        END
    ) AS 'Sunday'
FROM items
LEFT JOIN weekday_distributor ON Items.item_id = weekday_distributor.item_id
GROUP BY items.item_category
ORDER BY items.item_category;


# CTE with WEEKDAY and JOIN
WITH weekday_distributor AS(
    SELECT
        items.item_category,
        orders.item_id,
        orders.quantity,
        CASE
            WHEN WEEKDAY(order_date) = 0 THEN 'Monday'
            WHEN WEEKDAY(order_date) = 1 THEN 'Tuesday'
            WHEN WEEKDAY(order_date) = 2 THEN 'Wednesday'
            WHEN WEEKDAY(order_date) = 3 THEN 'Thursday'
            WHEN WEEKDAY(order_date) = 4 THEN 'Friday'
            WHEN WEEKDAY(order_date) = 5 THEN 'Saturday'
            WHEN WEEKDAY(order_date) = 6 THEN 'Sunday'
        END AS week_day
    FROM orders
    RIGHT JOIN Items ON Items.item_id = orders.item_id
)
SELECT
    item_category AS Category,
    SUM(
        CASE
            WHEN week_day = 'Monday' THEN quantity ELSE 0
        END
    ) AS 'Monday',
    SUM(
        CASE
            WHEN week_day = 'Tuesday' THEN quantity ELSE 0
        END
    ) AS 'Tuesday',
    SUM(
        CASE
            WHEN week_day = 'Wednesday' THEN quantity ELSE 0
        END
    ) AS 'Wednesday',
    SUM(
        CASE
            WHEN week_day = 'Thursday' THEN quantity ELSE 0
        END
    ) AS 'Thursday',
    SUM(
        CASE
            WHEN week_day = 'Friday' THEN quantity ELSE 0
        END
    ) AS 'Friday',
    SUM(
        CASE
            WHEN week_day = 'Saturday' THEN quantity ELSE 0
        END
    ) AS 'Saturday',
    SUM(
        CASE
            WHEN week_day = 'Sunday' THEN quantity ELSE 0
        END
    ) AS 'Sunday'
FROM weekday_distributor
GROUP BY item_category
ORDER BY item_category;


# Another way of doing the same query with DAYNAME
WITH category_finder AS (
    SELECT
        i.item_category,
        o.quantity,
        DAYNAME(order_date) AS week_day
    FROM items i 
    LEFT JOIN orders o ON i.item_id = o.item_id
)

SELECT 
    item_category AS Category,
    SUM(CASE WHEN week_day = 'Monday' THEN quantity ELSE 0 END) AS Monday,
    SUM(CASE WHEN week_day = 'Tuesday' THEN quantity ELSE 0 END) AS Tuesday,
    SUM(CASE WHEN week_day = 'Wednesday' THEN quantity ELSE 0 END) AS Wednesday,
    SUM(CASE WHEN week_day = 'Thursday' THEN quantity ELSE 0 END) AS Thursday,
    SUM(CASE WHEN week_day = 'Friday' THEN quantity ELSE 0 END) AS Friday,
    SUM(CASE WHEN week_day = 'Saturday' THEN quantity ELSE 0 END) AS Saturday,
    SUM(CASE WHEN week_day = 'Sunday' THEN quantity ELSE 0 END) AS Sunday
FROM category_finder
GROUP BY item_category
ORDER BY item_category;
