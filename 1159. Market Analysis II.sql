WITH order_rank AS(
    SELECT
        seller_id,
        item_id,
        RANK() OVER(PARTITION BY seller_id ORDER BY order_date) as s_rank
    FROM orders
), 
fav_calculator AS(
    SELECT
        o.seller_id,
        i.item_brand
    FROM order_rank o
    INNER JOIN items i ON o.item_id = i.item_id
    WHERE o.s_rank = 2
)

SELECT
    u.user_id AS seller_id,
    CASE
        WHEN u.favorite_brand = f.item_brand THEN 'yes'
        ELSE 'no'
    END AS 2nd_item_fav_brand
FROM users u
LEFT JOIN fav_calculator f ON u.user_id = f.seller_id;
