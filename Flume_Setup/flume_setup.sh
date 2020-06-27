#!/usr/bin/env bash

docker build -t hishailesh77/flume:latest .
docker push hishailesh77/flume
kubectl apply -f flume.yaml

