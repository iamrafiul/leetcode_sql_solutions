SELECT
    session_id
FROM playback
WHERE session_id NOT IN (
    SELECT
        p.session_id
    FROM playback p
    JOIN ads a ON 
        p.customer_id = a.customer_id AND 
        a.timestamp >= p.start_time AND 
        a.timestamp <= p.end_time
);
