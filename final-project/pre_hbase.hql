create table pre_hbase(
  start_station_name string,
  end_station_name string,
  num_rides_member_jan decimal(12,3),
  num_rides_member_feb decimal(12,3),
  num_rides_member_mar decimal(12,3),
  num_rides_member_apr decimal(12,3),
  num_rides_member_may decimal(12,3),
  num_rides_member_jun decimal(12,3),
  num_rides_member_jul decimal(12,3),
  num_rides_member_aug decimal(12,3),
  num_rides_member_sep decimal(12,3),
  num_rides_member_oct decimal(12,3),
  num_rides_member_nov decimal(12,3),
  num_rides_member_dec decimal(12,3),
  num_rides_casual_jan decimal(12,3),
  num_rides_casual_feb decimal(12,3),
  num_rides_casual_mar decimal(12,3),
  num_rides_casual_apr decimal(12,3),
  num_rides_casual_may decimal(12,3),
  num_rides_casual_jun decimal(12,3), 
  num_rides_casual_jul decimal(12,3),
  num_rides_casual_aug decimal(12,3),
  num_rides_casual_sep decimal(12,3),
  num_rides_casual_oct decimal(12,3),
  num_rides_casual_nov decimal(12,3),
  num_rides_casual_dec decimal(12,3)
  );

insert overwrite table pre_hbase
  select start_station_name, end_station_name, 
  max( if( (lower(member_casual)='member' and ride_month="1"), number_rides, 0 ) ) as num_rides_member_jan,
  max( if( (lower(member_casual)='member' and ride_month="2"), number_rides, 0 ) ) as num_rides_member_feb, 
  max( if( (lower(member_casual)='member' and ride_month="3"), number_rides, 0 ) ) as num_rides_member_mar,
  max( if( (lower(member_casual)='member' and ride_month="4"), number_rides, 0 ) ) as num_rides_member_apr, 
  max( if( (lower(member_casual)='member' and ride_month="5"), number_rides, 0 ) ) as num_rides_member_may, 
  max( if( (lower(member_casual)='member' and ride_month="6"), number_rides, 0 ) ) as num_rides_member_jun,
  max( if( (lower(member_casual)='member' and ride_month="7"), number_rides,0 ) ) as num_rides_member_jul, 
  max( if( (lower(member_casual)='member' and ride_month="8"), number_rides, 0 ) ) as num_rides_member_aug,
  max( if( (lower(member_casual)='member' and ride_month="9"), number_rides,0 ) ) as num_rides_member_sep, 
  max( if( (lower(member_casual)='member' and ride_month="10"), number_rides, 0 ) ) as num_rides_member_oct, 
  max( if( (lower(member_casual)='member' and ride_month="11"), number_rides, 0 ) ) as num_rides_member_nov,
  max( if( (lower(member_casual)='member' and ride_month="12"), number_rides, 0 ) ) as num_rides_member_dec, 
  max( if( (lower(member_casual)='casual' and ride_month="1"), number_rides, 0 ) ) as num_rides_casual_jan,
  max( if( (lower(member_casual)='casual' and ride_month="2"), number_rides, 0 ) ) as num_rides_casual_feb, 
  max( if( (lower(member_casual)='casual' and ride_month="3"), number_rides, 0 ) ) as num_rides_casual_mar, 
  max( if( (lower(member_casual)='casual' and ride_month="4"), number_rides, 0 ) ) as num_rides_casual_apr,
  max( if( (lower(member_casual)='casual' and ride_month="5"), number_rides, 0 ) ) as num_rides_casual_may, 
  max( if( (lower(member_casual)='casual' and ride_month="6"), number_rides, 0 ) ) as num_rides_casual_jun, 
  max( if( (lower(member_casual)='casual' and ride_month="7"), number_rides, 0 ) ) as num_rides_casual_jul,
  max( if( (lower(member_casual)='casual' and ride_month="8"), number_rides, 0 ) ) as num_rides_casual_aug, 
  max( if( (lower(member_casual)='casual' and ride_month="9"), number_rides, 0) ) as num_rides_casual_sep, 
  max( if( (lower(member_casual)='casual' and ride_month="10"), number_rides, 0 ) ) as num_rides_casual_oct,
  max( if( (lower(member_casual)='casual' and ride_month="11"), number_rides, 0 ) ) as num_rides_casual_nov, 
  max( if( (lower(member_casual)='casual' and ride_month="12"), number_rides, 0 ) ) as num_rides_casual_dec
  from station
  where start_station_name is not null and end_station_name is not null
  group by start_station_name, end_station_name;



select * from pre_hbase limit 5;


