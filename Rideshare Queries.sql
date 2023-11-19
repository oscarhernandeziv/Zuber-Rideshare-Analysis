/* AUTHOR   - Oscar Hernandez
 Tool Used  - PostgreSQL
 Since the data for the project is located within the TripleTen interface, the SQL will be executed on the TripleTen website interface.
 Created on - Sept-2023 */

--------------------------------------------------------------------------
-- Analysis Questions --
-------------------------------------------------------------------------

/* --------- QUESTION 1 --------- */

/* Print the company_name field. Find the number of taxi rides for each taxi company for November 15-16, 2017, name the resulting field trips_amount and print it, too. Sort the results by the trips_amount field in descending order. */

/* --------- SOLUTION 1 --------- */

SELECT
    cabs.company_name AS company_name, --Prints each cab company's name
    COUNT(trips.trip_id) AS trips_amount --Prints the total # trips for each cab company that satisfy the conditions below
FROM
    trips
    INNER JOIN cabs ON cabs.cab_id = trips.cab_id --Joins the trips and cabs tables by their shared cab IDs
WHERE
    trips.start_ts::date BETWEEN '2017-11-15'
    AND '2017-11-16' --Limits the table to only trips taken between 11/15/17 and 11/16/17
GROUP BY
    cabs.company_name --Groups the data by the cab company names
ORDER BY
    trips_amount DESC; --Sorts the data in descending order by the total # of trips for each cab company

/* --------- QUESTION 2 --------- */

/* Find the number of rides for every taxi companies whose name contains the words "Yellow" or "Blue" for November 1-7, 2017. Name the resulting variable trips_amount. Group the results by the company_name field. */

/* --------- SOLUTION 2 --------- */

SELECT --This query compiles the # of trips between 11/1/17 and 11/7/17 for each cab company whose name contains the word "Yellow"
    cabs.company_name AS company_name,
    COUNT(trips.trip_id) AS trips_amount
FROM
    trips
    INNER JOIN cabs ON cabs.cab_id = trips.cab_id
WHERE
    trips.start_ts::date BETWEEN '2017-11-01'
    AND '2017-11-07'
    AND cabs.company_name LIKE '%Yellow%'
GROUP BY
    cabs.company_name 

UNION ALL --This joins the above query with the below query into one table

SELECT --This query compiles the # of trips between 11/1/17 and 11/7/17 for each cab company whose name contains the word "Blue"
    cabs.company_name AS company_name,
    COUNT(trips.trip_id) AS trips_amount
FROM
    trips
    INNER JOIN cabs ON cabs.cab_id = trips.cab_id
WHERE
    trips.start_ts::date BETWEEN '2017-11-01'
    AND '2017-11-07'
    AND cabs.company_name LIKE '%Blue%'
GROUP BY
    cabs.company_name; 

/* --------- QUESTION 3 --------- */

/* For November 1-7, 2017, the most popular taxi companies were Flash Cab and Taxi Affiliation Services. Find the number of rides for these two companies and name the resulting variable trips_amount. Join the rides for all other companies in the group "Other." Group the data by taxi company names. Name the field with taxi company names company. Sort the result in descending order by trips_amount. */

/* --------- SOLUTION 3 --------- */

SELECT
    CASE
        WHEN cabs.company_name = 'Flash Cab' THEN 'Flash Cab'
        WHEN cabs.company_name = 'Taxi Affiliation Services' THEN 'Taxi Affiliation Services'
        ELSE 'Other'
        END AS company, --This separates the company column into just "Flash Cab," "Taxi Affiliation Services," or "Other"
    COUNT(trips.trip_id) AS trips_amount --This counts the # of trips for each of the three groups above
FROM
    trips
    INNER JOIN cabs ON cabs.cab_id = trips.cab_id --This joins the tables "trips" and "cabs"
WHERE
    trips.start_ts::date BETWEEN '2017-11-01'
    AND '2017-11-07' --This slices the data to only count trips which started between 11/1/17 and 11/7/17
GROUP BY
    company --This groups the data by the three groups defined in the CASE section above
ORDER BY
    trips_amount DESC; --This orders the data in descending order of # of trips

/* --------- QUESTION 4 --------- */

/* Retrieve the identifiers of the O'Hare and Loop neighborhoods  from the neighborhoods table. */

/* --------- SOLUTION 4 --------- */

SELECT --Prints the neighborhood_id and name columns
    neighborhood_id,
    name
FROM --Pulls the data from the "neighborhoods" table
    neighborhoods
WHERE --Selects for only the neighborhood names which include "Hare" and "Loop"
    name LIKE '%Hare'
    OR name LIKE 'Loop';

/* --------- QUESTION 5 --------- */

/* For each hour, retrieve the weather condition records from the weather_records table. Using the CASE operator, break all hours into two groups: Bad if the description field contains the words rain or storm, and Good for others. Name the resulting field weather_conditions. The final table must include two fields: date and hour (ts) and weather_conditions. */

/* --------- SOLUTION 5 --------- */

SELECT
    ts, --Prints the Date and Time
    CASE --Prints the Weather Conditions as either Bad, if they include the words 'rain' or 'storm', or Good, otherwise
        WHEN description LIKE '%rain%'
        OR description LIKE '%storm%'
            THEN 'Bad'
        ELSE 'Good'
        END AS weather_conditions
FROM
    weather_records --Pulls data from the weather_records table

/* --------- QUESTION 6 --------- */

/* Retrieve from the trips table all the rides that started in the Loop (pickup_location_id: 50) on a Saturday and ended at O'Hare (dropoff_location_id: 63). Get the weather conditions for each ride. Use the method you applied in the previous task. Also, retrieve the duration of each ride. Ignore rides for which data on weather conditions is not available.

The table columns should be in the following order:
- start_ts
- weather_conditions
- duration_seconds

Sort by trip_id. */

/* --------- SOLUTION 6 --------- */

SELECT
    trips.start_ts AS start_ts, --Retrieves the trip start dates and times
    CASE
        WHEN weather_records.description LIKE '%rain%'
        OR weather_records.description LIKE '%storm%'
            THEN 'Bad'
        WHEN weather_records.description IS NULL THEN ''
        ELSE 'Good'
        END AS weather_conditions, --Retrieves the weather conditions per the previous task
    trips.duration_seconds AS duration_seconds --Retrieves the duration of each trip
FROM --Pulls data from the 'trips' and 'weather_records' tables, joined by the start times for each trip and weather recording
    trips
    INNER JOIN weather_records ON trips.start_ts = weather_records.ts
WHERE --Slices only the trips which started on a Saturday and picked up at Loop and dropped off at O'Hare
    EXTRACT(DOW from trips.start_ts) = 6
    AND trips.pickup_location_id = 50
    AND trips.dropoff_location_id = 63
ORDER BY --Sorts the table by trip_id number in ascending order
    trips.trip_id;





