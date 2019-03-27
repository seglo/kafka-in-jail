# edit strimzi-simple resource in place
kubectl edit kafka simple-strimzi -n strimzi

# set auto.create.topics.enable to false
auto.create.topics.enable: false
