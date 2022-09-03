-- 1) List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, district
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- output: 5 [Kim Cruz, Jennifer Davis, Bryan Hudson, Ian Still, Richard Mccrary]


-- 2) Get all payments above $6.99 with the Customers Full Name
SELECT first_name, last_name, amount
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;
-- output: 3,698 rows

-- 3) Show all customer names who have made payments over $175 (use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- 4) List all customers that live in Nepal (use the city table)
SELECT first_name, last_name
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id 
FULL JOIN city 
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';
-- output: Kevin Schuler

-- 5) Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(rental.staff_id)
FROM staff
RIGHT JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY first_name, last_name;
-- output: Mike Hillyer with 8040 rentals

-- 6) How many movies of each rating are there?
SELECT COUNT(DISTINCT title), rating
FROM film
GROUP BY rating;
-- output: 179 G | 194 PG | 223 PG-13 | 195 R | 209 NC-17

-- 7) Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY first_name, last_name, payment.customer_id  
	HAVING COUNT(DISTINCT amount) > 6.99
	ORDER BY payment.customer_id
);
-- output: 499 rows

-- 8) How many free rentals did our store give away?
SELECT customer_id, amount
FROM payment
WHERE amount < 0.01
GROUP BY payment_id, amount;
-- output: I didn't see any free rentals in payment, but it appears Mary is owed $$$$$