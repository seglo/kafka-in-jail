# scale brokers to 3

# edit strimzi-simple resource in place
kubectl edit kafka simple-strimzi -n strimzi

# reassign partitions
# put topic list on broker
cat ./partition-reassignment/topics-simple-strimzi.json | kubectl exec -c kafka simple-strimzi-kafka-0 -n strimzi -i -- \
  /bin/bash -c \
  'cat > /tmp/topics.json'

# generate new assignment plan
kubectl exec simple-strimzi-kafka-0 -c kafka -n strimzi -it -- \
  bin/kafka-reassign-partitions.sh --zookeeper localhost:2181 \
  --topics-to-move-json-file /tmp/topics.json \
  --broker-list 0,1,2 \
  --generate

# put new assignments on broker
cat ./partition-reassignment/proposed-assignment.json | \
  kubectl exec simple-strimzi-kafka-0 -c kafka -n strimzi -i -- /bin/bash -c \
  'cat > /tmp/reassignment.json'

# run plan
kubectl exec simple-strimzi-kafka-0 -c kafka -n strimzi -it -- \
  bin/kafka-reassign-partitions.sh --zookeeper localhost:2181 \
  --reassignment-json-file /tmp/reassignment.json \
  --execute

# verify
kubectl exec simple-strimzi-kafka-0 -c kafka -n strimzi -it -- \
  bin/kafka-reassign-partitions.sh --zookeeper localhost:2181 \
  --reassignment-json-file /tmp/reassignment.json \
  --verify
