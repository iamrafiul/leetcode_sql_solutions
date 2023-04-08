WITH course_grader AS(
    SELECT
        student_id,
        course_id,
        grade,
        RANK() OVER(partition by student_id ORDER BY grade DESC, course_id) g_rank
    FROM enrollments
)

SELECT
    student_id,
    course_id,
    grade
FROM course_grader
WHERE g_rank = 1;
