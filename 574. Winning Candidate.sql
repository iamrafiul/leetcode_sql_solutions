WITH vote_count AS(
    SELECT
        candidateId,
        DENSE_RANK() OVER(ORDER BY COUNT(id) DESC) AS c_rank
    FROM vote 
    GROUP BY candidateId
)
SELECT
    c.name
FROM candidate c
WHERE c.id = (SELECT candidateId from vote_count WHERE c_rank = 1);
