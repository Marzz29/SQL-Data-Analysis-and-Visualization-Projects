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
/* Use the distinct function to explore the unique values in each column*/
--SELECT DISTINCT hotel 
--SELECT DISTINCT is_canceled
--SELECT DISTINCT meal
--SELECT DISTINCT country
--SELECT DISTINCT market_segment
SELECT DISTINCT distribution_channel
--SELECT DISTINCT is_repeated_guest
--SELECT DISTINCT previous_cancellations
--SELECT DISTINCT previous_bookings_not_canceled
--SELECT DISTINCT reserved_room_type
--SELECT DISTINCT assigned_room_type
--SELECT DISTINCT booking_changes
--SELECT DISTINCT deposit_type
--SELECT DISTINCT agent
--SELECT DISTINCT company
--SELECT DISTINCT customer_type
--SELECT DISTINCT required_car_parking_spaces
--SELECT DISTINCT total_of_special_requests
--SELECT DISTINCT reservation_status
FROM Hotels