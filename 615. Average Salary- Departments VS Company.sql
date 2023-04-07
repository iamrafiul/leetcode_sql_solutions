WITH company_avg AS (
    SELECT
        DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
        AVG(amount) AS c_avg
    FROM salary
    GROUP BY DATE_FORMAT(pay_date, '%Y-%m')
)
, monthly_avg AS (
    SELECT
        DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
        e.department_id,
        AVG(s.amount) AS m_avg
    FROM salary s
    LEFT JOIN employee e ON s.employee_id = e.employee_id
    GROUP BY e.department_id, DATE_FORMAT(s.pay_date, '%Y-%m')
)
SELECT
    m.pay_month,
    m.department_id,
    CASE
        WHEN m_avg > c_avg THEN 'higher'
        WHEN m_avg < c_avg THEN 'lower'
        ELSE 'same'
    END AS comparison
FROM monthly_avg m
JOIN company_avg c ON m.pay_month = c.pay_month;
