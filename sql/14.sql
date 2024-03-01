/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */

SELECT
    EXTRACT (YEAR FROM rental_date)  as "Year",
    EXTRACT (MONTH FROM rental_date)  as "Month",
    SUM (amount) "Total Revenue"
FROM
    rental
join payment using (rental_id)
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM rental_date),
        EXTRACT (MONTH FROM rental_date)
    )
order by EXTRACT (YEAR FROM rental_date), EXTRACT (MONTH FROM rental_date), SUM (amount);
