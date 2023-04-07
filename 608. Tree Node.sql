# Three separate checks for Root, Inner and Leaf 
SELECT
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id NOT IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        WHEN id IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
    END AS type
FROM Tree;


# Two checks for Root and Inner - Way 1
SELECT
    t1.id,
    CASE
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id IN (SELECT DISTINCT p_id FROM tree) AND t1.p_id IS NOT NULL THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM tree t1
ORDER BY t1.id;


# Two checks for Root and Inner - Way 2
SELECT
    t1.id,
    CASE
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id IN (SELECT DISTINCT p_id FROM tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM tree t1
ORDER BY t1.id;
