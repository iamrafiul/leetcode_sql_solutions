SELECT
    score,
    DENSE_RANK() OVER(ORDER BY score DESC) AS 'rank'
FROM scores
ORDER BY score DESC;
