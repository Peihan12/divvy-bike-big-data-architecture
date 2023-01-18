create external table trips_agg (
  trip string,
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
  )
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ('hbase.columns.mapping' = ':key,trip:num_rides_member_jan#b,trip:num_rides_member_feb#b,trip:num_rides_member_mar#b,trip:num_rides_member_apr#b,
trip:num_rides_member_may#b,trip:num_rides_member_jun#b,trip:num_rides_member_jul#b,trip:num_rides_member_aug#b,trip:num_rides_member_sep#b,trip:num_rides_member_oct#b,trip:num_rides_member_nov#b,
trip:num_rides_member_dec#b,trip:num_rides_casual_jan#b,trip:num_rides_casual_feb#b, trip:num_rides_casual_mar#b,trip:num_rides_casual_apr#b,trip:num_rides_casual_may#b, trip:num_rides_casual_jun#b,
trip:num_rides_casual_jul#b,trip:num_rides_casual_aug#b, trip:num_rides_casual_sep#b,
trip:num_rides_casual_oct#b,trip:num_rides_casual_nov#b, trip:num_rides_casual_dec#b')
TBLPROPERTIES ('hbase.table.name' = 'trips_agg');


insert overwrite table trips_agg
select concat(start_station_name,"-", end_station_name) as trip,

  num_rides_member_jan, 
  num_rides_member_feb,
  num_rides_member_mar,
  num_rides_member_apr,
  num_rides_member_may,
  num_rides_member_jun,
  num_rides_member_jul,
  num_rides_member_aug,
  num_rides_member_sep,
  num_rides_member_oct,
  num_rides_member_nov,
  num_rides_member_dec,
  num_rides_casual_jan,
  num_rides_casual_feb,
  num_rides_casual_mar,
  num_rides_casual_apr,
  num_rides_casual_may,
  num_rides_casual_jun, 
  num_rides_casual_jul ,
  num_rides_casual_aug,
  num_rides_casual_sep,
  num_rides_casual_oct,
  num_rides_casual_nov,
  num_rides_casual_dec
  from pre_hbase;
