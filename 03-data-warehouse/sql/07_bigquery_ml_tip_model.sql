-- 1. Create Sandbox-sized ML feature table (~450 MB from Jan 2019)
CREATE OR REPLACE TABLE `gen-lang-client-0109324221.nytaxi.yellow_tripdata_ml` AS
SELECT
    passenger_count,
    CAST(trip_distance AS FLOAT64) AS trip_distance,
    CAST(pickup_location_id AS STRING) AS PULocationID,
    CAST(dropoff_location_id AS STRING) AS DOLocationID,
    CAST(payment_type AS STRING) AS payment_type,
    CAST(fare_amount AS FLOAT64) AS fare_amount,
    CAST(tolls_amount AS FLOAT64) AS tolls_amount,
    CAST(tip_amount AS FLOAT64) AS tip_amount
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`
WHERE pickup_datetime >= '2019-01-01'
  AND pickup_datetime < '2019-02-01'
  AND fare_amount != 0
  AND tip_amount IS NOT NULL;

-- 2. Train baseline Linear Regression model (~0.45 GB CREATE MODEL quota)
CREATE OR REPLACE MODEL `gen-lang-client-0109324221.nytaxi.tip_model`
OPTIONS (
    model_type = 'linear_reg',
    input_label_cols = ['tip_amount'],
    DATA_SPLIT_METHOD = 'AUTO_SPLIT'
) AS
SELECT *
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_ml`;

-- 3. Inspect standardized numeric stats and categorical counts
SELECT *
FROM ML.FEATURE_INFO(MODEL `gen-lang-client-0109324221.nytaxi.tip_model`);

-- 4. Evaluate baseline model (MAE, MSE, R2)
SELECT *
FROM ML.EVALUATE(
    MODEL `gen-lang-client-0109324221.nytaxi.tip_model`,
    (SELECT * FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_ml`)
);

-- 5. Preview batch predictions (predicted_tip_amount vs actual tip_amount)
SELECT *
FROM ML.PREDICT(
    MODEL `gen-lang-client-0109324221.nytaxi.tip_model`,
    (SELECT * FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_ml` LIMIT 100)
);

-- 6. Explain top 3 driving features per prediction
SELECT *
FROM ML.EXPLAIN_PREDICT(
    MODEL `gen-lang-client-0109324221.nytaxi.tip_model`,
    (SELECT * FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_ml` LIMIT 100),
    STRUCT(3 AS top_k_features)
);

-- 7. Hyperparameter tuning with L1/L2 regularization (~2.25 GB CREATE MODEL quota)
CREATE OR REPLACE MODEL `gen-lang-client-0109324221.nytaxi.tip_hyperparam_model`
OPTIONS (
    model_type = 'linear_reg',
    input_label_cols = ['tip_amount'],
    DATA_SPLIT_METHOD = 'AUTO_SPLIT',
    num_trials = 5,
    max_parallel_trials = 2,
    l1_reg = hparam_range(0, 20),
    l2_reg = hparam_candidates([0, 0.1, 1, 10])
) AS
SELECT *
FROM `gen-lang-client-0109324221.nytaxi.yellow_tripdata_ml`;