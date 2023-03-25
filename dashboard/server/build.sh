#!/usr/bin/env bash
export TAG=${TAG:-0.0.2}
export IMG=${IMG:-porpoiseltd/dashboard-bff:$TAG}
export PORT=${PORT:-8081}


# DIR=$(cd `dirname $0` && pwd)
# pushd $DIR

build() {
    docker build -f Dockerfile.local --tag $IMG .
}

clean() {
    [[ -f app.jar ]] && rm app.jar || echo ""
}

buildInDocker() {
    docker build -f Dockerfile.inDocker --tag $IMG .
}

buildLocally() {
    scala-cli --power package App.scala -o app.jar --assembly
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
    BRANCH=${BRANCH:-`git rev-parse --abbrev-ref HEAD`}

    echo "creating $APP to point at $BRANCH"
    
    argocd app create $APP \
    --repo https://github.com/aaronp/mfe.git \
    --path dashboard/server/k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace mfe \
    --sync-policy automated \
    --auto-prune \
    --self-heal \
    --revision $BRANCH
}