SELECT
    c.country_name,
    CASE
        WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
        WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
        ELSE 'Warm'
    END AS weather_type
FROM weather w
LEFT JOIN countries c ON c.country_id = w.country_id
WHERE YEAR(w.day) = 2019 AND MONTH(w.day) = 11
GROUP BY w.country_id;
