#!/usr/bin/env bash
export IMG=${IMG:-service-registry}


# scala-cli --power package --docker App.scala --docker-from openjdk:11 --docker-image-repository service-registry
docker build --tag $IMG .

echo "built $IMG"
echo
echo "run with:"
echo ""
echo "PORT=1234 && docker run -it --rm -p 1234:1234 -d $IMG:latest"
echo ""
echo "test with:"
echo ""
echo "curl -X POST -d '{\"webComponent\":{\"url\":\"dave\",\"component\":\"susan\"},\"label\":\"example\",\"tags\":[\"some\",\"app\"]}' http://localhost:1234/api/v1/registry/bar"
