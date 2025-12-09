WITH Aggregates AS (
    SELECT
        System.Timestamp AS windowEndTime,
        location,
        AVG(ice_thickness_cm) AS avgIceThickness,
        MIN(ice_thickness_cm) AS minIceThickness,
        MAX(ice_thickness_cm) AS maxIceThickness,
        AVG(surface_temperature_c) AS avgSurfaceTemperature,
        MIN(surface_temperature_c) AS minSurfaceTemperature,
        MAX(surface_temperature_c) AS maxSurfaceTemperature,
        MAX(snow_accumulation_cm) AS maxSnowAccumulation,
        AVG(external_temperature_c) AS avgExternalTemp,
        COUNT(*) AS readingCount
    FROM cst8916finalprojecthub TIMESTAMP BY timestamp
    GROUP BY
        location,
        TumblingWindow(minute, 5)
)

SELECT
    *,
    CASE
        WHEN avgIceThickness >= 30 AND avgSurfaceTemperature <= -2 THEN 'Safe'
        WHEN avgIceThickness >= 25 AND avgSurfaceTemperature <= 0 THEN 'Caution'
        ELSE 'Unsafe'
    END AS safetyStatus,
    CAST(location AS NVARCHAR(MAX)) + '-' + SUBSTRING(CAST(windowEndTime AS NVARCHAR(MAX)),1,19) + 'Z' AS id
INTO SensorAggregations
FROM Aggregates;

-- Also output to blob
SELECT *
INTO historicaldata
FROM Aggregates;