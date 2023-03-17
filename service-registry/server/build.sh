#!/usr/bin/env bash
export TAG=${TAG:-latest}
export IMG=${IMG:-porpoiseltd/service-registry:$TAG}
export PORT=${PORT:-8080}

# scala-cli --power package --docker App.scala --docker-from openjdk:11 --docker-image-repository service-registry


build() {
    docker build --tag $IMG .
}

run() {
    id=`docker run -it --rm -p $PORT:$PORT -d $IMG:latest`
    cat > kill.sh <<EOL
docker kill $id
# clean up after ourselves
rm kill.sh
EOL
    chmod +x kill.sh

    echo "Running on port $PORT --- stop server using ./kill.sh"
}