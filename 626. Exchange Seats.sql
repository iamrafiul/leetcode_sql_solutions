# Logic 1
SELECT
	CASE
		WHEN id % 2 != 0 AND id != (SELECT COUNT(*) FROM seat) THEN id + 1
		WHEN id % 2 != 0 AND id = (SELECT COUNT(*) FROM seat) THEN id
		ELSE id - 1
	END AS id,
	student
FROM seat
ORDER BY id;


# Logic 2
SELECT
    CASE
        WHEN id = (SELECT COUNT(*) FROM seat) AND (SELECT COUNT(*) FROM seat) % 2 = 1 THEN id
        WHEN id % 2 = 0 THEN id - 1
        WHEN id % 2 != 0 THEN id + 1
    END AS id,
    student
FROM seat
ORDER BY id;
