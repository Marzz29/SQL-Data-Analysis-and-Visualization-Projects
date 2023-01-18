/*Select all columns from the tables to ensure the data imported correctly*/
SELECT *
FROM HotelBookings..[2018Booking]

SELECT *
FROM HotelBookings..[2019Booking]

SELECT *
FROM HotelBookings..[2020Booking]

SELECT *
FROM HotelBookings..market_segment

SELECT *
FROM HotelBookings..meal_cost

/* Use the union clause to combine 2018, 2019, and 2020 booking data into one unified dataset.
Create a temporary table with the with statement to perform exploratory data analysis on the unified dataset */

WITH Hotels AS (
SELECT *, 
	adults + children + babies AS Total_guests,
	stays_in_weekend_nights + stays_in_week_nights AS Total_stays_in_hotel,
	(stays_in_weekend_nights + stays_in_week_nights)* adr AS Revenue
FROM dbo.[2018Booking]
UNION
SELECT *,
	adults + children + babies AS Total_guests,
	stays_in_weekend_nights + stays_in_week_nights AS Total_stays_in_hotel,
	(stays_in_weekend_nights + stays_in_week_nights)* adr AS Revenue
FROM dbo.[2019Booking]
UNION
SELECT *,
	adults + children + babies AS Total_guests,
	stays_in_weekend_nights + stays_in_week_nights AS Total_stays_in_hotel,
	(stays_in_weekend_nights + stays_in_week_nights)* adr AS Revenue
FROM dbo.[2020Booking])

SELECT *
FROM Hotels
LEFT JOIN dbo.market_segment
ON Hotels.market_segment = market_segment.market_segment
LEFT JOIN dbo.meal_cost
ON Hotels.meal = meal_cost.meal

/* Use the COUNT and GROUP BY function to explore the number of guests that booked the different hotels*/
SELECT hotel AS hotel_type, COUNT(hotel) AS hotel_count
FROM Hotels
GROUP BY hotel

/* Use the COUNT and GROUP BY function to see how many guests canceled their trip*/
SELECT hotel, is_canceled, COUNT(is_canceled) AS cancellation
FROM Hotels
GROUP BY hotel, is_canceled

/*A query that finds out which month has the highest amount of bookings that did not cancel*/
SELECT hotel, arrival_date_month, COUNT(arrival_date_month) AS Amount_of_guests
FROM Hotels
WHERE is_canceled != 1
GROUP BY hotel, arrival_date_month
ORDER BY Amount_of_guests DESC

/* A query that finds out the number of days that elapsed between entering the date of booking and the arrival date for each year*/
SELECT arrival_date_year, ROUND(AVG(lead_time), 0) AS Avg_lead_time
FROM Hotels
GROUP BY arrival_date_year

/*A query that retrieves the meal types, the number of guests who ordered them, and the revenue from each meal type*/
SELECT H.meal, Cost, COUNT(H.meal) AS number_of_guests, COUNT(H.meal)* Cost AS MealType_Revenue
FROM Hotels AS H
JOIN meal_cost As M
ON H.meal = M.meal
GROUP BY H.meal, Cost
ORDER BY MealType_Revenue DESC

/*A query that shows how many guests book from different market segments */
SELECT market_segment, COUNT(market_segment) AS Number_of_guests
FROM Hotels
WHERE is_canceled != 1
GROUP BY market_segment
ORDER BY Number_of_guests DESC

/* Number of guests who had their rooms changed*/
SELECT  COUNT(hotel) AS Number_of_changed_rooms
FROM Hotels
WHERE reserved_room_type != assigned_room_type
	AND is_canceled != 1

/* ID of Travel agency that made the most booking of guests who did not cancel*/
SELECT agent, COUNT(agent) AS Number_of_bookings_made
FROM Hotels
WHERE is_canceled != 1
GROUP BY agent
ORDER BY Number_of_bookings_made DESC 

/* Total people who made a booking*/
SELECT *, adults + children + babies AS Total_guests
FROM Hotels
/* Total stays in hotel*/ 
SELECT *, stays_in_weekend_nights + Stays_in_week_nights AS Total_stays_in_hotel
FROM Hotels
/* Revenue from each stay*/
SELECT
arrival_date_year,
(stays_in_weekend_nights + stays_in_week_nights) * adr AS Revenue
FROM Hotels
WHERE arrival_date_year = 2020



