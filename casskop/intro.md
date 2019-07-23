# CassKop: Orange's Cassandra Kubernetes operator

The [CassKop](https://github.com/Orange-OpenSource/cassandra-k8s-operator) Cassandra Kubernetes operator makes it easy
to run Apache Cassandra on Kubernetes. Apache Cassandra is a
popular, free, open-source, distributed wide column store, NoSQL database management system. The operator allows to
easily create and manage racks and data centers aware Cassandra clusters


## CassKop's CRD: cassandracluster

CassKop defines its own Custom Ressource Definition named **cassandracluster**
This new k8s object allows to describe the Cassandra cluster a user wants to manage.
We can interract directly with this new object using kubectl.


## Configuration for Katacoda

We have a very small 2 nodes kubernetes cluster with 1 master and 1 node, and we have untainted the master so that it can
get some pods scheduled.

### No persistent volume

For the sake of simplicity for this hands-on, we launch each Cassandra without persistent volume to back the data. 

CassKop will warn you in it's log with messages like 

```log
level=warning msg="[cassandra-demo]: No Spec.DataCapacity was specified -> You Cluster WILL NOT HAVE PERSISTENT
DATA!!!!!"
```

