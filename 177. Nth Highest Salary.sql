CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      WITH SALARY_RANKER AS (
        SELECT
          salary,
          DENSE_RANK() OVER (ORDER BY salary DESC) AS s_rank
        FROM employee
      )
         
      SELECT
        MAX(salary)
      FROM SALARY_RANKER
      WHERE s_rank = N
  );
END
