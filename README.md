# Zuber Database Analysis Project

## Overview
Serving as a data analyst for Zuber, a new ride-sharing company that's launching in Chicago, my project was to find patterns in the available information, and to understand passenger preferences and the impact of external factors on rides.
I studied the database, analyzed data from competitors, and investigated the impact of weather on ride frequency.

## The Database
The database contains the following 4 tables. Refer to the relationship diagram below to understand their connections.

`neighborhoods` table: data on city neighborhoods
- *name:* name of the neighborhood
- *neighborhood_id:* neighborhood code

`cabs` table: data on taxis
- *cab_id:* vehicle code
- *vehicle_id:* the vehicle's technical ID
- *company_name:* the company that owns the vehicle

`trips` table: data on rides
- *trip_id:* ride code
- *cab_id:* code of the vehicle operating the ride
- *start_ts:* date and time of the beginning of the ride (time rounded to the hour)
- *end_ts:* date and time of the end of the ride (time rounded to the hour)
- *duration_seconds:* ride duration in seconds
- *distance_miles:* ride distance in miles
- *pickup_location_id:* pickup neighborhood code
- *dropoff_location_id:* dropoff neighborhood code

`weather_records` table: data on weather
- *record_id:* weather record code
- *ts:* record date and time (time rounded to the hour)
- *temperature:* temperature when the record was taken
- *description:* brief description of weather conditions, e.g. "light rain" or "scattered clouds"

## Table scheme
  
  ![image](https://github.com/oscarhernandeziv/Zuber-Rideshare-Analysis/assets/151409062/7d9cd83f-baf1-41ee-b1b6-f9ac61aa3ae0)

## :speech_balloon: SQL Queries

1. Print the *company_name* field. Find the number of taxi rides for each taxi company for November 15-16, 2017, name the resulting field *trips_amount* and print it, too. Sort the results by the *trips_amount* field in descending order.
2. Find the number of rides for every taxi companies whose name contains the words "Yellow" or "Blue" for November 1-7, 2017. Name the resulting variable *trips_amount*. Group the results by the *company_name* field.
3. For November 1-7, 2017, the most popular taxi companies were Flash Cab and Taxi Affiliation Services. Find the number of rides for these two companies and name the resulting variable trips_amount. Join the rides for all other companies in the group "Other." Group the data by taxi company names. Name the field with taxi company names company. Sort the result in descending order by trips_amount.
4. Retrieve the identifiers of the O'Hare and Loop neighborhoods from the `neighborhoods` table.
5. For each hour, retrieve the weather condition records from the `weather_records` table. Using the CASE operator, break all hours into two groups: "Bad" if the *description* field contains the words "rain" or "storm," and "Good" for others. Name the resulting field *weather_conditions*. The final table must include two fields: date and hour (*ts*) and *weather_conditions*.
6. Retrieve from the `trips` table all the rides that started in the Loop (*pickup_location_id:* 50) on a Saturday and ended at O'Hare (*dropoff_location_id:* 63). Get the weather conditions for each ride. Use the method you applied in the previous task. Also, retrieve the duration of each ride. Ignore rides for which data on weather conditions is not available.
The table columns should be in the following order:
    - *start_ts*
    - *weather_conditions*
    - *duration_seconds*

    Sort by *trip_id*.

## Conclusion

1. *Flash Cab* had the highest number of rides for November 15-16, 2017, at 19558 rides.
2. Among taxi companies whose name contains the words "Yellow" or "Blue" for November 1-7, 2017, the company with the highest number of rides was *Taxi Affiliation Service Yellow* with 29213 rides.
3. The number of rides for all *other* taxi companies outside of the two most popular (*Flash Cab* and *Taxi Affiliation Services*) was 335771 rides.
4. The neighborhood IDs for the Loop and O'Hare neighborhoods are 50 and 63, respectively.
5. For each hour between November 1-9, 2017, the weather conditions were mostly *Good*.
6. The trip that started in the Loop on a Saturday and ended at O'Hare with the first chronological trip ID started at 2017-11-25 12:00:00, had *Good* weather, and had a duration of 1380 seconds.
