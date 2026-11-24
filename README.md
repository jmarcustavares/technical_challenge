# Data Analyst Exercise: Newark Airport (EWR)

Analysis of Newark Liberty International Airport (EWR) using the NYC flights datasets
(`nyc_airlines`, `nyc_airports`, `nyc_flights`, `nyc_planes`, `nyc_weather`).

## Status

| # | Question | Status |
|---|----------|--------|
| 1 | Distinct destinations connected to the airport 
| 2 | Rounded average of distinct destinations per day 
| 5 | Month with the highest accumulated departure delay 

## Repository structure

```
.
├── README.md
├── requirements.txt
├── sql/
│   ├── q01_distinct_destinations.sql
│   ├── q02_avg_daily_destinations.sql
│   └── q05_month_highest_departure_delay.sql
            
```

## Approach and assumptions

All queries filter on `origin = 'EWR'`, since the analysis is about Newark Airport.
`nyc_flight_fixed` is the name of the flights table in the tool I used; it is the
`nyc_flights` data with the date and time columns in usable types.

- **Q1:** `COUNT(DISTINCT dest)` over EWR departures.
- **Q2:** For each calendar day, count the distinct destinations. Then average
  those daily counts and round to 2 decimals.
- **Q5:** Sum `dep_delay` by month of the year. Early departures (negative values)
  are included in the sum, and missing values (cancelled flights) count as 0.
  The first row of the result is the answer.

## Running the queries with DuckDB

The queries are standard SQL, so they run almost unchanged on
[DuckDB](https://duckdb.org/), directly from Python or the terminal, with no
database server.

```bash
pip install -r requirements.txt

# put nyc_flights.csv in data/, then:
python run_queries.py                     # all queries
python run_queries.py sql/q01_*.sql       # a single query
python run_queries.py --csv path/to/nyc_flights.csv
```

`run_queries.py` creates a view called `nyc_flight_fixed` on top of the CSV,
so the SQL files work as they are. The same thing in a few lines of Python:

```python
import duckdb

con = duckdb.connect()
con.execute("CREATE VIEW nyc_flight_fixed AS SELECT * FROM read_csv_auto('data/nyc_flights.csv')")
print(con.execute(open("sql/q01_distinct_destinations.sql").read()).fetchdf())
```
