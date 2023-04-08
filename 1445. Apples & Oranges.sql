# Solution with seperate sum and then subtract
SELECT
    sale_date,
    SUM(
        CASE WHEN fruit = 'apples' THEN sold_num ELSE 0 END
    ) -
    SUM(
        CASE WHEN fruit = 'oranges' THEN sold_num ELSE 0 END
    ) AS diff
FROM sales
GROUP BY sale_date;


# Same logic with single CASE and SUM
SELECT
    sale_date,
    SUM(
        CASE 
            WHEN fruit = 'apples' THEN sold_num 
            WHEN fruit = 'oranges' THEN -sold_num
            ELSE 0 
        END
    ) AS diff
FROM sales
GROUP BY sale_date;
