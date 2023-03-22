# About

A client for our noddy service registry


See the [Makefile](./Makefile) for build targets.e.g:

```
make run

make test
```

You could run the image locally using:

```
docker run \
 -e ID=foo \
 -e HOSTPORT=http://localhost:8080 \
 -e BODY='{"webComponent":{"jsUrl":"path/to/component.js","cssUrl":"path/to/component.css","componentId":"some-component"},"label":"some friendly label","tags":{"env":"prod","createdBy":"somebody"}}' \
 -e FREQUENCY_IN_SECONDS=1 \
 --rm \
 --name client-test \
 --network host \
 porpoiseltd/service-registry-client:0.0.2
 ```