#!/usr/env/bin bash
scala-cli --power package --docker HelloDocker.scala --docker-from openjdk:11 --docker-image-repository service-registry
