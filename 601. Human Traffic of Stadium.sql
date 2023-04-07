# Straight JOIN
SELECT
    DISTINCT s1.id,
    s1.visit_date,
    s1.people
FROM stadium s1
JOIN stadium s2
JOIN stadium s3
WHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
AND (
    (s1.id - s2.id = 1 AND s1.id - s3.id = 2 AND s2.id - s3.id = 1) -- t1, t2, t3
    OR
    (s2.id - s1.id = 1 AND s2.id - s3.id = 2 AND s1.id - s3.id = 1) -- t2, t1, t3
    OR
    (s3.id - s2.id = 1 AND s3.id - s1.id = 2 AND s3.id - s1.id = 2) -- t3, t2, t1
)
ORDER BY s1.id;


# With CTE AND LEAD/LAG by id
WITH stadium_dates AS (
    SELECT
        id,
        LAG(id, 2) OVER(ORDER BY visit_date) AS day_1,
        LAG(id, 1) OVER(ORDER BY visit_date) AS day_2,
        visit_date,
        LEAD(id, 1) OVER(ORDER BY visit_date) AS day_4,
        LEAD(id, 2) OVER(ORDER BY visit_date) AS day_5,
        people
    FROM stadium
    WHERE people >= 100
)

SELECT
    id,
    visit_date,
    people
FROM stadium_dates
WHERE 
    (day_1 + 1 = day_2 AND day_2 + 1 = id) OR
    (day_2 + 1 = id AND id + 1 = day_4) OR
    (id + 1 = day_4 AND day_4 + 1 = day_5)
ORDER BY visit_date;


# With CTE AND LEAD/LAG by people
WITH consecutive_ids AS (
    SELECT
        id,
        visit_date,
        LAG(people, 2) OVER(ORDER BY id) AS prev2,
        LAG(people, 1) OVER(ORDER BY id) AS prev1,
        people,
        LEAD(people, 1) OVER(ORDER BY id) AS next1,
        LEAD(people, 2) OVER(ORDER BY id) AS next2
    FROM stadium
)   

SELECT 
    id,
    visit_date,
    people
FROM consecutive_ids
WHERE 
    (prev2 >= 100 AND prev1 >= 100 AND people >= 100) OR
    (prev1 >= 100 AND people >= 100 AND next1 >= 100) OR
    (people >= 100 AND next1 >= 100 AND next2 >= 100);
