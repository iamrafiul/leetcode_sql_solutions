# Solution with UNION and sub-query
WITH friends AS (
    SELECT user1_id AS user1, user2_id AS user2 FROM friendship
    UNION
    SELECT user2_id AS user1, user1_id AS user2 FROM friendship
)
,listen_count AS(
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
    DISTINCT lc.user1 AS user1_id,
    lc.user2 AS user2_id
FROM listen_count lc
WHERE (lc.user1, lc.user2) IN (
    SELECT user1_id, user2_id FROM friendship
);


# Solution with JOIN and without UNION
WITH listen_count AS(
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
    DISTINCT lc.user1 AS user1_id,
    lc.user2 AS user2_id
FROM listen_count lc
LEFT JOIN friendship f ON 
    lc.user1 = f.user1_id AND 
    lc.user2 = f.user2_id
WHERE f.user1_id IS NOT NULL;
