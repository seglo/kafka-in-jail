# create panel with watch on strimzi
watch kubectl get pod -n strimzi

# create simple-strimzi cluster
kubectl apply -f ./resources/simple-strimzi.yaml
