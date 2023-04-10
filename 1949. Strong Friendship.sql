# Solution with CTEs and sub-query in final part
WITH friends AS (
    SELECT user1_id AS user1_id, user2_id AS user2_id FROM Friendship
    UNION ALL
    SELECT user2_id AS user1_id, user1_id AS user2_id FROM Friendship
)
, friend_count AS (
    SELECT 
        f1.user1_id AS user1_id,
        f2.user1_id AS user2_id,
        SUM(
            CASE
                WHEN f1.user2_id = f2.user2_id THEN 1 ELSE 0
            END
        ) AS common_friend
    FROM friends f1
    JOIN friends f2 ON 
        f1.user1_id <> f2.user1_id AND 
        f1.user1_id < f2.user1_id
    GROUP BY f1.user1_id, f2.user1_id
)

SELECT
    *
FROM friend_count
WHERE (user1_id, user2_id) IN 
    (SELECT user1_id, user2_id FROM friendship ORDER BY user1_id, user2_id) AND 
    common_friend >= 3;


# Solution with CTEs and JOINs instead of sub-query
WITH friends AS (
    SELECT user1_id AS user1_id, user2_id AS user2_id FROM Friendship
    UNION ALL
    SELECT user2_id AS user1_id, user1_id AS user2_id FROM Friendship
)
, friend_count AS (
    SELECT 
        f1.user1_id AS user1_id,
        f2.user1_id AS user2_id,
        SUM(
            CASE
                WHEN f1.user2_id = f2.user2_id THEN 1 ELSE 0
            END
        ) AS common_friend
    FROM friendship f
    LEFT JOIN friends f1 ON f.user1_id = f1.user1_id
    JOIN friends f2 ON 
        f2.user1_id = f.user2_id AND 
        f1.user1_id <> f2.user1_id AND 
        f1.user1_id < f2.user1_id
    GROUP BY f1.user1_id, f2.user1_id
)

SELECT
    *
FROM friend_count
WHERE common_friend >= 3;
