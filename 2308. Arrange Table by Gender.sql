WITH gender_rank AS (
    SELECT
        user_id,
        gender,
        RANK() OVER(PARTITION BY gender ORDER BY user_id) AS g_rank
    FROM genders
)

SELECT 
    user_id,
    gender
FROM gender_rank
ORDER BY g_rank, gender;
