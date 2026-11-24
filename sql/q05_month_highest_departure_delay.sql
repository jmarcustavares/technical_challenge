
SELECT
    EXTRACT(MONTH FROM time_hour)    AS  month_number,
    SUM(dep_delay)    AS total_delay
FROM nyc_flight_fixed
WHERE origin = 'EWR'
GROUP BY 1
ORDER BY total_delay DESC;
