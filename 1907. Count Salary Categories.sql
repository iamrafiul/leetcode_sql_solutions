# Solution with CTE and UNION
WITH salary_categories AS (
    SELECT
        account_id,
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income >= 20000 AND income <= 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END as category
    FROM accounts
)
, categories AS (
    SELECT 'Low Salary' as category
    UNION 
    SELECT 'Average Salary' as category
    UNION
    SELECT 'High Salary' as category
)

SELECT
    c.category,
    IFNULL(COUNT(account_id), 0) AS accounts_count
FROM categories c
LEFT JOIN salary_categories sc ON c.category = sc.category
GROUP BY c.category;


# Solution with UNION only
SELECT 'Low Salary' as category, COUNT(*) as accounts_count FROM accounts WHERE income < 20000
UNION
SELECT 'Average Salary' as category, COUNT(*) as accounts_count FROM accounts WHERE income >= 20000 AND income <= 50000
UNION
SELECT 'High Salary' as category, COUNT(*) as accounts_count FROM accounts WHERE income > 50000;
