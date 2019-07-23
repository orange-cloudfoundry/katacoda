git clone https://github.com/Orange-OpenSource/cassandra-k8s-operator.git
helm init
kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule-


export PATH=$PATH:/root/cassandra-k8s-operator/plugins
