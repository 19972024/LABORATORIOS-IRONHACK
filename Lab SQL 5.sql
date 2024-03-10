# Lab | SQL Queries 8
### Instructions

/*1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.*/
select title, length, rating, 
       rank() over (order by length) as movie_rank
from film
where length is not null and length != 0
order by length;

/*2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.*/
select title, length, rating, category,
       rank() over (partition by rating order by length) as movie_rank
from (
    select f.title, f.length, f.rating, c.name as category
    from film f
    join film_category fc on f.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
    where f.length is not null and f.length != 0
) as subquery
order by rating, length;

/*3. How many films are there for each of the categories in the category table? **Hint**: Use appropriate join between the tables "category" and "film_category".*/
select c.name as category, count(*) as number_of_movies
from category c
join film_category fc on c.category_id = fc.category_id
group by c.name;

/*4. Which actor has appeared in the most films? **Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.*/
select a.actor_id, a.first_name, a.last_name, count(*) as movies_participated
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id
order by movies_participated desc
limit 1;

/*5. Which is the most active customer (the customer that has rented the most number of films)? **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.*/
select c.customer_id, c.first_name, c.last_name, count(*) as movies_rented
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id
order by movies_rented desc
limit 1;

/*6. List the number of films per category.*/
select c.name as category, count(*) as number_of_movies
from category c
join film_category fc on c.category_id = fc.category_id
group by c.name;

/*7. Display the first and the last names, as well as the address, of each staff member.*/
select concat(s.first_name, ' ', s.last_name) as full_name, a.address
from staff s
join address a on s.address_id = a.address_id;

/*8. Display the total amount rung up by each staff member in August 2005.*/
select concat(s.first_name, ' ', s.last_name) as full_name, sum(p.amount) as total_revenue
from staff s
join payment p on s.staff_id = p.staff_id
where p.payment_date between '2005-08-01' and '2005-08-31'
group by s.staff_id;

/*9. List all films and the number of actors who are listed for each film.*/
select film.title as films, count(film_actor.actor_id) as "Númber of Actors"
from film
join film_actor on film.film_id = film_actor.film_id
group by film.title;

/*10. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.*/
select concat(customer.last_name, ' ', customer.first_name) as cliente, sum(payment.amount) as "Total"
from customer
join payment on customer.customer_id = payment.customer_id
group by customer.customer_id
order by customer.last_name, customer.first_name;

/*11. Write a query to display for each store its store ID, city, and country.*/
select store.store_id, city.city, country.country
from store
join address on store.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;

/*12. Write a query to display how much business, in dollars, each store brought in.*/
select store.store_id, sum(payment.amount) as "Volumen de Ventas"
from store
join staff on store.manager_staff_id = staff.staff_id
join payment on staff.staff_id = payment.staff_id
group by store.store_id;

/*13. What is the average running time of films by category?*/
select category.name, avg(film.length) as "Duración media"
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.name;

/*14. Which film categories are longest?*/
select category.name, sum(film.length) as "Duración total"
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.name
order by "Duración total" desc;

/*15. Display the most frequently rented movies in descending order.*/
select film.title, count(rental.rental_id) as "Número de alquileres"
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.title
order by "Número de alquileres" desc;

/*16. List the top five genres in gross revenue in descending order.*/
select category.name, sum(payment.amount) as "Ingresos totales"
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by category.name
order by "Ingresos totales" desc
limit 5;

/*17. Is "Academy Dinosaur" available for rent from Store 1?*/
select case when count(*) > 0 then 'Sí' else 'No' end as "¿Is Academy Dinosaur available for rent from Store 1?"
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join store on inventory.store_id = store.store_id
where film.title = 'Academy Dinosaur' and store.store_id = 1;