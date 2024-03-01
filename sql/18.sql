/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */


SELECT
    u.rank,
    u.title,
    u.revenue,
    u."total revenue",
    CASE
        WHEN (100 * u."total revenue" / SUM(u.revenue) OVER ()) < 100
            THEN TRIM(TO_CHAR((100 * u."total revenue" / SUM(u.revenue) OVER ()), '00.00'))
        ELSE TRIM('100.00')
    END AS "percent revenue"
FROM (
    SELECT
        t.rank,
        t.title,
        t.revenue,
        SUM(t.revenue) OVER (ORDER BY t.rank) AS "total revenue"
    FROM (
        SELECT
            RANK() OVER (ORDER BY COALESCE(SUM(payment.amount), 0.00) DESC) AS rank,
            film.title AS title,
            COALESCE(SUM(payment.amount), 0.00) AS revenue
        FROM film
        LEFT JOIN inventory ON film.film_id = inventory.film_id
        LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
        LEFT JOIN payment ON rental.rental_id = payment.rental_id
        GROUP BY film.title
    ) AS t
) AS u
ORDER BY u.rank, u.title;

