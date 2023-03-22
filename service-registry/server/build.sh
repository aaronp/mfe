#!/usr/bin/env bash
export TAG=${TAG:-0.0.1}
export IMG=${IMG:-porpoiseltd/service-registry:$TAG}
export PORT=${PORT:-8080}

# scala-cli --power package --docker App.scala --docker-from openjdk:11 --docker-image-repository service-registry

build() {
    docker build --tag $IMG .
}

test() {
  echo "registering foo"
  curl -X POST -d '{"webComponent":{"jsUrl":"path/to/component.js","cssUrl":"path/to/component.css","componentId":"some-component"},"label":"some friendly label","tags":{"env":"prod","createdBy":"somebody"}}' http://localhost:$PORT/api/v1/registry/foo
  curl -X POST -d '{"webComponent":{"jsUrl":"another/server/bundle.js","cssUrl":"bundle.css","componentId":"another-component"},"label":"another label","tags":{"env":"prod"}}' http://localhost:$PORT/api/v1/registry/bar
  echo ""
  echo "getting foo:"
  curl -X GET http://localhost:$PORT/api/v1/registry/foo
  echo ""
  echo "listing result:"
  curl -X GET http://localhost:$PORT/api/v1/registry
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
    APP=${APP:-server-registry}
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
    --path service-registry/server/k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace mfe

    # beast mode :-)
    argocd app set $APP --sync-policy automated
    argocd app set $APP --auto-prune
    argocd app set $APP --self-heal
}