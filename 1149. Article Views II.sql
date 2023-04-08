# One query, concise
SELECT
	DISTINCT viewer_id AS id
FROM Views
GROUP BY viewer_id, view_date
HAVING COUNT(DISTINCT article_id) > 1
ORDER BY 1;


# With CTE, easier to read and understand
WITH view_count AS (
    SELECT
        viewer_id,
        view_date,
        COUNT(DISTINCT article_id) AS total_view
    FROM views
    GROUP BY viewer_id, view_date
)
SELECT
	DISTINCT viewer_id AS id
FROM view_count
WHERE total_view > 1;
