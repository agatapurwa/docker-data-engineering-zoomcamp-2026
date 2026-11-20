-- Create baseline non-partitioned table (January 2019 scope for BigQuery Sandbox)
CREATE OR REPLACE TABLE `gen-lang-client-0109324221.nytaxi.yellow_tripdata_non_partitioned` AS
SELECT
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    pickup_location_id,
    dropoff_location_id,
    payment_type,
    fare_amount,
    total_amount
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`
WHERE pickup_datetime >= '2019-01-01'
  AND pickup_datetime < '2019-02-01';