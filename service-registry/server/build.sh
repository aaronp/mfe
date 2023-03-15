#!/usr/bin/env bash
export IMG=${IMG:-service-registry}
scala-cli --power package --docker App.scala --docker-from openjdk:11 --docker-image-repository service-registry

echo "built $IMG"
echo "run with:"
echo "PORT=1234 && docker run -it --rm -name service-registry -p $PORT:$PORT $IMG:latest"
