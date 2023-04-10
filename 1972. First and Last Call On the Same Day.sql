# Solution with two CTEs and DISTINCT
WITH callers AS (
    SELECT caller_id AS user1, recipient_id AS user2, call_time FROM calls
    UNION ALL
    SELECT recipient_id AS user1, caller_id AS user2, call_time FROM calls
)
, find_callers AS (
    SELECT
        user1,
        FIRST_VALUE(user2) OVER(PARTITION BY user1, DATE(call_time) ORDER BY call_time) AS first_caller,
        FIRST_VALUE(user2) OVER(PARTITION BY user1, DATE(call_time) ORDER BY call_time DESC) AS last_caller
    FROM callers
)

SELECT
    DISTINCT user1 AS user_id
FROM find_callers
WHERE first_caller = last_caller;


# Same solution without DISTINCT(final SELECT statement)
WITH all_caller AS(
    SELECT caller_id user_id, recipient_id receiver_id, call_time FROM calls
    UNION
    SELECT recipient_id user_id, caller_id receiver_id, call_time FROM calls
),
first_last_caller AS (
    SELECT
        DISTINCT user_id,
        FIRST_VALUE(receiver_id) OVER(PARTITION BY user_id, DATE(call_time) ORDER BY call_time) first_recp_id,
        FIRST_VALUE(receiver_id) OVER(PARTITION BY user_id, DATE(call_time) ORDER BY call_time DESC) last_recp_id
    FROM all_caller
)

SELECT
    user_id
FROM first_last_caller
WHERE first_recp_id = last_recp_id
GROUP BY user_id;
