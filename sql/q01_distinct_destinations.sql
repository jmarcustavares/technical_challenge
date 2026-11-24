
SELECT COUNT(DISTINCT dest) AS distinct_destinations
FROM nyc_flight_fixed
WHERE origin = 'EWR';
