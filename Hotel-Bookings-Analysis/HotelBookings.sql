--Select all columns from the tables to ensure the data imported correctly
--SELECT *
--FROM HotelBookings..[2018Booking]

--SELECT *
--FROM HotelBookings..[2019Booking]

--SELECT *
--FROM HotelBookings..[2020Booking]

--SELECT *
--FROM HotelBookings..market_segment

--SELECT *
--FROM HotelBookings..meal_cost

/* Use the union clause to combine 2018, 2019, and 2020 booking data into one unified dataset.
Create a temporary table with the with statement to perform exploratory data analysis on the unified dataset */

WITH Hotels AS (
SELECT *
FROM dbo.[2018Booking]
UNION
SELECT *
FROM dbo.[2019Booking]
UNION
SELECT *
FROM dbo.[2020Booking])

