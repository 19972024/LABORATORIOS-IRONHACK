# Lab | SQL Queries 7
### Instructions

/*1. In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.*/
select distinct last_name
from actor
order by last_name;

/*2. Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once*/
select last_name from actor
group by last_name
having count(*) > 1
order by last_name;

/*3. Using the rental table, find out how many rentals were processed by each employee.*/
select staff_id, count(*) as total_rentals
from rental
group by staff_id;

/*4. Using the film table, find out how many films were released each year.*/
select release_year from film;
select release_year as year, count(*) as films
FROM film
group by release_year;

/*5. Using the film table, find out for each rating how many films were there.*/
SELECT rating, count(*) as films
from film
group by rating;

/*6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places */
select rating, round(avg(length), 2) as average_duration
from film
group by rating;


/*7. Which kind of movies (rating) have a mean duration of more than two hours?*/
-- Step 1: Calculate the average duration for each rating
-- Primero, necesitamos calcular la duración media de cada tipo de película.
-- Esto se puede hacer utilizando la función AVG() para calcular la media de la columna "length"
-- y agrupando los resultados por el tipo de película.
select rating, round(avg(length), 2) as average_duration
from film
group by rating;
select rating, round(avg(length), 2) as average_duration
from film
where length > (select avg(length) from film where length > 120)
group by rating;