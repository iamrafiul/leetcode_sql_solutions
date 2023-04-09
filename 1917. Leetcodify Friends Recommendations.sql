# Solution with two CTEs and NOT EXISTS
WITH friends AS (
    SELECT user1_id AS user1, user2_id AS user2 FROM friendship
    UNION
    SELECT user2_id AS user1, user1_id AS user2 FROM friendship
)
, listen_count AS (
    SELECT
        l1.user_id AS user1,
        l2.user_id AS user2,
        l1.day
    FROM listens l1
    JOIN listens l2 ON 
        l1.user_id <> l2.user_id AND 
        l1.song_id = l2.song_id AND 
        l1.day = l2.day
    GROUP BY l1.user_id, l2.user_id, l1.day
    HAVING COUNT(DISTINCT l1.song_id) >= 3
)

SELECT 
    DISTINCT user1 as user_id,
    user2 as recommended_id
FROM listen_count a
WHERE NOT EXISTS 
    (select 1 from friendship b where a.user1 = b.user1_id and a.user2 = b.user2_id) AND
      NOT EXISTS 
    (select 1 from friendship c where a.user1 = c.user2_id and a.user2 = c.user1_id);


# Solution with two CTEs and simple JOIN
WITH friends AS (
    SELECT user1_id AS user1, user2_id AS user2 FROM friendship
    UNION
    SELECT user2_id AS user1, user1_id AS user2 FROM friendship
)
, listen_count AS (
    SELECT
        l1.user_id AS user1,
        l2.user_id AS user2,
        l1.day
    FROM listens l1
    JOIN listens l2 ON 
        l1.user_id <> l2.user_id AND 
        l1.song_id = l2.song_id AND 
        l1.day = l2.day
    GROUP BY l1.user_id, l2.user_id, l1.day
    HAVING COUNT(DISTINCT l1.song_id) >= 3
)

SELECT 
    DISTINCT a.user1 as user_id,
    a.user2 as recommended_id
FROM listen_count a
LEFT JOIN friends f ON a.user1 = f.user1 AND a.user2 = f.user2
WHERE f.user1 IS NULL;
