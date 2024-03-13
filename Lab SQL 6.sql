# Lab | SQL Subqueries
### Instructions
use sakila;

/*1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?*/
select COUNT(*) as num_copies
from film
where title = 'Hunchback Impossible';

/*2. List all films whose length is longer than the average of all the films.*/
select title
from film
where length > (select avg(length) from film);

/*3. Use subqueries to display all actors who appear in the film _c_.*/
select concat(first_name, ' ', last_name) as actor_name
from actor
where actor_id in (select actor_id
from film_actor
where film_id = (select film_id
from film
where title = 'Alone Trip')
);

/*4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.*/
select title as family_movie
from film
where rating = 'G' or rating = 'PG';

/*5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.*/
select c.first_name, c.last_name, c.email
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Canada';

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id
FROM address
WHERE city_id IN (SELECT city_id
FROM city
WHERE country_id = (SELECT country_id
FROM country
WHERE country = 'Canada')
)
);

/*6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.*/
select actor_id, count(*) as num_films
from film_actor
group by actor_id
order by num_films desc
limit 1;
/* Me dio intriga y queria saber quien era este actor o actriz no se si esta bien*/
select first_name, last_name
from actor
where actor_id = (select actor_id
from film_actor
group by actor_id
order by count(*) desc
limit 1
); 

select f.title as movie_title
from film_actor fa
join film f on fa.film_id = f.film_id
where fa.actor_id = (select actor_id
from film_actor
group by actor_id
order by count(*) desc
limit 1
);

/*7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments*/
select customer_id, sum(amount) as total_payments
from payment
group by customer_id
order by total_payments desc
limit 1;

/* Me dio intriga y queria saber quien era ese cliente o clienta no se si esta bien*/
select first_name, last_name
from customer
where customer_id = (select customer_id
from customer
group by customer_id
order by count(*) desc
limit 1
);

select f.title as movie_title
from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
where r.customer_id = (select customer_id
from payment
group by customer_id
order by sum(amount) desc
limit 1
);

/*8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the `total_amount` spent by each client.*/

select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id
having sum(amount) > (select avg(total_amount_spent)
from (select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id) as avg_payments
);
