-- 1. Zero-byte metadata check across all tables and partitions in nytaxi
SELECT
    table_name,
    partition_id,
    total_rows,
    total_logical_bytes
FROM `gen-lang-client-0109324221.nytaxi.INFORMATION_SCHEMA.PARTITIONS`
ORDER BY table_name, total_rows DESC
LIMIT 20;

-- 2. Daily trip count check on the non-partitioned baseline table
SELECT
    DATE(pickup_datetime) AS trip_date,
    COUNT(*) AS total_rows
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_non_partitioned`
GROUP BY 1
ORDER BY 1
LIMIT 10;