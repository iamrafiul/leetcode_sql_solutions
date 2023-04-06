# With sub-query
DELETE p1.* 
FROM person p1
WHERE p1.id NOT IN (
    SELECT * FROM 
        (SELECT min(id) FROM person GROUP BY email) as p
)


# With join
DELETE p1.* 
FROM person p1
JOIN person p2 ON p1.email = p2.email
WHERE p1.id > p2.id;
