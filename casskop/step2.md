# Deploy CassKop 

CassKop is composed of a specific CRD (Custom Ressource Definition) and a controller.
We are going to apply directly the crd manifest, then deploy the CassKop using helm

## Deploy CassKop's operator

`helm install --name casskop --set image.tag=0.3.2-master ./helm/cassandra-operator`{{execute}}

Wait a few seconds for the CassKop to be up and running

> if you get this `Error: could not find tiller`
> execute `helm init`{{execute}} wait a little and try again.

`kubectl get pods -o wide`{{execute}}


You can see the operator's logs: 

`kubectl logs -l app=cassandra-operator`{{execute}}

For now CassKop is not doing anything, it is waiting for CassandraCluster object creation.

