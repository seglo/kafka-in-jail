# delete strimzi
export TILLER_NAMESPACE=tiller

# login to cluster docker registry
docker login -u admin registry.seglo-pipelines.ingestion.io:80

# install chart
kubectl create namespace strimzi
helm repo add strimzi http://strimzi.io/charts/
helm install strimzi/strimzi-kafka-operator \
--name pipelines-strimzi \
--namespace lightbend \
--set watchNamespaces="{strimzi}"

# create pipelines-strimzi cluster
kubectl apply -f ./resources/pipelines-strimzi.yaml

# generate data with call-record-pipeline
kubectl-pipelines deploy registry.seglo-pipelines.ingestion.io:80/lightbend/call-record-pipeline:338-1221463-dirty cdr-aggregator.group-by-window="1 minute" cdr-aggregator.watermark="1 minute"
