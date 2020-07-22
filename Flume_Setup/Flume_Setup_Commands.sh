#!/usr/bin/env bash
docker build -t hishailesh77/flume:latest .
docker push hishailesh77/flume
kubectl apply -f Flume_Deployment.yaml

#Command To Delete Docker
#docker system prune -a