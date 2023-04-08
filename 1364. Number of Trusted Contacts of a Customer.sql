# Solution 1 to calculate trusted_contacts_cnt
SELECT
    i.invoice_id,
    cu.customer_name,
    i.price,
    COUNT(co.contact_email) AS contacts_cnt,
    SUM(
        CASE
            WHEN co.contact_email IN (select distinct email from customers) THEN 1 ELSE 0
        END
    ) AS trusted_contacts_cnt
FROM invoices i
LEFT JOIN customers cu ON i.user_id = cu.customer_id
LEFT JOIN contacts co ON i.user_id = co.user_id
GROUP BY i.invoice_id
ORDER BY i.invoice_id;


# Solution 2 to calculate trusted_contacts_cnt
SELECT
    i.invoice_id,
    cu.customer_name,
    i.price,
    COUNT(co.contact_email) AS contacts_cnt,
    SUM(
        CASE
            WHEN (SELECT COUNT(*) FROM customers WHERE email = co.contact_email) > 0 THEN 1 ELSE 0
        END
    ) AS trusted_contacts_cnt
FROM invoices i
JOIN customers cu ON i.user_id = cu.customer_id
LEFT JOIN contacts co ON i.user_id = co.user_id
GROUP BY i.invoice_id
ORDER BY i.invoice_id;
