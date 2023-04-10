WITH max_degree AS (
    SELECT
        city_id,
        MAX(degree) AS degree
    FROM weather
    GROUP BY city_id
)

SELECT
    m.city_id,
    MIN(w.day) AS day,
    m.degree
FROM max_degree m
LEFT JOIN weather w ON m.city_id = w.city_id AND m.degree = w.degree
GROUP BY m.city_id, m.degree
ORDER BY city_id;
