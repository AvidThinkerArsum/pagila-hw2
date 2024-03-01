/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */


SELECT DISTINCT f.title
FROM film f
WHERE f.rating = 'G'
AND 'Trailers' = ANY(f.special_features)
ORDER BY f.title;

