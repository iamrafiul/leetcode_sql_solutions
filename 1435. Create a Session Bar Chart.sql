# Solution UNION, straight forward and easier to read & understand
select '[0-5>' bin, count(*) total from sessions where duration/60 >=0 and duration/60<5
union
select '[5-10>',count(*) total from sessions where duration/60 >=5 and duration/60<10
union
select '[10-15>',count(*) total from sessions where duration/60 >=10 and duration/60<15
union
select '15 or more',count(*) total from sessions where duration/60 >=15;


# Same logic with CTE and sub-query, bit complex to read & understand
WITH bin_creator AS (
    select '[0-5>' as bin 
    union all
    select '[5-10>' as bin
    union all
    select '[10-15>' as bin
    union all
    select '15 or more' as bin
)
SELECT
    bc.bin,
    COUNT(cte.session_id) AS total
FROM bin_creator bc 
LEFT JOIN (
    SELECT    
        CASE
            WHEN duration / 60 >= 0 AND duration / 60 < 5 THEN "[0-5>"
            WHEN duration / 60 >= 5 AND duration / 60 < 10 THEN "[5-10>"
            WHEN duration / 60 >= 10 AND duration / 60 < 15 THEN "[10-15>"
            ELSE "15 or more"
        END AS bin,
        session_id
    FROM sessions
) AS cte ON bc.bin = cte.bin
GROUP BY bc.bin;
