# Useful Resources:

[dnsutil](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/) for debugging k8s DNS issues, e.g.

```
kubectl apply -f dnsutils.yaml

kubectl get pods -w dnsutils -n default
```

And then look up your service:
```
kubectl exec -it dnsutils -n default -- nslookup <service>.<ns>
```


Troubleshoot DNS:
```
kubectl exec -it dnsutils -n default -- nslookup kubernetes.default
kubectl exec -it dnsutils -n default -- cat /etc/resolv.conf

```

# set namespace
kubectl config set-context --current --namespace=default
