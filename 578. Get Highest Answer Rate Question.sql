WITH answer_rate_calc AS (
    SELECT
        question_id,
        SUM(
            CASE WHEN action = 'answer' THEN 1 ELSE 0 END
        ) 
        / (1.0 * 
            SUM(
                CASE WHEN action = 'show' THEN 1 ELSE 0 END
            )
        ) as ans_rate
    FROM SurveyLog 
    GROUP BY question_id
)

SELECT
    question_id AS survey_log
FROM answer_rate_calc
ORDER BY ans_rate DESC LIMIT 1;
