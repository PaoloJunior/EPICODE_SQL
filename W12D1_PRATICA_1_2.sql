/*PRATICA(1)*/
SELECT 
    COUNT(customer.customer_id) AS NUMERO_CLIENTI
FROM
    customer
WHERE
    YEAR(customer.create_date) = '2006';

/*richiesta numero3*/
SELECT 
    COUNT(rental.rental_id) AS CLIENTI_REGISTRATI_INDATA
FROM
    rental
WHERE
    DATE(rental_date) = '2006-02-14';

/*richiesta numero4*/
SELECT 
    customer.*, rental.rental_date, film.title
FROM
    customer
        LEFT JOIN
    payment ON customer.customer_id = payment.payment_id
        LEFT JOIN
    rental ON payment.rental_id = rental.rental_id
        LEFT JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        LEFT JOIN
    film ON inventory.film_id = film.film_id
WHERE
    WEEK(rental.rental_date) = (SELECT DISTINCT
            WEEK(rental.rental_date) AS numero_settimana
        FROM
            rental
        WHERE
            YEAR(rental.rental_date) = (SELECT 
                    YEAR(MAX(rental.rental_date))
                FROM
                    rental)
        ORDER BY 1 DESC
        LIMIT 1)
ORDER BY 11;
        
        /*esercizio4-metodo2*/
SELECT 
    film.title AS TitoloFilm, customer.*
FROM
    film
        LEFT JOIN
    inventory ON film.film_id = inventory.film_id
        LEFT JOIN
    rental ON inventory.inventory_id = rental.inventory_id
        LEFT JOIN
    customer ON rental.customer_id = customer.customer_id
WHERE
    DATEDIFF('2006-02-14', DATE(rental.rental_date)) < 7;

/*richiesta numero5*/
SELECT 
    category.name,
    CAST(AVG(DATEDIFF(rental.return_date, rental.rental_date))
        AS DECIMAL (10 , 2 )) AS media_nolo_giorni
FROM
    rental
        LEFT JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        LEFT JOIN
    film ON inventory.film_id = film.film_id
        LEFT JOIN
    film_category ON film.film_id = film_category.film_id
        LEFT JOIN
    category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY 2 ASC;

/*esercizio6*/
SELECT 
    MAX(DATEDIFF(rental.return_date, rental.rental_date)) AS nolo_piu_lungo_in_giorni
FROM
    rental;

/*PRATICA(2)*/
SELECT DISTINCT
    customer.last_name, customer.first_name
FROM
    customer
        LEFT JOIN
    rental ON customer.customer_id = rental.customer_id
WHERE
    customer.customer_id NOT IN (SELECT 
            rental.customer_id
        FROM
            rental
        WHERE
            rental.rental_date BETWEEN '2006-02-01' AND '2006-02-28')
ORDER BY 1;

/*esercizio2*/
SELECT 
    film.title AS Titolo, COUNT(film.title) numero_noleggi
FROM
    rental
        LEFT JOIN
    inventory ON inventory.inventory_id = rental.inventory_id
        LEFT JOIN
    film ON film.film_id = inventory.film_id
WHERE
    QUARTER(rental.rental_date) = 3
        AND YEAR(rental.rental_date) = 2005
GROUP BY film.title
HAVING numero_noleggi > 10
ORDER BY 2 DESC;

/*esercizio3*/
SELECT 
    COUNT(rental.rental_date) AS numero_noleggi
FROM
    rental
WHERE
    date(rental.rental_date) = '2006-02-14';

/*esercizio4*/
SELECT 
    SUM(payment.amount) AS Incassi_weekend
FROM
    payment
        
WHERE
    DAYNAME(payment.payment_date) = 'saturday'
        OR DAYNAME(payment.payment_date) = 'sunday';
        
 /*esercizio4-metodo2*/
SELECT 
    SUM(AMOUNT) AS TOT_AMOUNT
FROM
    PAYMENT P 
WHERE
    DAYOFWEEK(PAYMENT_DATE) = 1
        OR DAYOFWEEK(PAYMENT_DATE) = 7;

/*esercizio5*/
SELECT 
    customer.customer_id,
    CONCAT(customer.last_name," ",
    customer.first_name) AS nome_cliente,
    SUM(payment.amount) AS spesa_totale
FROM
    customer
        LEFT JOIN
    payment ON customer.customer_id = payment.customer_id
GROUP BY customer_id
HAVING spesa_totale = (SELECT 
        MAX(totale_spesa)
    FROM
        (SELECT 
            customer_id AS codice, SUM(payment.amount) AS totale_spesa
        FROM
            payment
        GROUP BY codice) AS sub);

/*esercizio6*/
SELECT 
    film.title AS titolo,
    CAST(AVG(DATEDIFF(rental.return_date, rental.rental_date))
        AS DECIMAL (10 , 2 )) AS media_nolo_giorni
FROM
    rental
        LEFT JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        LEFT JOIN
    film ON inventory.film_id = film.film_id
        LEFT JOIN
    film_category ON film.film_id = film_category.film_id
GROUP BY titolo
ORDER BY 2 DESC
LIMIT 5;

/*esercizio7*/
SELECT 
    customer.first_name,
    customer.last_name,
    AVG(DATEDIFF(next_rental.rental_date,
            rental.rental_date)) AS Tempo_Medio_Due_Noleggi
FROM
    sakila.customer
        JOIN
    sakila.rental ON customer.customer_id = rental.customer_id
        LEFT JOIN
    sakila.rental AS next_rental ON rental.customer_id = next_rental.customer_id
        AND next_rental.rental_date = (SELECT 
            MIN(nr.rental_date)
        FROM
            sakila.rental nr
        WHERE
            nr.customer_id = rental.customer_id
                AND nr.rental_date > rental.rental_date)
GROUP BY customer.customer_id , customer.first_name , customer.last_name
ORDER BY Tempo_Medio_Due_Noleggi DESC;

/*esercizio8*/
SELECT 
    MONTHNAME(rental.rental_date) AS mese,
    COUNT(rental.rental_date) AS numero_noloXmese
FROM
    rental
WHERE
    YEAR(rental_date) = 2005
GROUP BY mese
ORDER BY 1;

/*esercizio9-metodo1*/
SELECT
f.title film,
date(r.rental_date),
COUNT(r.rental_id) numero_noleggi
FROM
rental r
LEFT JOIN
inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN
film f ON i.film_id = f.film_id
GROUP BY f.title, date(r.rental_date)
HAVING COUNT(r.rental_id) > 1
ORDER BY 3;

/*esercizio9-metondo2*/
SELECT DISTINCT
    Tabella.TitoloFilm
FROM
    (SELECT 
        film.title AS TitoloFilm,
            DATE(rental.rental_date) AS DataNoleggio,
            COUNT(*) AS NumeroNoleggi
    FROM
        film
    LEFT JOIN inventory ON film.film_id = inventory.film_id
    LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
    GROUP BY DataNoleggio , TitoloFilm
    HAVING NumeroNoleggi >= 2) AS Tabella;

/*esercizio10*/
SELECT 
    CAST(AVG(DATEDIFF(rental.return_date, rental.rental_date))
        AS DECIMAL (10,2)) AS media_nolo_giorni
FROM
    rental
        LEFT JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        LEFT JOIN
    film ON inventory.film_id = film.film_id
        LEFT JOIN
    film_category ON film.film_id = film_category.film_id
        LEFT JOIN
    category ON film_category.category_id = category.category_id;