# delete console ingress in lightbend namespace
kubectl delete ingress console-ingress -n lightbend

# create console with pipelines
cd ~/source/kafka-in-jail
source bintray.sh
cd ~/source/console-charts/enterprise-suite
kubectl create namespace lightbend-console
kubectl -n lightbend-console create secret docker-registry commercial-credentials --docker-server=lightbend-docker-commercial-registry.bintray.io --docker-username=${BINTRAY_USER} --docker-password=${BINTRAY_PWD}
helm install --name=lightbend-console --namespace=lightbend-console -f scripts/pipelines.yaml .
create route
kubectl apply -f console-ingress.yaml -n lightbend-console
