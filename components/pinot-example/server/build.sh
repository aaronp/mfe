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
    BRANCH=${BRANCH:-`git rev-parse --abbrev-ref HEAD`}
    
    argocd app create $APP \
    --repo https://github.com/aaronp/mfe.git \
    --path components/pinot-example/server/k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace mfe \
    --sync-policy automated \
    --auto-prune \
    --self-heal \
    --revision $BRANCH
}