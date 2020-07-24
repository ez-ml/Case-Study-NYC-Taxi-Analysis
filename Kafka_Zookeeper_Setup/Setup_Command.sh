#!/usr/bin/env bash
docker build -t hishailesh77/kafka-zookeeper:v1.0 . && docker build -t hishailesh77/kafka-zookeeper:latest . && docker push hishailesh77/kafka-zookeeper:v1.0 && docker push hishailesh77/kafka-zookeeper:latest && kubectl apply -f kafka-zookeeper-setup.yaml

#Kafka commands
#FULL_HOST_NAME=`hostname -f`
#bin/zookeeper-shell.sh $FULL_HOST_NAME:2181 ls /brokers/ids

#bin/kafka-topics.sh --create --zookeeper $FULL_HOST_NAME:2181  --replication-factor 2 --partitions 10 --topic sample1
#kafka/bin/kafka-topics.sh --create --zookeeper kafka-zookeeper-0.kafka-zookeeper.default.svc.cluster.local:2181 --replication-factor 2 --partitions 10 --topic sample1
#bin/kafka-topics.sh --list --bootstrap-server kafka-zookeeper-0.kafka-zookeeper.default.svc.cluster.local:9092

#kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka-zookeeper-0.kafka-zookeeper.default.svc.cluster.local:9092 --topic sample1 --from-beginning
#Kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic sample1
