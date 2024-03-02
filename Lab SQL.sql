/* Lab | SQL Intro

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. You can follow the steps listed here to get the data locally: [Sakila sample database - installation](https://dev.mysql.com/doc/sakila/en/sakila-installation.html). You can work with two sql query files - `sakila-schema.sql` (creates the schema) + `sakila-data.sql` which inserts the data.

The ERD is pictured below - not all tables are shown, but many of the key fields you will be using are visible:

### Instructions

 /*1. Use sakila database.*/
 USE sakila;

 /*2. Get all the data from tables `actor`, `film` and `customer`.*/
select * from actor;
select * from film;
select * from customer;

/*3. Get film titles.*/
select title from film;

/*4. Get unique list of film languages under the alias `language`. Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.*/
select distinct language_id as language from film;

/*5.
  - 5.1 Find out how many stores does the company have?
  - 5.2 Find out how many employees staff does the company have? 
  - 5.3 Return a list of employee first names only?*/
select * from store;
select count(*) as cantidad_de_tiendas from store;
select * from staff;
select count(*) as cantidad_de_empleados from staff;
select first_name from staff;

/*6. Select all the actors with the first name ‘Scarlett’.*/
select * from actor;
select * from actor 
where first_name = 'SCARLETT';

/*7. Select all the actors with the last name ‘Johansson’.*/
select * from actor
where last_name = 'JOHANSSON';

/*8. How many films (movies) are available for rent?*/
select * from film;
select count(*) as cantidad_de_peliculas from film;

/*9. What are the shortest and longest movie duration? Name the values max_duration and min_duration.*/
select * from film;
select min(length) as duracion_minima, max(length) as duracion_maxima from film;

/*10. What's the average movie duration?*/
select * from film;
select avg (length) as duracion_promedio from film;

/*11. How many movies are longer than 3 hours?*/
select * from film;
select count(*) as peliculas_largas from film where length > 180;

/*12. What's the length of the longest film title? */
select * from film;
select max(length(title)) as titulo_mas_largo from film;

