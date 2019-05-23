# delete perf-producer deployment
kubectl delete deployment producer -n strimzi

# delete topic
kubectl delete kafkatopic simple-topic -n strimzi

# delete cluster
kubectl delete kafka simple-strimzi -n strimzi

# delete pvc's
kubectl delete pvc -l strimzi.io/cluster=simple-strimzi -n strimzi


