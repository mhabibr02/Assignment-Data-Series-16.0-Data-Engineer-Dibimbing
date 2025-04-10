-- query untuk menemukan lima rute dengan perjalanan terbanyak
WITH trips_2023 AS (
  SELECT 
    pickup_community_area,
    dropoff_community_area,
    COUNT(*) AS trip_count
  FROM 
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE 
    EXTRACT(YEAR FROM trip_start_timestamp) = 2023
    AND pickup_community_area IS NOT NULL
    AND dropoff_community_area IS NOT NULL
  GROUP BY 
    pickup_community_area, dropoff_community_area
)
SELECT 
  pickup_community_area,
  dropoff_community_area,
  trip_count
FROM 
  trips_2023
ORDER BY 
  trip_count DESC
LIMIT 5;