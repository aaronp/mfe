#!/usr/bin/env bash
export TAG=${TAG:-latest}
export IMG=${IMG:-porpoiseltd/dashboard:$TAG}
export PORT=${PORT:-3000}

build() {
    docker build --tag $IMG .
}

push() {
    docker push $IMG
}
run() {
    echo "docker run -it --rm -p $PORT:$PORT -d $IMG"
    id=`docker run -it --rm -p $PORT:$PORT -d $IMG`
    cat > kill.sh <<EOL
docker kill $id
# clean up after ourselves
rm kill.sh
EOL
    chmod +x kill.sh

    echo "Running on port $PORT --- stop server using ./kill.sh"
}

installArgo() {
    APP=${APP:-dashboard}

    echo "creating $APP"
    
    argocd app create $APP \
    --repo https://github.com/aaronp/mfe.git \
    --path dashboard/k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace mfe

    # beast mode :-)
    argocd app set $APP --sync-policy automated
    argocd app set $APP --auto-prune
    argocd app set $APP --self-heal
}