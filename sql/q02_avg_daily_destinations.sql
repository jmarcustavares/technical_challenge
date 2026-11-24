
WITH daily AS (
    SELECT
        make_date(year, month, day) AS flight_date,
        COUNT(DISTINCT dest)        AS distinct_destinations
    FROM nyc_flight_fixed
    WHERE origin = 'EWR'
    GROUP BY flight_date
)
SELECT ROUND(AVG(distinct_destinations), 2) AS avg_daily_destinations
FROM daily;
