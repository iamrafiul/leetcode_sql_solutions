SELECT
    DISTINCT author_id AS id
FROM views
GROUP BY author_id
HAVING SUM(CASE WHEN author_id = viewer_id THEN 1 ELSE 0 END) > 0
ORDER BY author_id;
