load data inpath '/warehouse/tablespace/managed/hive/nyc_trips_temp/' overwrite into table NYC_TRIPS_TEMP;
set hive.execution.engine=tez;
set hive.tez.container.size=4096;
set hive.tez.java.opts=-Xmx4096m;
set hive.cbo.enable=true;
set hive.compute.query.using.stats=true;
set hive.stats.fetch.column.stats=true;
set hive.vectorized.execution.enabled=true;
set hive.vectorized.execution.reduce.enabled = true;
set hive.vectorized.execution.reduce.groupby.enabled = true;
set hive.exec.parallel=true;
set hive.exec.parallel.thread.number=16;
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.dynamic.partition = true;
INSERT INTO TABLE NYC_TRIPS_FINAL PARTITION (year,month) SELECT *,year(to_date(Trip_Pickup_DateTime)),month(to_date(Trip_Pickup_DateTime)) FROM NYC_TRIPS_TEMP;

