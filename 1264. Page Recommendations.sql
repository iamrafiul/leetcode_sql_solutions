SELECT
    DISTINCT l.page_id AS recommended_page
FROM friendship f
LEFT JOIN likes l ON 
    (f.user1_id = 1 OR f.user2_id = 1)  AND 
    (f.user2_id = l.user_id OR f.user1_id = l.user_id)
WHERE 
    l.page_id NOT IN (SELECT page_id FROM likes where user_id = 1) AND 
    l.page_id IS NOT NULL;
