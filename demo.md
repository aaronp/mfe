# demo schedule

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
k create namespace 
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
make installArgo
```