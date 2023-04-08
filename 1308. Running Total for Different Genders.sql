SELECT
    gender,
    day,
    SUM(score_points) OVER(partition by gender order by day) as total
FROM scores
ORDER BY gender, day;
