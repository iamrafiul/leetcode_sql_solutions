SELECT
    q.id,
    q.year,
    IFNULL(n.npv, 0) AS npv
FROM queries q
LEFT JOIN npv n ON q.id = n.id AND q.year = n.year
GROUP BY q.id, q.year;
