# Modular solution with Two CTEs
WITH subject_distributor AS (
    SELECT
        student_id, 
        student_name, 
        subject_name 
    FROM students JOIN subjects
),
exam_count AS(
    SELECT
        student_id,
        subject_name,
        COUNT(subject_name) AS attended_exams
    FROM examinations
    GROUP BY student_id, subject_name
)

SELECT
    sd.student_id,
    sd.student_name,
    sd.subject_name,
    IFNULL(ec.attended_exams, 0) as attended_exams
FROM subject_distributor sd
LEFT JOIN exam_count ec ON 
    sd.student_id = ec.student_id AND 
    sd.subject_name = ec.subject_name
GROUP BY sd.student_id, sd.subject_name
ORDER BY sd.student_id, sd.subject_name;


# Concise solution with two JOINs, no CTEs
SELECT 
    s.student_id, 
    student_name , 
    sub.subject_name , 
    COUNT(e.student_id) AS attended_exams
FROM Students s 
JOIN Subjects sub
LEFT JOIN Examinations e ON 
    s.student_id=e.student_id AND 
    sub.subject_name=e.subject_name
GROUP BY s.student_id,sub.subject_name
ORDER BY student_id,sub.subject_name;
