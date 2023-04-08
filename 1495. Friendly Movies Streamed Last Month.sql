# With GROUP BY, no distinct
SELECT
    c.title
FROM TVProgram t
LEFT JOIN content c ON t.content_id = c.content_id
WHERE 
    c.Kids_content = 'Y' AND 
    c.content_type = 'Movies' AND 
    MONTH(t.program_date) = 6 AND YEAR(t.program_date) = 2020
GROUP BY c.title
ORDER BY c.title;


# Without GROUP BY and distinct
SELECT
    DISTINCT c.title
FROM TVProgram t
LEFT JOIN content c ON t.content_id = c.content_id
WHERE 
    c.Kids_content = 'Y' AND 
    c.content_type = 'Movies' AND 
    MONTH(t.program_date) = 6 AND YEAR(t.program_date) = 2020
ORDER BY c.title;
