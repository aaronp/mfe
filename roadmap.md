
## Roadmap

 - [x] build server
 - [x] build client

 - [x] K8S for server
 - [x] Create dashboard host app
 - [x] K8s for dashboard app using server-registry


### Milestone 1
 - [x] Create MFE Svelte web-component
 - [x] K8S for ^^^^ using server-registry client <-- first client usage / sidecar
 - [x] Test to load ^^^ from dashboard (hard-coded, test site) using localhost port-forward
    (see components/pinot-example/web/test/dynamic-test.html)

### Milestone 2
 - [x] connect the dots - get the dashboard to display the web component
   - [x] fix the object response for service registry
   - [x] add service-registry client to the components/pinot-example/web/k8s as a side-car
   - [x] change 'url' to 'js' and 'css' urls
   - [x] update the dashboard to use the new service-registry contract
   - [x] display some kind of drop-down or lists

### Milestone 3
 - [ ] Add a pinot componenet

# Further work: other components ideas
 - [ ] add an "OpenAPI", contract-first (cask?) app?
 - [ ] a WebSocket dashboard
 - [ ] a GraphQL data source

 ...
 - [ ] other frameworks for web-components (react, vue, nextjs, ...)

# Nice-to-have
 [x] local argocd options
 [ ] CI/CD for publishing to docker from github (TODO - see [here](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images))
     - for now we'll just do this locally
