/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

SELECT f.title
FROM film f
JOIN (
    select title, unnest(special_features) as feature
    from film
) as feature_table1 USING (title)
JOIN (
    select title, unnest(special_features) as feature
    from film
) as feature_table2 USING (title)
WHERE feature_table1.feature = 'Trailers'
AND feature_table2.feature = 'Behind the Scenes'
ORDER BY f.title;

