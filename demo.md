# Demo

This is how to "boot up" this micro-architecture on a new K8S cluster, showing:
 * docker
 * kubectl
 * k9s
 * argocd

And an example of small polyglot repos.

TL;DR: To just spin up everything:
```

pushd ~/code/argo-drone/argo
make install
make login

cd ~/code/mfe/service-registry/server && make installArgo
cd ~/code/mfe/dashboard && make installArgo
cd ~/code/mfe/components/pinot-example/web && pwd && make installArgo

# or tear it all down:
k delete namespace mfe & 
k delete namespace argocd &

popd
```

## server registry

### show in docker

```
cd service-registry/server

# start the server
make run

# show a bit of docker
# docker ps
# docker exec -it <SHA> bash
# whatevs


# show the endpoint
open http://localhost:8080/api/v1/registry/

# run some curl tests
make test

# refresh browser, then kill it:

docker ps

./kill.sh
```

### ok - let's deploy in kube

1. show the k8s config

2. show kubectl

```
kubectl get all --all-namespaces
# or 
kubectl get all -n mfe
```

create our app in k8s:

```
cd service-registry/server/k8s 
k create namespace mfe
k apply -f server.yaml

k get all -n mfe 

k get service -w -n mfe 

```

### show k9s
```
k9s
```

logs, shell, port-forward ...

## show argo

argo is CD for K8S


let's install it locally...

watch this in K9S:

```
cd ~/code/argo-drone/argo/
make install
make login

open http://localhost:9090
```

Now install our service-registry:

```
# back to our original directory
cd - 

# let's stop our service
k delete -f server.yaml

# and install it using CD
cd ../
make installArgo
```