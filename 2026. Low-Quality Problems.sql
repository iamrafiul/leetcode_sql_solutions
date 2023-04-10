# Write your MySQL query statement below
SELECT
    p.problem_id
FROM problems p
WHERE ((p.likes / (p.likes + p.dislikes)) * 100) < 60
ORDER BY p.problem_id;
