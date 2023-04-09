SELECT 
    user_id , 
    CONCAT(
        UPPER(SUBSTR(Users.name,1,1)),
        LOWER(SUBSTR(Users.name,2))
    ) AS name 
FROM Users
ORDER BY user_id;
