WITH distinct_accepted AS (
    SELECT
        DISTINCT requester_id,
        accepter_id
    FROM RequestAccepted
),
distinct_requests AS (
    SELECT
        DISTINCT sender_id,
        send_to_id
    FROM FriendRequest
)
SELECT 
    IFNULL(
        ROUND(
            (SELECT COUNT(*) FROM distinct_accepted) / (SELECT COUNT(*) FROM distinct_requests)
        , 2)
    , 0.00) AS accept_rate;
