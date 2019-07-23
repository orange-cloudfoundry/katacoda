
Before starting the lab, let's check pre-requisites are OK

## Check you get the code

On the terminal, you must see the content listing of the CassKop GitHub repository

## Check configuration

You should have 2 node kubernetes cluster (master and node0)

`kubectl get nodes`{{execute}}
```
NAME      STATUS    ROLES     AGE       VERSION
master    Ready     master    1h        v1.11.3
node01    Ready     <none>    1h        v1.11.3
```

> If you don't see 2 kubernetes nodes or if the directory cassandra-k8s-operator is missing,
> try to `launch.sh`{{execute}} to restart kubernetes and wait a little more..
>
> If it does not works, please refresh the page
> while something in the init may have gone wrong..


## Check all pods are running


`kubectl get pods -o wide --all-namespaces`{{execute}}

## Troubleshooting

If needed you can check for events on the cluster: 

`kubectl get events --sort-by .metadata.creationTimestamp --all-namespaces`{{execute}}

