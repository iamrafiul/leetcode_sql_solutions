# With sub-query, easier to read
SELECT
    cte.ad_id,
    ROUND(
        IFNULL(
            (cte.clicked / (cte.clicked + cte.viewed)) * 100
        , 0)
    , 2) AS ctr
FROM (
    SELECT
        ad_id,
        SUM(CASE
            WHEN action = 'Viewed' THEN 1 ELSE 0
        END) AS viewed,
        SUM(CASE
            WHEN action = 'Clicked' THEN 1 ELSE 0
        END) AS clicked
    FROM ads
    GROUP BY ad_id
) cte
ORDER BY ctr DESC, ad_id ASC;


# Without sub-query, concise
SELECT
    ad_id,
    ROUND( 
        IFNULL( 
            SUM(CASE
                WHEN action = 'Clicked' THEN 1 ELSE 0
            END) /
            (
                SUM(CASE WHEN action = 'Viewed' THEN 1 ELSE 0 END) + SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END)
            ) * 100
        , 0)
    , 2) AS ctr
FROM ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;