SELECT
    DISTINCT s.user_id
FROM confirmations s
JOIN confirmations c ON 
    s.user_id = c.user_id AND 
    s.time_stamp != c.time_stamp AND 
    s.time_stamp < c.time_stamp
WHERE s.time_stamp >= DATE_SUB(c.time_stamp, INTERVAL 24 HOUR);
