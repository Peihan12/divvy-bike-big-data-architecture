-- This file will create an ORC table with divvy trips data

-- First, map the CSV data we downloaded in Hive
create external table trips_csv(
  RideId string,
  RideableType string,
  StartedAt timestamp,
  EndedAt timestamp,
  StartStationName string,
  StartStationId string,
  EndStationName string,
  EndStationId string,
  StartLat decimal(12,3),
  StartLng decimal(12,3),
  EndLat decimal(12,3),
  EndLng decimal(12,3),
  MemberCasual string
 )
  row format serde 'org.apache.hadoop.hive.serde2.OpenCSVSerde'

WITH SERDEPROPERTIES (
   "separatorChar" = "\,",
   "quoteChar"     = "\""
)
STORED AS TEXTFILE
  location '/tmp/peihan/inputs/divvy';

-- Run a test query to make sure the above worked correctly
select * from trips_csv limit 5;

-- Create an ORC table for ontime data (Note "stored as ORC" at the end)
create table trips(
  RideId string,
  RideableType string,
  StartedAt timestamp,
  EndedAt timestamp,
  StartStationName string,
  StartStationId string,
  EndStationName string,
  EndStationId string,
  StartLat decimal(12,3),
  StartLng decimal(12,3),
  EndLat decimal(12,3),
  EndLng decimal(12,3),
  MemberCasual string
)
  stored as orc;

-- Copy the CSV table to the ORC table
insert overwrite table trips select * from trips_csv
where startstationname is not null and startstationname != '' and endstationname is not null
and endstationname != '' and startstationid != '' and endstationid != ''
and startstationid is not null and endstationid is not null and membercasual is not null and membercasual != '';