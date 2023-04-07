# Straight forward JOIN condition
SELECT
    DISTINCT c.seat_id
FROM cinema c
JOIN cinema c1 ON (c.seat_id + 1 = c1.seat_id OR c.seat_id = c1.seat_id + 1) AND c.free = 1 AND c1.free = 1
ORDER BY c.seat_id;


# JOIN condition with ABS
SELECT
    DISTINCT c1.seat_id
FROM cinema c1
JOIN cinema c2 ON abs(c1.seat_id - c2.seat_id) = 1 AND c1.free = 1 AND c2.free = 1
ORDER BY c1.seat_id;
