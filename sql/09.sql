/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */

SELECT special_features, COUNT(*)
FROM (
    SELECT unnest(special_features) as special_features
    FROM film
) AS t
GROUP BY special_features
ORDER BY special_features;

