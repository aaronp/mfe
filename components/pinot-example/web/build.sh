#!/usr/bin/env bash
export TAG=${TAG:-0.0.2}
export IMG=${IMG:-porpoiseltd/pinot-component-web:$TAG}
export PORT=${PORT:-3000}


build() {
    echo "Building $IMG..."
    docker build --tag $IMG .
    echo "Built $IMG. To run:"
    echo ""
    echo "docker run -it -p $PORT:80 $IMG"
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
    APP=${APP:-pinot-web}
    BRANCH=${BRANCH:-`git rev-parse --abbrev-ref HEAD`}

    echo "creating $APP"
    
    # beast mode :-)
    argocd app create $APP \
    --repo https://github.com/aaronp/mfe.git \
    --path components/pinot-example/web/k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace mfe \
    --sync-policy automated \
    --auto-prune \
    --self-heal \
    --revision $BRANCH

}