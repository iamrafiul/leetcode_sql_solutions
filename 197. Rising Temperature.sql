SELECT 
    w1.id
FROM weather w1
JOIN weather w2 ON 
    w1.temperature > w2.temperature AND 
    DATEDIFF(w1.recordDate, w2.recordDate) = 1;
