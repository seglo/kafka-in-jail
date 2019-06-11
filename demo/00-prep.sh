# delete strimzi
export TILLER_NAMESPACE=tiller

# login to cluster docker registry
cat /keybase/team/assassins/gcloud/pipelines-serviceaccount-key-container-registry-read-write.json | docker login -u _json_key --password-stdin https://eu.gcr.io

# update chart to watch strimzi namespace
kubectl create namespace strimzi
helm repo add strimzi http://strimzi.io/charts/
helm upgrade \
--reuse-values \
--set watchNamespaces="{strimzi}" \
pipelines-strimzi lightbend-helm-charts/strimzi-kafka-operator

# create pipelines-strimzi cluster
kubectl apply -f ./resources/pipelines-strimzi.yaml

# generate data with call-record-pipeline
cat /keybase/team/assassins/gcloud/pipelines-serviceaccount-key-container-registry-read-write.json | kubectl pipelines deploy -u _json_key --password-stdin eu.gcr.io/bubbly-observer-178213/lightbend/sensor-data-scala:387-d4a61ae cdr-aggregator.group-by-window="1 minute" cdr-aggregator.watermark="1 minute"
