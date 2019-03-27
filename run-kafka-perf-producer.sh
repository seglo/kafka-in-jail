#!/usr/bin/env bash
set -e

kubectl run -n strimzi --image strimzi/kafka producer --command -- /opt/kafka/bin/kafka-producer-perf-test.sh \
--topic simple-topic \
--num-records 1000000 \
--record-size 100 \
--throughput 1000 \
--producer-props bootstrap.servers=simple-strimzi-kafka-bootstrap:9092
