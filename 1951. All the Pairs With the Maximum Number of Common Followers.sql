WITH common_finder AS (
    SELECT
        f1.user_id AS user1_id,
        f2.user_id AS user2_id,
        COUNT(f1.follower_id) AS total_common
    FROM relations f1
    LEFT JOIN relations f2 ON 
        f1.user_id <> f2.user_id AND 
        f1.user_id < f2.user_id AND 
        f1.follower_id = f2.follower_id
    GROUP BY f1.user_id, f2.user_id
)

SELECT 
    user1_id,
    user2_id
FROM common_finder
WHERE user2_id IS NOT NULL AND 
    total_common = (SELECT MAX(total_common) FROM common_finder WHERE user2_id IS NOT NULL);
