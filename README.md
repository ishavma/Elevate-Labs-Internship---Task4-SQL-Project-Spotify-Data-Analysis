
# Spotify Data Analysis Project

Overview

This project explores the Spotify (Chinook) music database using SQL queries to answer key business questions related to customers, invoices, artists, and genres.
The goal is to extract meaningful insights that can help understand customer behavior, top-performing artists, and revenue trends across countries.

Dataset Description

The dataset contains multiple related tables, including:

Customer – Customer details (name, email, country)

Invoice – Billing information for music purchases

Invoice_line – Detailed information about purchased tracks

Track – Information about each music track

Album – Album details for each track

Artist – Artist information

Genre – Music genre classification

Employee – Company employee hierarchy

Project Objectives & Key Questions

1	Who is the senior-most employee based on job title?	Identify top-level management
2	Which country has the most invoices?	Find the country with maximum transactions
3	What are the top 3 highest invoice totals?	Analyze high-value transactions
4	Which city has the best customers?	Identify the city with maximum sales revenue
5	Who is the best customer?	Find the highest-spending customer
6	Which customers listen to Rock music?	Identify customers who purchased Rock tracks
7	Which artists have written the most Rock songs?	Rank top Rock artists by song count
8	What is the most popular genre in each country?	Discover regional music preferences
9	Who is the top customer in each country?	Identify highest spenders by country
10	How much does each customer spend on top artists?	Analyze customer spending by artist

SQL Queries & Logic Summary

Each query follows a clear analytical flow:

SELECT – Choose relevant columns.

FROM / JOIN – Combine related tables.

WHERE – Apply conditions.

GROUP BY – Aggregate results by category.

ORDER BY – Sort results.

LIMIT – Restrict output to top results.

Example:

SELECT billing_country, COUNT(*) AS invoice_count
FROM invoice
GROUP BY billing_country
ORDER BY invoice_count DESC
LIMIT 1;

Key Insights

Senior-most employee: Andrew Adams – General Manager

Country with most invoices: USA (131 invoices)

Top 3 Invoice Totals: 23.76 (France), 19.8 (Canada), 19.8 (Czech Republic)

Best city (highest sales): Prague (Total = 273.24)

Best customer: František Wichterlová – Total spend 144.54

Top Rock Artists: AC/DC, Aerosmith, Audioslave

Most popular genre by country: Rock dominates across most countries

Top customer per country: Varies, e.g. Manoj Pareek (India – ₹111.86)

Top artist by total sales: AC/DC

Top customer for AC/DC music: Steve Murray – $17.82 spent

Business Insights

Rock music dominates globally, especially in North America and Europe.

AC/DC is the top-selling artist, contributing significantly to total sales.

USA leads in total invoices and customer volume.

Target cities like Prague and Paris show high sales potential — suitable for focused marketing campaigns.

High-value customers like František Wichterlová and Steve Murray can be included in loyalty or VIP programs.

