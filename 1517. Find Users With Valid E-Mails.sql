# One of the rarest SQL problem with regular expression
SELECT
    user_id, 
    name,
    mail
FROM
    Users
WHERE
    mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode[.]com$';
 