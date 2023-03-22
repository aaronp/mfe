#!/usr/bin/env bash
export TAG=${TAG:-0.0.1}
export IMG=${IMG:-porpoiseltd/pinot-component-web:$TAG}
export PORT=${PORT:-3000}


build() {
    echo "Building $IMG..."
    docker build --tag $IMG .
    echo "Built $IMG. To run:"
    echo ""
    echo "docker run -it -p $PORT:80 basic-card-component"
    echo ""
    echo "And open http://localhost:$PORT/bundle.js or http://localhost:$PORT/bundle.css"
}

dev() {
    yarn
    yarn dev
}

push() {
    docker push $IMG
}
run() {
    echo "docker run -it --rm -p $PORT:80 -d $IMG"
    id=`docker run -it --rm -p $PORT:80 -d $IMG`
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