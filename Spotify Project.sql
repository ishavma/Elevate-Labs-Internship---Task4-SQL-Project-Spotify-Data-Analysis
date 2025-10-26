# 1. Who is the senior most employee based on job title?

SELECT title ,first_name,last_name,levels,email FROM employee
ORDER BY levels DESC
LIMIT 1;


# 2. Which countries have the most Invoices?

SELECT billing_country,count(*) as count FROM invoice
GROUP BY billing_country
ORDER BY count Desc
limit 1;


# 3. What are top 3 values of total invoice?

SELECT * FROM invoice
ORDER BY total DESC
LIMIT 3;


# 4. Which city has the best customers?

SELECT billing_city,sum(total) as Total_Amount FROM invoice
GROUP BY billing_city
ORDER BY Total_Amount DESC
LIMIT 1 ;


# 5. Who is the best customer?

SELECT customer.customer_id,first_name,last_name,
email,sum(total) AS Total_Amount FROM customer
JOIN invoice 
ON customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id,first_name,last_name,email
ORDER BY Total_Amount DESC
LIMIT 1;


# 6. Details of customers who listen Rock music.

SELECT distinct first_name,last_name,email FROM customer
JOIN invoice 
ON customer.customer_id=invoice.customer_id
JOIN invoice_line
ON invoice.invoice_id=invoice_line.invoice_id
WHERE track_id IN ( 
		SELECT track_id FROM track
		JOIN genre
		ON track.genre_id=genre.genre_id
		WHERE genre.name LIKE "Rock"
);


# 7. Let's invite the artists who have written the most rock music in our dataset.

SELECT artist.artist_id,artist.name AS Artist_Name,genre.name AS genre,count(artist.artist_id) AS No_Of_Songs FROM artist
JOIN album
ON artist.artist_id = album.artist_id
JOIN track
ON album.album_id = track.album_id
JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name like "Rock"
GROUP BY artist.artist_id,artist.name,genre.name
ORDER BY No_Of_Songs DESC
LIMIT 3 ;


# 8. We want to find out the most popular music Genre for each country.

With popular_genre AS
(SELECT invoice.billing_country,count(invoice_line.quantity) AS Quantity,genre.name AS genre,
    ROW_NUMBER() OVER(PARTITION BY invoice.billing_country ORDER BY count(invoice_line.quantity) DESC ) AS row_num 
FROM invoice_line
       JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
       JOIN customer ON customer.customer_id=invoice.customer_id
       JOIN track ON track.track_id = invoice_line.track_id
       JOIN genre ON genre.genre_id = track.genre_id
GROUP BY 1,3
ORDER BY 2 DESC)
SELECT * FROM popular_genre WHERE row_num <=1;


# 9. Determine which customer has spent the most on music for each country.

WITH TOP_COUNTRY_CUSTOMER AS
(SELECT customer.customer_id,first_name,last_name,email,
billing_country AS country,sum(total) AS total_amount,
ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY sum(total) DESC) AS row_num
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY 1,2,3,4,5
ORDER BY 5)
SELECT * FROM TOP_COUNTRY_CUSTOMER WHERE row_num = 1;


# Assignment Question :- Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent.

WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1,2
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;




  





