#!/usr/bin/env bash

HOST=`hostname -s`
DOMAIN=`hostname -d`
SERVERS=3
FULL_HOST_NAME=`hostname -f`

if [[ $HOST =~ (.*)-([0-9]+)$ ]]; then
    NAME=${BASH_REMATCH[1]}
    ORD=${BASH_REMATCH[2]}
else
    echo "Fialed to parse name and ordinal of Pod"
    exit 1
fi

MY_ID=$((ORD+1))

function print_servers() {
    echo "$MY_ID" > /tmp/myid
    for (( i=1; i<=$SERVERS; i++ ))
    do
        echo "server.$i=$NAME-$((i-1)).$DOMAIN:2888:3888" >> /tmp/zookeeper.properties
    done
}

function set_servers() {
    #ZooKeeper Configuration parameters
    echo "$MY_ID" >> ${ZK_DATA_DIR}/myid
    echo "dataDir=${ZK_DATA_DIR}" >> ${KAFKA_HOME}/config/zookeeper.properties
    echo "clientPort=2181" >> ${KAFKA_HOME}/config/zookeeper.properties
    echo "maxClientCnxns=0" >> /${KAFKA_HOME}/config/zookeeper.properties
    echo "initLimit=5" >> ${KAFKA_HOME}/config/zookeeper.properties
    echo "syncLimit=2" >> ${KAFKA_HOME}/config/zookeeper.properties
    echo "tickTime=2000" >> ${KAFKA_HOME}/config/zookeeper.properties
    echo "admin.enableServer=false" >> ${KAFKA_HOME}/config/zookeeper.properties
    for (( i=1; i<=$SERVERS; i++ ))
    do
        echo "server.$i=$NAME-$((i-1)).$DOMAIN:2888:3888" >> ${KAFKA_HOME}/config/zookeeper.properties
    done

    #Kafka Configuration parameters
    echo "broker.id=$MY_ID" >> ${KAFKA_HOME}/config/server.properties
    echo "advertised.host.name=$FULL_HOST_NAME" >> ${KAFKA_HOME}/config/server.properties
    echo "log.dirs=$KAFKA_DATA" >> ${KAFKA_HOME}/config/server.properties
    echo "zookeeper.connect=$NAME-0.$DOMAIN:2181,$NAME-1.$DOMAIN:2181,$NAME-2.$DOMAIN:2181" >> $KAFKA_HOME/config/server.properties
    echo "num.partitions=10" >> ${KAFKA_HOME}/config/server.properties
    echo "log.retention.hours=72" >> ${KAFKA_HOME}/config/server.properties

    echo "num.network.threads=3" >> ${KAFKA_HOME}/config/server.properties
    echo "num.io.threads=8" >> ${KAFKA_HOME}/config/server.properties
    echo "socket.send.buffer.bytes=102400" >> ${KAFKA_HOME}/config/server.properties
    echo "socket.receive.buffer.bytes=102400" >>${KAFKA_HOME}/config/server.properties
    echo "socket.request.max.bytes=104857600" >> ${KAFKA_HOME}/config/server.properties
    echo "num.recovery.threads.per.data.dir=1" >> ${KAFKA_HOME}/config/server.properties
    echo "offsets.topic.replication.factor=1" >> ${KAFKA_HOME}/config/server.properties
    echo "transaction.state.log.replication.factor=1" >> ${KAFKA_HOME}/config/server.properties
    echo "transaction.state.log.min.isr=1" >> ${KAFKA_HOME}/config/server.properties
    echo "log.segment.bytes=1073741824" >> ${KAFKA_HOME}/config/server.properties
    echo "log.retention.check.interval.ms=300000" >> ${KAFKA_HOME}/config/server.properties
    echo "zookeeper.connection.timeout.ms=18000" >> ${KAFKA_HOME}/config/server.properties
    echo "group.initial.rebalance.delay.ms=0" >> ${KAFKA_HOME}/config/server.properties

    sleep 10
    rm -rf $KAFKA_DATA/*

    zookeeper_cmd="${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties";
    kafka_cmd="${KAFKA_HOME}/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties";

    $zookeeper_cmd &
    $kafka_cmd &

    tail -f /dev/null
}

set_servers



