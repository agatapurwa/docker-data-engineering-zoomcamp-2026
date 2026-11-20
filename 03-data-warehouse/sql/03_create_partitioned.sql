-- Create daily partitioned table (timestamps shifted +2830 days for Sandbox 60-day retention)
CREATE OR REPLACE TABLE `gen-lang-client-0109324221.nytaxi.yellow_tripdata_partitioned`
PARTITION BY DATE(pickup_datetime) AS
SELECT
    vendor_id,
    TIMESTAMP_ADD(pickup_datetime, INTERVAL 2830 DAY) AS pickup_datetime,
    TIMESTAMP_ADD(dropoff_datetime, INTERVAL 2830 DAY) AS dropoff_datetime,
    passenger_count,
    trip_distance,
    pickup_location_id,
    dropoff_location_id,
    payment_type,
    fare_amount,
    total_amount
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_non_partitioned`;