SELECT
    SUM(
        CASE
            WHEN DAYNAME(submit_date) IN ("Saturday", "Sunday") THEN 1 ELSE 0
        END
    ) AS weekend_cnt,
    SUM(
        CASE
            WHEN DAYNAME(submit_date) NOT IN ("Saturday", "Sunday") THEN 1 ELSE 0
        END
    ) AS working_cnt
FROM tasks;
