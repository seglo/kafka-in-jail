# generate data with kafka-perf-producer
kubectl apply -f ./resources/simple-topic.yaml -n strimzi
./run-kafka-perf-producer.sh

# follow log
kubetail producer -n strimzi
