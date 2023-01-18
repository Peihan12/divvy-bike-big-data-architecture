create table ride_feature (
  ride_id string,
  ride_type string,
  start_station_name string,
  end_station_name string,
  member_casual string,
  ride_minutes decimal(9,3),
  ride_month string
  ) stored as orc;

insert overwrite table ride_feature
  select RideId as ride_id, RideableType as ride_type, StartStationName as start_station_name, 
  EndStationName as end_station_name, 
  MemberCasual as member_casual, 
  (unix_timestamp(EndedAt) -unix_timestamp(StartedAt))/60 as ride_minutes,
  cast(month(StartedAt) as string) as ride_month
  from trips;


  select * from ride_feature limit 5;