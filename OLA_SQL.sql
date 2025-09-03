CREATE DATABASE ola;
CREATE TABLE ola(
Date DATE,
Time TIME,
Booking_ID VARCHAR(50),
Booking_Status VARCHAR(100),
Customer_ID VARCHAR(50),
Vehicle_Type VARCHAR(100),
Pickup_Location VARCHAR(100),
Drop_Location VARCHAR(100),
V_TAT INTEGER,
C_TAT INTEGER,
Canceled_Rides_by_Customer VARCHAR(200),
Canceled_Rides_by_Driver  VARCHAR(200),
Incomplete_Rides  VARCHAR(5),
Incomplete_Rides_Reason  VARCHAR(100),
Booking_Value INTEGER,
Payment_Method  VARCHAR(15),
Ride_Distance INTEGER,
Driver_Ratings FLOAT,
Customer_Rating FLOAT
);

SELECT*FROM ola;

--1.Retrive all successful bookings
CREATE VIEW successful_bookings AS
SELECT * 
FROM ola
WHERE booking_status= 'Success';

SELECT *FROM successful_bookings;

--2.Average ride distance for each vehicle type
CREATE VIEW ride_distence_per_vehicle_type AS 
SELECT vehicle_type,AVG(ride_distance) 
FROM ola
GROUP BY vehicle_type;

SELECT *FROM ride_distence_per_vehicle_type;

--3.Get the total number of rides canceled by customer
CREATE VIEW total_canceled_rides_by customer AS
SELECT COUNT(*)
FROM ola
WHERE booking_status='Canceled by Customer';

SELECT *FROM total_canceled_rides_by customer;

--4.List the top 5 customers who have booked the heighest number of rides
CREATE VIEW top_5_customers_with_higher_bookings AS
SELECT customer_id,COUNT(booking_id) AS total_bookings
FROM ola
GROUP BY customer_id
ORDER BY COUNT(booking_id) DESC
LIMIT 5;

SELECT *FROM top_5_customers_with_higher_bookings;

--5.Get the number of rides cancelled by drivers due to personal and car related issues
CREATE VIEW rides_cancele_by_drivers AS
SELECT* FROM ola
WHERE canceled_rides_by_driver='Personal & Car related issue';

SELECT*FROM rides_cancele_by_drivers;

--6.Find the max and min drive rating for prime sedan bookings
CREATE VIEW max_min_driver_ratings AS 
SELECT MAX(driver_ratings) AS Max_rating,
MIN(driver_ratings) AS Min_rating
FROM ola
WHERE vehicle_type='Prime Sedan';

SELECT * FROM max_min_driver_ratings;

--7.Retrive all rides where payment was upi
CREATE VIEW UPI_payments AS 
SELECT * FROM ola
WHERE payment_method='UPI';

SELECT* FROM UPI_payments;

--8.List all incomplete rides along with the reason
CREATE VIEW incomplete_ride_reasons AS
SELECT booking_id,incomplete_rides_reason FROM ola
WHERE incomplete_rides='Yes';

SELECT*FROM incomplete_ride_reasons;

--9.Cancellation analysis
CREATE VIEW cancellation_analysis AS 
SELECT pickup_location,
COUNT((CASE WHEN booking_status='Canceled by Customer' THEN 1 END)*100.0)/COUNT(*) AS customer_cancelation_rate
FROM ola
GROUP BY pickup_location
ORDER BY customer_cancelation_rate DESC
LIMIT 3;

SELECT*FROM cancellation_analysis;

--10.Performance for top drivers
CREATE VIEW top_performance AS
SELECT 
	vehicle_type,
	count(*) AS Total_count,
	AVG(driver_ratings) AS avg_driver_ratings
FROM ola
GROUP BY vehicle_type
ORDER BY COUNT(*) DESC
LIMIT 5;

SELECT*FROM top_performance;

--11.Ride value vs distance analysis
CREATE VIEW ride_vlue_vs_distance_analysis AS
SELECT 
	vehicle_type,
	AVG(booking_value/ride_distance) AS Avg_value_per_km
FROM ola
WHERE booking_status='Success' AND ride_distance >10
GROUP BY vehicle_type
ORDER BY Avg_value_per_km DESC;

SELECT*FROM ride_vlue_vs_distance_analysis;





