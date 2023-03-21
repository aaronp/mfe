# Pinto

Install via [the docs](https://docs.pinot.apache.org/basics/getting-started/kubernetes-quickstart):

```
helm repo add pinot https://raw.githubusercontent.com/apache/pinot/master/kubernetes/helm
kubectl create ns pinotdb
helm install pinot pinot/pinot \
    -n pinotdb \
    --set cluster.name=pinot \
    --set server.replicaCount=2
```