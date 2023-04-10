WITH flight_count AS (
    SELECT departure_airport AS airport_id, flights_count FROM flights
    UNION ALL
    SELECT arrival_airport AS airport_id, flights_count FROM flights
)
, total_flights AS (
    SELECT
        airport_id,
        SUM(flights_count) AS total
    FROM flight_count
    GROUP BY airport_id
)

SELECT
    airport_id
FROM total_flights
WHERE total = (SELECT MAX(total) FROM total_flights);
