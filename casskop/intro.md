# CassKop's CRD: cassandracluster

CassKop defines its own Custom Ressource Definition named **cassandracluster**
This new k8s object allows to describe the Cassandra cluster a user wants to manage.
We can interract directly with this new object using kubectl.


## Configuration

We have a very small 2 nodes kubernetes cluster with 1 master and 1 node, and we have untainted the master so that it can
get some pods scheduled.

### No persistent volume

For the sake of simplicity for this hands-on, we launch each Cassandra without persistent volume to back the data. 

CassKop will warn you in it's log with messages like 

```
level=warning msg="[cassandra-demo]: No Spec.DataCapacity was specified -> You Cluster WILL NOT HAVE PERSISTENT
DATA!!!!!"
```

