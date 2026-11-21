-- Create partitioned and clustered table (partitioned by pickup date, clustered by vendor_id)
CREATE OR REPLACE TABLE `gen-lang-client-0109324221.nytaxi.yellow_tripdata_partitioned_clustered`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY vendor_id AS
SELECT *
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_partitioned`;