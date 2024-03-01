/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */


SELECT a.last_name, a.first_name
FROM actor a
WHERE NOT EXISTS (
    SELECT 1
    FROM customer c
    WHERE a.first_name || a.last_name = c.first_name || c.last_name
)
ORDER BY a.last_name, a.first_name;

