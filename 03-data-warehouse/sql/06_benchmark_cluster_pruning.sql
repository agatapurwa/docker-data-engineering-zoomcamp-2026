-- Query 2A: Partitioned table only (reads all records across matching date partitions)
SELECT
    COUNT(*) AS total_trips,
    ROUND(AVG(trip_distance), 2) AS avg_distance,
    ROUND(SUM(total_amount), 2) AS revenue
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_partitioned`
WHERE DATE(pickup_datetime) BETWEEN '2026-10-01' AND '2026-10-15'
  AND vendor_id = '1';

-- Query 2B: Partitioned + Clustered table (prunes non-matching vendor_id blocks inside partitions)
SELECT
    COUNT(*) AS total_trips,
    ROUND(AVG(trip_distance), 2) AS avg_distance,
    ROUND(SUM(total_amount), 2) AS revenue
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_partitioned_clustered`
WHERE DATE(pickup_datetime) BETWEEN '2026-10-01' AND '2026-10-15'
  AND vendor_id = '1';