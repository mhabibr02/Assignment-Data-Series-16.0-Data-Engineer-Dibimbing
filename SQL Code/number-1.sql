-- query untuk menghitung statistik trip_seconds berdasarkan hari senin dan sabtu
WITH filtered_trips AS (
  SELECT 
    EXTRACT(DAYOFWEEK FROM trip_start_timestamp) AS day_of_week,
    trip_seconds
  FROM 
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE 
    EXTRACT(DAYOFWEEK FROM trip_start_timestamp) IN (2, 7) -- 2=senin, 7=sabtu
    AND trip_seconds IS NOT NULL
), statistics AS (
  SELECT 
    day_of_week,
    AVG(trip_seconds) AS average_duration,
    APPROX_QUANTILES(trip_seconds, 2)[OFFSET(1)] AS median_duration,
    STDDEV(trip_seconds) AS stddev_duration
  FROM 
    filtered_trips
  GROUP BY 
    day_of_week
)
SELECT 
  CASE day_of_week
    WHEN 2 THEN "Monday"
    WHEN 7 THEN "Saturday"
  END AS day_name,
  average_duration,
  median_duration,
  stddev_duration
FROM 
  statistics;
