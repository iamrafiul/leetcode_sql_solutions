WITH student_ranker AS(
    SELECT
        student_id,
        department_id,
        RANK() OVER(PARTITION BY department_id ORDER BY mark DESC) AS s_rank,
        COUNT(student_id) OVER(PARTITION BY department_id) AS total_students
    FROM students
) 

SELECT
    student_id,
    department_id,
    ROUND(
        IFNULL(
            (s_rank - 1) * 100 / (total_students -1)
        , 0)
    , 2) AS percentage
FROM student_ranker;
