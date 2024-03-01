/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1(last hw), you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */


SELECT DISTINCT c.customer_id
FROM customer AS c
INNER JOIN rental AS r ON c.customer_id = r.customer_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN film AS f ON i.film_id = f.film_id
WHERE f.film_id IN (
    SELECT fi.film_id
    FROM film AS fi
    INNER JOIN inventory AS inv ON fi.film_id = inv.film_id
    INNER JOIN rental AS rent ON inv.inventory_id = rent.inventory_id
    INNER JOIN payment AS pay ON rent.rental_id = pay.rental_id
    GROUP BY fi.film_id
    ORDER BY SUM(pay.amount) DESC
    LIMIT 5
)
ORDER BY c.customer_id;

