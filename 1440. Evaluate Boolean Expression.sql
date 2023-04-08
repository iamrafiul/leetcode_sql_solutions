SELECT
    left_operand,
    operator,
    right_operand,
    CASE
        WHEN operator = '>' AND v1.value > v2.value THEN 'true'
        WHEN operator = '>' AND v1.value < v2.value THEN 'false'
        WHEN operator = '<' AND v1.value < v2.value THEN 'true'
        WHEN operator = '<' AND v1.value > v2.value THEN 'false'
        WHEN operator = '=' AND v1.value = v2.value THEN 'true'
        ELSE 'false'
    END AS value
FROM expressions e
LEFT JOIN variables v1 ON v1.name = e.left_operand # x
LEFT JOIN variables v2 ON v2.name = e.right_operand; # y
