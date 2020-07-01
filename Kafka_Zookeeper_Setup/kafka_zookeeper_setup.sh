#!/usr/bin/env bash

HOST=`hostname -s`
DOMAIN=`hostname -d`
SERVERS=3


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
        echo "server.$i=$NAME-$((i-1)).$DOMAIN:2888:3888" >> /tmp/myservers
    done

}

print_servers
tail -f /dev/null
