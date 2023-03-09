# Objective
To demonstrate a low barrier-to-entry for getting a new data-source/visualisation into production


## Why?
As an example of an architecture which addresses the DevX eng goals of:
 * low learning curve
 * observability
 * single-responsibility principle -- leading to confidence in delivery
 * doupled/independent domain-driven-design

# MVP

Note: each component in this demo should be dead-simple, directly reproducible from the "hello-world" on whatever tech it's using


## Service Registry
This could be Istio, Linkerd, some other service mesh.

For simplicity/transparency this is its own, dead simple service consisting of:

### An in-memory service-registry

### A side-car client used by other compontents which can register/POST to the service-registry


### Spec:

POST /api/v1/registry/:id
{
    "web-component" : {
        "url" : "...",
        "component-id" : "..."
    }
    label : "friendly name",
    tags : []
}

GET /api/v1/registry

## Skeleton Dashboard
This is where the various services can be listed and displayed

*Stretch Goal:*
Demonstrate an event-driven architecture - e.g. a user selects a date-range on one component which is reflected in another

This dashboard is a client of the service registry, listing and displaying the components

## An example service / web-component

This uses the service registry side-car
It also talks to its own back-end

This is the most basic hello-world svelte app (or react, or whatever)
