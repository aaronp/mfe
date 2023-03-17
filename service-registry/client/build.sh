#!/usr/bin/env bash
export IMG=${IMG:-service-registry-client}
export HOSTPORT=${HOSTPORT:-"http://localhost:8080"}
export ID=${ID:-foo}
export BODY=${BODY:-"{\"webComponent\":{\"url\":\"dave\",\"component\":\"susan\"},\"label\":\"example\",\"tags\":[\"some\",\"app\"]}\"}"

# scala-cli --power package --docker App.scala --docker-from openjdk:11 --docker-image-repository service-registry

build() {
    docker build --tag $IMG .
}

run() {
    docker run --rm -env HOST --env ID --env BODY -d $IMG:latest
}