#!/usr/bin/env bash

downloadData(){
  year=$1
  echo "**** downloading data for $year****"
  for i in {1..9}
  do
     echo "wget -P /home/hadoop/data/ https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_$year-0$i.csv"
     wget -P /home/hadoop/data/ https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_$year-0$i.csv
     echo "hdfs dfs -copyFromLocal /home/hadoop/data/yellow_tripdata_$year-0$i.csv /user/hive/warehouse/nyc_trips_temp/"
     hdfs dfs -copyFromLocal /home/hadoop/data/yellow_tripdata_$year-0$i.csv /user/hive/warehouse/nyc_trips_temp/

  done

  for i in {10..12}
  do
     echo "wget -P /home/hadoop/data/ https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_$year-$i.csv"
     wget -P /home/hadoop/data/ https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_$year-$i.csv
     echo "hdfs dfs -copyFromLocal /home/hadoop/data/yellow_tripdata_$year-$i.csv /user/hive/warehouse/nyc_trips_temp/"
     hdfs dfs -copyFromLocal /home/hadoop/data/yellow_tripdata_$year-$i.csv /user/hive/warehouse/nyc_trips_temp/

  done
  #wget -P /home/hdfs/data/ https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2009-04.csv
  #hdfs dfs -copyFromLocal /home/hdfs/data/* /warehouse/tablespace/managed/hive/nyc_trips_temp/
}


downloadData $1

