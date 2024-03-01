/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */

SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE 'Behind the Scenes' = ANY(f.special_features)
ORDER BY "Actor Name";

