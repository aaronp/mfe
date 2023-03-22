# Micro-Frontend Example

This repo is an implementation of [Micro Fontends](https://micro-frontends.org/) on Kubernetes.

It's an example of analytics platform which consists of:
 * A dashboard
 * A service registry (data discovery)
 * Various micro-front-ends to show elements in the dashboard

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
 - [ ] connect the dots - get the dashboard to display the web component
   - [x] fix the object response for service registry
   - [x] add service-registry client to the components/pinot-example/web/k8s as a side-car
   - [x] change 'url' to 'js' and 'css' urls
   - [ ] update the dashboard to use the new service-registry contract
   - [ ] display some kind of drop-down
e

### Milestone 3
 - [ ] Add a pinot componenet
 - [ ] Create BFF REST client (w/ some test data)
 - [ ] Have our component talk to our BFF to see the data

# Further work: other components ideas
 - [ ] an "OpenAPI", contract-first (cask?) app?
 - [ ] a Apache Pinot source
 - [ ] a WebSocket dashboard
 - [ ] a GraphQL data source

 ...
 - [ ] other frameworks for web-components (react, vue, nextjs, ...)

# Nice-to-have
 [x] local argocd options
 [ ] CI/CD for publishing to docker from github (TODO - see [here](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images))
     - for now we'll just do this locally

# Components


## Component One - a pinot data source stub