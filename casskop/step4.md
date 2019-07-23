

# ScaleUp the cluster

Now we request CassKop to add 1 node in the rack rack1

`kubectl patch cassandracluster cassandra-demo -p '{"spec":{"topology": {"dc": [{"name": "dc1","nodesPerRacks":2,"rack": [{"name": "rack1"}]}]}}}' --type merge`{{execute}}

We can see the pod creation with the command kubectl get pods below: 

`kubectl get pods -o wide`{{execute}}

We can follow the logs of CassKop with the command kubectl logs below :

`kubectl logs $(kubectl get pods -l app=cassandra-operator -o jsonpath='{range .items[*]}{.metadata.name}{" "}') -f`{{execute}}

> Ctrl-C to exit


## Get CassKop status

CassKop will update the status section in the CassandCluster object.

Once the Cassandre nodes are up, the status must be **Done**

`kubectl describe cassandracluster`{{execute}}
```
Status:
  Cassandra Rack Status:
    Dc 1 - Rack 1:
      Cassandra Last Action:
        Name:        ScaleUp
        Start Time:  2019-05-27T15:11:54Z
        Status:      Ongoing
      Phase:         Pending
      Pod Last Operation:
    Dc 1 - Rack 2:
      Cassandra Last Action:
        Name:      Initializing
        End Time:  2019-05-27T15:01:38Z
        Status:    Done
      Phase:       Running
      Pod Last Operation:
  Last Cluster Action:         ScaleUp
  Last Cluster Action Status:  Ongoing
  Phase:                       Pending
  Seedlist:
    cassandra-demo-dc1-rack1-0.cassandra-demo-dc1-rack1.default
    cassandra-demo-dc1-rack2-0.cassandra-demo-dc1-rack2.default
```

Wait for both pods to be running:

`kubectl get pods`{{execute}}
```
NAME                                                 READY   STATUS    RESTARTS   AGE
cassandra-demo-cassandra-operator-5c79655858-72bjl   1/1     Running   0          8m37s
cassandra-demo-dc1-rack1-0                           1/1     Running   0          8m18s
cassandra-demo-dc1-rack1-1                           1/1     Running   0          90s
```

## Make a Cassandra cleanup on datas in the cluster 

When the ScaleUp is Done :

`kubectl describe cassandracluster`{{execute}}
```
...
  Last Cluster Action:         ScaleUp
  Last Cluster Action Status:  Done
...
```

we can do a data cleanup using the CassKop plugin:


`kubectl casskop cleanup --prefix cassandra-demo-dc1`{{execute}}


We can see that the status of cassandra-demo CassandraCluster object will reflect the operation status of each pod.

CassKop will also update the labels on each pod; we can see that with :

`for x in 0 1; do
 echo cassandra-demo-dc1-rack1-$x;
 kubectl label pod cassandra-demo-dc1-rack1-$x --list | grep operation ; echo ""
done`{{execute}}

## Check Cassandra status


Let's see how Cassandra see it's 2 nodes :

`kubectl exec -ti cassandra-demo-dc1-rack1-0 nodetool status`{{execute}}
```
Datacenter: dc1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.32.0.3  88.47 KiB  256          100.0%            0f917754-d147-4571-b53f-6aa58765222a  rack1
UN  10.40.0.4  113.73 KiB  256          100.0%            67b0c912-63af-4953-8e5f-f1c1e2badb4b  rack1
```

> we now have 2 nodes in rack1 from dc1

Using the Topology section of our CassandraCluster object we can define as many dc and racks as we need, and we can
associate some kubernetes nodes labels in order to spread those racks in different locations.
