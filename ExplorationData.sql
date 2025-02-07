SELECT * FROM GoogleDA1.dbo.[TripData_20232024]
ORDER BY Total_Cycling_Time DESC;

-- Check the unique value in col ride_id = 188
SELECT 
    COUNT(*) AS duplicate_count
FROM (
    SELECT 
        ride_id
    FROM GoogleDA1.dbo.[TripData_20232024]
    GROUP BY ride_id
    HAVING COUNT(ride_id) > 1
) AS duplicates;

-- CREATE NEW COLUMN NAME 'Total_Cycling_Time'
ALTER TABLE TripData_20232024
ADD Total_Cycling_Time FLOAT

-- UPDATE VALUE FOR Total_Cycling_Time
UPDATE GoogleDA1.dbo.[TripData_20232024]
SET Total_Cycling_Time = DATEDIFF(SECOND, started_at, ended_at) / 3600.0);


-- DROP 2 COLUMNS 'started_at' + 'ended_at'
ALTER TABLE TripData_20232024
DROP COLUMN started_at;

ALTER TABLE TripData_20232024
DROP COLUMN ended_at

-- DELETE 'Unknown' value in 'start_station_name' & 'start_station_name'
DELETE FROM TripData_20232024
WHERE start_station_name = 'Unknown' OR start_station_name = 'Unknown';


-- RENAME 'hour' -> 'hour_start'
EXEC sp_rename 'TripData_20232024.hour', 'hour_start', 'COLUMN';

-- RIDER BY MEMBER AND CASUAL USERS
SELECT
COUNT(ride_id) AS no_of_riders, member_casual
FROM TripData_20232024
GROUP BY member_casual

SELECT TOP 100 * FROM GoogleDA1.dbo.TripData_20232024;

-- Tổng số người đạp xe theo Member Casual
SELECT 
	member_casual,
	COUNT(*) AS total_rides
FROM 
	GoogleDA1.dbo.TripData_20232024
GROUP BY 
    member_casual

-- Tổng số người đạp xe
SELECT 
    'Total Riders' AS member_casual,
    COUNT(*) AS total_rides
FROM 
    GoogleDA1.dbo.TripData_20232024;

-- Tổng quan số chuyến đi theo tháng
SELECT 
    year,
    month,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY year, month
ORDER BY year, month;

-- Số chuyến đi theo ngày trong tuần
SELECT 
    day_of_week,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY day_of_week
ORDER BY day_of_week;

-- Số chuyến đi nhiều nhất giờ cao điểm
SELECT TOP 3
    hour_start,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY hour_start
ORDER BY total_rides DESC;

-- Phân loại thời lượng chuyến đi
SELECT 
    ride_length_category,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY ride_length_category
ORDER BY total_rides DESC;

-- Khoảng cách trung bình theo loại người dùng
SELECT 
    member_casual,
    AVG(distance_km) AS avg_distance_km
FROM TripData_20232024
GROUP BY member_casual;

-- Thời lượng trung bình chuyến đi theo loại người dùng
SELECT 
    member_casual,
    AVG(ride_length) AS avg_ride_length_minutes
FROM TripData_20232024
GROUP BY member_casual;

-- Các trạm khởi hành phổ biến nhất
SELECT TOP 3
    start_station_name,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY start_station_name
ORDER BY total_rides DESC;

-- Các trạm kết thúc phổ biến nhất
SELECT TOP 2
    end_station_name,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY end_station_name
ORDER BY total_rides DESC

-- Khoảng cách trung bình theo tháng
SELECT 
    year,
    month,
    AVG(distance_km) AS avg_distance_km
FROM TripData_20232024
GROUP BY year, month
ORDER BY year, month;

-- Tỉ lệ người dùng casual và member theo ngày trong tuần
SELECT 
    day_of_week,
    member_casual,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY day_of_week, member_casual
ORDER BY day_of_week, member_casual;

-- Phân tích thời gian cao điểm theo loại người dùng
SELECT 
    hour_start,
    member_casual,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY hour_start, member_casual
ORDER BY hour_start, member_casual;

-- Thống kê số chuyến đi theo loại xe đạp
SELECT 
    rideable_type,
    COUNT(*) AS total_rides
FROM TripData_20232024
GROUP BY rideable_type
ORDER BY total_rides DESC;

-- Phân tích chuyến đi dài nhất
SELECT TOP 3
    ride_id, 
    start_station_name, 
    end_station_name, 
    ride_length, 
    distance_km, 
    member_casual
FROM TripData_20232024
ORDER BY ride_length DESC

