WITH passenger_buses AS (
	SELECT
		p.passenger_id,
		MIN(b.arrival_time) AS time_to_board
	FROM passengers p
	JOIN buses b ON p.arrival_time <= b.arrival_time
	GROUP BY passenger_id
)

SELECT
	bus_id,
	COUNT(p.time_to_board) as passengers_cnt
FROM buses b
LEFT JOIN passenger_buses p ON p.time_to_board = b.arrival_time
GROUP BY bus_id
ORDER BY bus_id;
