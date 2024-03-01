/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */


SELECT DISTINCT f.title
FROM film f
WHERE f.title NOT IN (
    -- Subquery to find titles related to the United States
    SELECT DISTINCT fi.title
    FROM film fi
    JOIN inventory inv ON fi.film_id = inv.film_id
    JOIN rental ren ON inv.inventory_id = ren.inventory_id
    JOIN customer cus ON ren.customer_id = cus.customer_id
    JOIN address addr ON cus.address_id = addr.address_id
    JOIN city ci ON addr.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    WHERE co.country = 'United States'
)
AND EXISTS (
    -- Subquery to ensure the film has an inventory record
    SELECT 1
    FROM inventory inv
    WHERE inv.film_id = f.film_id
)
ORDER BY f.title;

