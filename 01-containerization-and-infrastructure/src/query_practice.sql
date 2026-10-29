WITH daily_borough_stats AS (
    SELECT 
        DATE(t.tpep_pickup_datetime) AS pickup_date,
        COALESCE(z."Borough", 'Unknown') AS pickup_borough,
        COUNT(1) AS total_trips,
        ROUND(SUM(t.total_amount)::numeric, 2) AS total_revenue
    FROM yellow_taxi_trips_2021_1 t
    LEFT JOIN zones z 
        ON t."PULocationID" = z."LocationID"
    GROUP BY 
        DATE(t.tpep_pickup_datetime),
        COALESCE(z."Borough", 'Unknown')
)
SELECT 
    pickup_date,
    pickup_borough,
    total_trips,
    total_revenue,
    
    -- Retrieving the total_revenue for the following day in the same borough
    LAG(total_revenue, 1) OVER (
        PARTITION BY pickup_borough 
        ORDER BY pickup_date
    ) AS prev_day_revenue,

    -- Retrieving the total_revenue for the following day in the same borough
    LEAD(total_revenue, 1) OVER (
        PARTITION BY pickup_borough 
        ORDER BY pickup_date
    ) AS next_day_revenue,

    -- Calculating the change in daily revenue compared to the previous day
    ROUND(
        (total_revenue - LAG(total_revenue, 1) OVER (
            PARTITION BY pickup_borough 
            ORDER BY pickup_date
        ))::numeric, 2
    ) AS daily_revenue_change

FROM daily_borough_stats
WHERE pickup_date BETWEEN '2021-01-01' AND '2021-01-31'
ORDER BY 
    pickup_borough, 
    pickup_date;