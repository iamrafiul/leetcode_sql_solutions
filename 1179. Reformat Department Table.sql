SELECT
    id,
    SUM(CASE 
        WHEN month = 'Jan' THEN revenue ELSE NULL 
    END) Jan_Revenue,
    SUM(CASE 
        WHEN month = 'Feb' THEN revenue ELSE NULL 
    END) Feb_Revenue,
    SUM(CASE 
        WHEN month = 'Mar' THEN revenue ELSE NULL 
    END) Mar_Revenue,
    SUM(CASE 
        WHEN month = 'Apr' THEN revenue ELSE NULL 
    END) Apr_Revenue,
    SUM(CASE 
        WHEN month = 'May' THEN revenue ELSE NULL 
    END) May_Revenue,
    SUM(CASE 
        WHEN month = 'Jun' THEN revenue ELSE NULL 
    END) Jun_Revenue,
    SUM(CASE 
        WHEN month = 'Jul' THEN revenue ELSE NULL 
    END) Jul_Revenue,
    SUM(CASE 
        WHEN month = 'Aug' THEN revenue ELSE NULL 
    END) Aug_Revenue,
    SUM(CASE 
        WHEN month = 'Sep' THEN revenue ELSE NULL 
    END) Sep_Revenue,
    SUM(CASE 
        WHEN month = 'Oct'THEN revenue ELSE NULL 
    END) Oct_Revenue,
    SUM(CASE 
        WHEN month = 'Nov'THEN revenue ELSE NULL 
    END) Nov_Revenue,
    SUM(CASE 
        WHEN month = 'Dec'THEN revenue ELSE NULL 
    END) Dec_Revenue
FROM department
GROUP BY id;
