create table station_agg(
  start_station_name string,
  end_station_name string,
  member_casual string,
  ride_month string,

  ride_minutes_sum decimal(12,3),
  number_rides int
  ) stored as orc;

insert overwrite table station_agg
  select start_station_name, end_station_name, 
  member_casual, ride_month,
  sum(ride_minutes) as ride_minutes_sum, count(1) as number_rides
  from ride_feature
  where start_station_name is not null and end_station_name is not null and
  member_casual is not null and ride_month is not null
  group by start_station_name, end_station_name, 
  member_casual, ride_month;

  select * from station_agg limit 5;
  select * from station_agg where start_station_name like "%morgan%" limit 5;

