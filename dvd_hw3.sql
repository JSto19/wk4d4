--Q1 List all customers in TX using JOINs.
SELECT customer_id, first_name, last_name
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--Q2 Get payments above $6.99 with C's full name.
SELECT first_name, last_name, SUM(amount)
FROM CUSTOMER
FULL JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name
HAVING SUM(amount)>6.99;

--Q3 Show all customers names who have made payments over $175 (sub-q)
SELECT first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount)>175
);

--Q4 List all customers in Nepal (city table)
SELECT customer_id, first_name, last_name
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE country_id IN (
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
); --Brian said in video to go through city.

--Q5 Which staff_m had most transactions?
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
FULL JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment_id) DESC;

--Q6 What film had the most actors in it?
SELECT film, title, COUNT(actor_id) AS count
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.film_id
ORDER BY COUNT(actor_id) DESC; --I struggled with this one, I don't think it is totally right?

--Q7 Show all customers whomade single payment over 6.99 (sub-q)
SELECT first_name,last_name
FROM customer
WHERE customer_id in (
	SELECT customer_id
 	FROM payment 	
	WHERE amount > 6.99 
);

--Q8 Which cat is more prevalent in films?
SELECT name, COUNT(film.film_id)
FROM category
RIGHT JOIN film_category
ON category.category_id = film_category.category_id
LEFT JOIN film
ON film_category.film_id = film.film_id
GROUP BY name
ORDER BY COUNT(film.film_id) DESC;
