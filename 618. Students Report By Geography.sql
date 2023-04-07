WITH continent_ranker AS(
    SELECT
        name,
        continent,
        ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) as c_rank
    FROM student
)

SELECT
    MAX(CASE WHEN continent = 'America' THEN name ELSE NULL END) as America,
    MAX(CASE WHEN continent = 'Asia' THEN name ELSE NULL END) as Asia,
    MAX(CASE WHEN continent = 'Europe' THEN name ELSE NULL END) as Europe
FROM continent_ranker
GROUP BY c_rank;
