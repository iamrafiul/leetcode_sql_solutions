SELECT
    country_name,
    CASE
        WHEN AVG(weather_state) >= 25 THEN 'Hot'
        WHEN AVG(weather_state) <= 15 THEN 'Cold'
        ELSE 'Warm'
    END AS weather_type
FROM weather
LEFT JOIN countries ON countries.country_id = weather.country_id
WHERE YEAR(day) = 2019 AND MONTH(day) = 11
GROUP BY weather.country_id;
