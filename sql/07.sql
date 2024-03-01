/*
 * A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * NOTE:
 * This can be solved by either using a LEFT JOIN or by using the NOT IN clause and a subquery.
 * For this problem, you should use the NOT IN clause;
 * in problem 07b you will use the LEFT JOIN clause.
 *
 * NOTE:
 * This is the last problem that will require you to use a particular method to solve the query.
 * In future problems, you may choose whether to use the LEFT JOIN or NOT IN clause if they are more applicable.
 */



SELECT DISTINCT f.title
FROM film f
WHERE NOT EXISTS (
    /* Subquery to exclude films related to the United States*/
    SELECT 1
    FROM film f_inner
    JOIN inventory i ON f_inner.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN customer cu ON r.customer_id = cu.customer_id
    JOIN address a ON cu.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    WHERE co.country = 'United States' AND f_inner.film_id = f.film_id
)
AND EXISTS (
    -- Subquery to include films that have an inventory record
    SELECT 1
    FROM inventory i
    WHERE i.film_id = f.film_id
)
ORDER BY f.title;

