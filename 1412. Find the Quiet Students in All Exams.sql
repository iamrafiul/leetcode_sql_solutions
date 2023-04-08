# Solution with two CTEs and sub-query in WHERE clause
WITH quiet_ranker AS(
    SELECT
        exam_id,
        student_id,
        RANK() OVER(PARTITION BY exam_id ORDER BY score) AS s_rank,
        RANK() OVER(PARTITION BY exam_id ORDER BY score DESC) AS r_rank
    FROM exam
)
,rank_dist AS(
    SELECT
        DISTINCT student_id
    FROM quiet_ranker 
    WHERE s_rank = 1 OR r_rank = 1
)

SELECT
    *
FROM student
WHERE 
    student_id NOT IN (SELECT * FROM rank_dist) AND 
    student_id IN (SELECT student_id FROM EXAM);


# Solution with two CTEs and JOIN instead of sub-query for WHERE clause
WITH quiet_ranker AS(
    SELECT
        student_id,
        RANK() OVER(PARTITION BY exam_id ORDER BY score) AS s_rank,
        RANK() OVER(PARTITION BY exam_id ORDER BY score DESC) AS r_rank
    FROM exam
)
,rank_dist AS(
    SELECT
        DISTINCT student_id
    FROM quiet_ranker 
    WHERE s_rank = 1 OR r_rank = 1
)
SELECT
    DISTINCT q.student_id,
    s.student_name
FROM quiet_ranker q
LEFT JOIN student s ON q.student_id = s.student_id
WHERE q.student_id NOT IN (SELECT * FROM rank_dist)
ORDER BY q.student_id;
