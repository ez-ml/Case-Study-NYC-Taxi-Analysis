load data inpath '/user/hive/warehouse/nyc_trips_temp/' into table NYC_TRIPS_TEMP;
/*set hive.execution.engine=tez;

set hive.cbo.enable=true;
set hive.compute.query.using.stats=true;
set hive.stats.fetch.column.stats=true;
set hive.vectorized.execution.enabled=true;
set hive.vectorized.execution.reduce.enabled = true;
set hive.vectorized.execution.reduce.groupby.enabled = true;
set hive.exec.parallel=true;
set hive.exec.parallel.thread.number=32;
set hive.tez.container.size=8192;
set hive.tez.java.opts=-Xmx8192m;
set hive.tez.auto.reducer.parallelism = true;
set hive.exec.reducers.bytes.per.reducer=512000000;
*/


SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.dynamic.partition = true;
SET hive.enforce.bucketing = true;
INSERT INTO TABLE NYC_TRIPS_FINAL PARTITION (year,month) SELECT *,year(to_date(Trip_Pickup_DateTime)),month(to_date(Trip_Pickup_DateTime)) FROM NYC_TRIPS_TEMP;

INSERT INTO TABLE NYC_TRIPS_FINAL_2 PARTITION (year,month) SELECT *,dayofmonth(to_date(Trip_Pickup_DateTime)) as dayofmonth,year(to_date(Trip_Pickup_DateTime)),month(to_date(Trip_Pickup_DateTime)) FROM NYC_TRIPS_TEMP;


