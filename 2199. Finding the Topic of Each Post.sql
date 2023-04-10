WITH kw_finder AS (
    SELECT
        post_id,
        topic_id
    FROM posts p
    LEFT JOIN keywords k ON 
        CONCAT(' ', LOWER(content), ' ') LIKE CONCAT('% ', LOWER(word), ' %')
)

SELECT
    post_id,
    IFNULL(GROUP_CONCAT(DISTINCT topic_id), 'Ambiguous!') AS topic
FROM kw_finder
GROUP BY post_id;
