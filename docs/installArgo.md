This repo assumes a kubernetes cluster.

See/use https://github.com/aaronp/argo-drone.git for setting one up

e.g. 


```
git clone https://github.com/aaronp/argo-drone.git ../../argo-drone
pushd ../../argo-drone

echo "Installing a local cluster locally"
cd local
make

cd ../argo
make install
make login
popd
```
