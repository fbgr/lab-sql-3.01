USE sakila;

-- 1. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon.
-- Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO sakila.staff(first_name,last_name,address_id,email,store_id,username)
(SELECT first_name,last_name,address_id,email,store_id,first_name
FROM sakila.customer
WHERE first_name = "Tammy" AND last_name = "Sanders");

SELECT * -- just checking it worked
FROM sakila.staff;

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1...
INSERT INTO sakila.rental(rental_date,inventory_id,customer_id,staff_id,last_update)
(SELECT max(rental_date),(SELECT min(inventory_id) -- from all the possible IDS I take the min
from sakila.inventory i INNER JOIN sakila.film f
USING (film_id) WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1) AS inventory_id, 
(SELECT customer_id FROM sakila.customer
WHERE first_name = "Charlotte" AND last_name = "Hunter") AS customer_id,
(SELECT staff_id FROM sakila.staff WHERE first_name = "Mike") AS staff_id,
max(rental_date) as last_update
FROM sakila.rental);

SELECT * -- just checking it worked.
FROM SAKILA.rental