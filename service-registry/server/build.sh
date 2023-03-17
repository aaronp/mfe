#!/usr/bin/env bash
export IMG=${IMG:-service-registry}
export PORT=${PORT:-8080}


# scala-cli --power package --docker App.scala --docker-from openjdk:11 --docker-image-repository service-registry


build() {
    echo "building $IMG ..."
    docker build --tag $IMG .
    echo "built $IMG"
}

run() {
    id=`docker run -it --rm -p $PORT:$PORT -d $IMG:latest`
    echo "Running on port $PORT"
    echo "stop using ./kill.sh"
    cat > kill.sh <<EOL
docker kill $id
# clean up after ourselves
rm kill.sh
EOL
    chmod +x kill.sh
}

test() {
    echo
    echo "run with:"
    echo ""
    echo "docker run -it --rm -p $PORT:$PORT -d $IMG:latest"
    echo ""
    echo "test with:"
    echo ""
    echo "curl -X POST -d '{\"webComponent\":{\"url\":\"dave\",\"component\":\"susan\"},\"label\":\"example\",\"tags\":[\"some\",\"app\"]}' http://localhost:$PORT/api/v1/registry/bar"
}
