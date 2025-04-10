-- query untuk membandingkan biaya rata-rata berdasarkan metode pembayaran
SELECT 
  payment_type,
  AVG(fare) AS avg_fare,
  AVG(tips) AS avg_tips,
  AVG(tolls) AS avg_tolls,
  AVG(extras) AS avg_extras
FROM 
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE 
  EXTRACT(YEAR FROM trip_start_timestamp) = 2019
GROUP BY 
  payment_type
ORDER BY 
  payment_type;