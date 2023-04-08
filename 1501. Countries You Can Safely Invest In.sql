SELECT
    c.name as country
FROM person p
JOIN country c ON SUBSTRING_INDEX(p.phone_number, '-', 1) = c.country_code
JOIN calls cl ON p.id IN (cl.caller_id, cl.callee_id)
GROUP BY c.name
HAVING AVG(cl.duration) > (SELECT AVG(duration) FROM calls);
