SELECT
    s.school_id,
    IFNULL(MIN(e.score), -1) AS score
FROM schools s
LEFT JOIN exam e ON s.capacity >= e.student_count
GROUP BY s.school_id, s.capacity;
