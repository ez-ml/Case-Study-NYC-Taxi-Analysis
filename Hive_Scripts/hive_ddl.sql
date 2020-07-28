create table IF NOT EXISTS NYC_TRIPS_TEMP(
vendor_name VARCHAR(5),
Trip_Pickup_DateTime TIMESTAMP,
Trip_Dropoff_DateTime TIMESTAMP,
Passenger_Count TINYINT,
Trip_Distance SMALLINT,
Start_Lon FLOAT,
Start_Lat FLOAT,
Rate_Code FLOAT,
store_and_forward FLOAT,
End_Lon FLOAT,
End_Lat FLOAT,
Payment_Type VARCHAR(10),
Fare_Amt FLOAT,
surcharge FLOAT,
mta_tax FLOAT,
Tip_Amt FLOAT,
Tolls_Amt FLOAT,
Total_Amt FLOAT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS textfile
LOCATION '/user/hive/warehouse/nyc_trips_temp';

create table IF NOT EXISTS  NYC_TRIPS_FINAL_1(
vendor_name VARCHAR(5),
Trip_Pickup_DateTime TIMESTAMP,
Trip_Dropoff_DateTime TIMESTAMP,
Passenger_Count TINYINT,
Trip_Distance SMALLINT,
Start_Lon FLOAT,
Start_Lat FLOAT,
Rate_Code FLOAT,
store_and_forward FLOAT,
End_Lon FLOAT,
End_Lat FLOAT,
Payment_Type VARCHAR(10),
Fare_Amt FLOAT,
surcharge FLOAT,
mta_tax FLOAT,
Tip_Amt FLOAT,
Tolls_Amt FLOAT,
Total_Amt FLOAT
)
PARTITIONED BY (year int, month int)
STORED AS PARQUET
TBLPROPERTIES ('PARQUET.COMPRESS'='SNAPPY');


create table IF NOT EXISTS NYC_TRIPS_FINAL_1(
vendor_name VARCHAR(5),
Trip_Pickup_DateTime TIMESTAMP,
Trip_Dropoff_DateTime TIMESTAMP,
Passenger_Count TINYINT,
Trip_Distance SMALLINT,
Start_Lon FLOAT,
Start_Lat FLOAT,
Rate_Code FLOAT,
store_and_forward FLOAT,
End_Lon FLOAT,
End_Lat FLOAT,
Payment_Type VARCHAR(10),
Fare_Amt FLOAT,
surcharge FLOAT,
mta_tax FLOAT,
Tip_Amt FLOAT,
Tolls_Amt FLOAT,
Total_Amt FLOAT,
dayofmonth INT
)
PARTITIONED BY (year int, month int)
CLUSTERED BY (dayofmonth) SORTED BY (dayofmonth) INTO 31 BUCKETS
STORED AS PARQUET
TBLPROPERTIES ('PARQUET.COMPRESS'='SNAPPY');
