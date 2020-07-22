from datetime import datetime, timedelta
from json import dumps
import pandas as pd

def SendToKafka(url):
    producer = KafkaProducer(bootstrap_servers=['ec2-54-244-185-158.us-west-2.compute.amazonaws.com:9092'],
                             value_serializer=lambda x:
                             dumps(x).encode('utf-8'))
    for e in range(1000):
        data = {'number' : e}
        producer.send('sample_test_2', value=data)

def read_csv_chunks(url,c_size):
    i=1
    print("Start reading chunks")
    for df_chunks in pd.read_csv(url,chunksize=c_size):
        df_chunks.to_csv("/root/data/NYC_data_"+ str(i) +".csv",index=False, header=False)
        print("saved "+str(i))
        i=i+1

def download_csv_pandas(url):
    df=pd.read_csv(url)
    y=0
    m=1
    for x in range(df.shape[0]):
        if (y == 10000):
            print("saving "+str(m))
            df.to_csv("/home/ec2-user/data/NYC_data_"+ str(m) +".csv",index=False, header=False)
            y=0
            m=m+1
        y=y+1
if __name__ == "__main__":
    read_csv_chunks("https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2009-02.csv", 5000 )
