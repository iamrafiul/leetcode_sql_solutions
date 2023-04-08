WITH user_q AS (
    SELECT
        u.name,
        COUNT(u.user_id) AS total_review
    FROM MovieRating mr
    LEFT JOIN users u ON u.user_id = mr.user_id
    GROUP BY mr.user_id
    ORDER BY total_review DESC, u.name
    LIMIT 1
),
movie_q AS (
    SELECT
        m.title,
        AVG(mr.rating) AS avg_rating
    FROM MovieRating mr
    LEFT JOIN movies m ON m.movie_id = mr.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY mr.movie_id
    ORDER BY avg_rating DESC, m.title
    LIMIT 1
)

SELECT name AS results FROM user_q
UNION 
SELECT title AS results FROM movie_q;
