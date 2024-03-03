 /* Lab | SQL Queries 3*/

/* ### Instructions*/

/* 1. How many distinct (different) actors' last names are there?*/
select count(distinct last_name) as apellidos_distintos from actor;

/* 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)*/
select count(distinct language_id) as idiomas_diferentes from film;

/* 3. How many movies were released with `"PG-13"` rating?*/
select rating from film;
select count(*) as peliculas_PG13 from film 
WHERE rating = 'PG-13';

/* 4. Get 10 the longest movies from 2006.*/
select * from film where release_year = 2006 
order by length desc 
limit 10;

/* 5. How many days has been the company operating (check `DATEDIFF()` function)?*/
/* NO ENTENDI EL ENUNCIADO. */

/* 6. Show rental info with additional columns month and weekday. Get 20.*/
select rental_date from rental;
select dayname from rental;
select *, month(rental_date) as mes, dayname(rental_date) as dia_de_la_semana from rental 
limit 20;

/* 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.*/
select *,
    case
        when dayofweek(rental_date) in (1,7) then 'weekend'
        else 'workday'
    end as day_type
from rental;

/* 8. How many rentals were in the last month of activity?*/
select * from rental;
select count(*) as alquileres_ultimo_mes from rental
where month(rental_date) = month((select max(rental_date) from rental)) 
and year(rental_date) = year((select max(rental_date) from rental));

