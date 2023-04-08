SELECT
    s1.sub_id AS post_id,
    IFNULL(COUNT(DISTINCT s2.sub_id), 0) AS number_of_comments
FROM submissions s1
LEFT JOIN submissions s2 ON s1.sub_id = s2.parent_id
WHERE s1.parent_id IS NULL
GROUP BY s1.sub_id;
