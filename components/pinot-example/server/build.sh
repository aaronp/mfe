#!/usr/bin/env bash
export TAG=${TAG:-0.0.2}
export IMG=${IMG:-porpoiseltd/pinot-bff:$TAG}
export PORT=${PORT:-8080}

# scala-cli --power package --docker App.scala --docker-from openjdk:11 --docker-image-repository service-registry

build() {
    #pwd  --platform "linux/amd64,linux/arm64"
    docker build --tag $IMG .
}

push() {
    docker push $IMG
}

run() {
    id=`docker run -it --rm -p 8089:$PORT -d $IMG`
    cat > kill.sh <<EOL
docker kill $id
# clean up after ourselves
rm kill.sh
EOL
    chmod +x kill.sh

    echo "Running on port 8089 --- stop server using ./kill.sh"
}

installArgo() {
    APP=${APP:-pinot-bff}
    # assumes argocd (brew install argocd) is installed:
    #
    # which argocd || brew install argocd
    #
    # and logged in, e.g.
    #
    # argocd login localhost:$ARGO_PORT --username admin --password $MY_ARGO_PWD  --insecure --skip-test-tls 
    #
    # see 
    # https://github.com/easy-being-green/argo-drone/blob/main/argo/argo.sh
    #
    argocd app create $APP \
    --repo https://github.com/aaronp/mfe.git \
    --path components/pinot-example/server/k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace mfe

    # beast mode :-)
    argocd app set $APP --sync-policy automated
    argocd app set $APP --auto-prune
    argocd app set $APP --self-heal
}