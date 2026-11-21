-- Query 1A: Non-partitioned table scan (80.74 MB processed)
SELECT DISTINCT(vendor_id)
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_non_partitioned`
WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2019-01-10';

-- Query 1B: Partitioned table scan with partition pruning (24.1 MB processed)
SELECT DISTINCT(vendor_id)
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_partitioned`
WHERE DATE(pickup_datetime) BETWEEN '2026-10-01' AND '2026-10-10';