#!/usr/bin/env bash

HOST=`hostname -s`
DOMAIN=`hostname -d`
SERVERS=3
fullHostname=`hostname -f`

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

    #sed -i -e "s/${fullHostname}/0.0.0.0/g" /opt/kafka/config/zookeeper.properties
    ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties

    tail -f /dev/null
}

set_servers

