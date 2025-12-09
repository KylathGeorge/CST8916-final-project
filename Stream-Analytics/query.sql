-- Create a table called "Aggregates" that computes average, min, max ice thickness and surface temperature,
-- as well as max snow accumulation and average external temperature over a 5-minute tumbling window
WITH Aggregates AS (
    SELECT
        -- End time of the tumbling window
        System.Timestamp AS windowEndTime,
        -- Grouping by sensor location
        location,
        -- Calculating the maximum, minimum, and average values for the telemetry
        AVG(ice_thickness_cm) AS avgIceThickness,
        MIN(ice_thickness_cm) AS minIceThickness,
        MAX(ice_thickness_cm) AS maxIceThickness,
        AVG(surface_temperature_c) AS avgSurfaceTemperature,
        MIN(surface_temperature_c) AS minSurfaceTemperature,
        MAX(surface_temperature_c) AS maxSurfaceTemperature,
        MAX(snow_accumulation_cm) AS maxSnowAccumulation,
        AVG(external_temperature_c) AS avgExternalTemp,
        -- Count of readings in the window
        COUNT(*) AS readingCount
    -- Source data from the IoT Hub input
    FROM cst8916finalprojecthub TIMESTAMP BY timestamp
    -- Group by location and 5-minute tumbling window
    GROUP BY
        location,
        TumblingWindow(minute, 5)
)
-- Output the results to a new table called "SensorAggregations" with safety status and unique ID
SELECT
    *,
    CASE
        WHEN avgIceThickness >= 30 AND avgSurfaceTemperature <= -2 THEN 'Safe'
        WHEN avgIceThickness >= 25 AND avgSurfaceTemperature <= 0 THEN 'Caution'
        ELSE 'Unsafe'
    END AS safetyStatus,
    -- This creates the unique ID by combining location and window end time as requirements specify
    CAST(location AS NVARCHAR(MAX)) + '-' + SUBSTRING(CAST(windowEndTime AS NVARCHAR(MAX)),1,19) + 'Z' AS id
INTO SensorAggregations
FROM Aggregates;

-- Also output to blob
SELECT *
INTO historicaldata
FROM Aggregates;