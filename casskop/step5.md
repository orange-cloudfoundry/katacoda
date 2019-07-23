

# ScaleDown the cluster

Now we request CassKop to have again only 1 node per rack; this will remove 1 Cassandra nodes.

`kubectl patch cassandracluster cassandra-demo -p '{"spec":{"topology": {"dc": [{"name": "dc1","nodesPerRacks":1,"rack": [{"name": "rack1"}]}]}}}' --type merge`{{execute}}`

We can see the pods deletion with the command kubectl get pods below: 

`kubectl get pods -o wide`{{execute}}

We can follow the logs of CassKop with the command kubectl logs below :

`kubectl logs $(kubectl get pods -l app=cassandra-operator -o jsonpath='{range .items[*]}{.metadata.name}{" "}') -f`{{execute}}

> Ctrl-C to exit


## Get CassKop status

CassKop will update the status section in the CassandCluster object.

Once the Cassandra nodes are up the status must be **Done**

`kubectl describe cassandracluster`{{execute}}
```
Status:
  Cassandra Rack Status:
    Dc 1 - Rack 1:
      Cassandra Last Action:
        Name:        ScaleDown
        Start Time:  2019-05-27T15:11:54Z
        Status:      Ongoing
      Phase:         Pending
      Pod Last Operation:
  Last Cluster Action:         ScaleDown
  Last Cluster Action Status:  Ongoing
  Phase:                       Pending
  Seedlist:
    cassandra-demo-dc1-rack1-0.cassandra-demo-dc1-rack1.default
```

CassKop will make a Cassandra decommission prior to remove the Pod at Kubernetes level.

When decomission is OK, then Casskop asks Kubernetes to remove the pods
`kubectl get pods -o wide`{{execute}}
```
NAME                                          READY   STATUS    RESTARTS   AGE   IP          NODE     NOMINATED NODE   READINESS GATES
cassandra-demo-dc1-rack1-0                    1/1     Running   0          19m   10.40.0.4   node01   <none>           <none>
casskop-cassandra-operator-5fcc7df5b5-xrfcx   1/1     Running   0          19m   10.40.0.3   node01   <none>
<none>
```

We have only one remaining pod.

We check that Cassandra also has only one node remaining

`kubectl exec -ti cassandra-demo-dc1-rack1-0 nodetool status`{{execute}}
```
Datacenter: dc1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.40.0.4  113.73 KiB  256          100.0%            67b0c912-63af-4953-8e5f-f1c1e2badb4b  rack1
```

> we have only 1 node in rack1 in dc1

## Following

You can test more scenarios following our [demo
slides](https://orange-opensource.github.io/cassandra-k8s-operator/slides/index.html?slides=Slides-CassKop-demo.md) 

and give us your feedbacks via :
- [our mailing list](mailto:prj.casskop.support@list.orangeportails.net)
- https://casskop.slack.com

Project on Orange's [GitHub](https://github.com/Orange-OpenSource/cassandra-k8s-operator)
