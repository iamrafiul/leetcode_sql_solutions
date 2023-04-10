# Solution 1
WITH term_table AS (
    SELECT 
        power,
        CASE
            WHEN factor > 0 THEN CONCAT('+', factor)
            ELSE factor
        END AS factor,
        ROW_NUMBER() OVER(ORDER BY power DESC) AS line
    FROM terms
)
, line_creator AS (
    SELECT 
        line, 
        CONCAT(
            LTRIM(factor),
            CASE
                WHEN power = 1 THEN 'X'
                WHEN power = 0 THEN ''
                ELSE CONCAT('X^', LTRIM(power))
            END
        ) AS equation
    FROM term_table
    ORDER BY line
)

SELECT 
    CONCAT(GROUP_CONCAT(equation SEPARATOR ''), '=0') AS equation
FROM line_creator;


# Solution 2
WITH term_table AS (
    SELECT 
        ROW_NUMBER() OVER(ORDER BY power DESC) AS line, 
        CONCAT(
            LTRIM(CASE
                WHEN factor > 0 THEN CONCAT('+', factor)
                ELSE factor
            END),
            CASE
                WHEN power = 1 THEN 'X'
                WHEN power = 0 THEN ''
                ELSE CONCAT('X^', LTRIM(power))
            END
        ) AS equation
    FROM terms
    ORDER BY line
)

SELECT 
    CONCAT(GROUP_CONCAT(equation SEPARATOR ''), '=0') AS equation
FROM term_table;
