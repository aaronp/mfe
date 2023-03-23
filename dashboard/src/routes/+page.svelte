<script lang="typescript">
    import { onMount } from "svelte";
    import { apiData, values } from './store.js';
    import { dynamicLoad } from './dynamicload.js';
    

    /**
     * Questions:
     * 
     * $ is there a better way to do this - hard-code URLs?
     */
    // const serverReg = "http://localhost:8087/api/v1/registry";
    const serverReg = new URL("/api/v1/registry", "http://service-registry-service.mfe:8087");

    let container;


    onMount(async () => {
      fetch(serverReg)
      // fetch("https://service-registry-service.mfe:8080/api/v1/registry")
      .then(response => {
        console.log(serverReg + " returned " + response);
        return response.json();
      })
      .then(data => {
            console.log(data);
        apiData.set(data);
      }).catch(error => {
        console.log(error);
        return [];
      });
    });

    const addComponent = (comp) => {
      dynamicLoad(comp.service.webComponent.jsUrl, comp.service.webComponent.cssUrl);

      const child = document.createElement('span');
      child.innerHtml = comp.service.webComponent.componentId;
      container.appendChild(child);
    }

</script>

<main>
  <div id="page-container">
    
    <h1>Service</h1>
    <ul>
    {#each $values as i}
        <li><div>
          <a href="#" on:click={addComponent(i)}>{i.service.label}</a>
          <div>{i.id}</div>
          <div>last updated at ({i.lastUpdated})</div>
          </div>
        </li>
    {/each}
    </ul>

    <div bind:this={container}/>

    <footer id="footer">
      <p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>
    </footer>
  </div>
</main>

<style>
#page-container {
  position: relative;
  min-height: 100vh;
}

#content-wrap {
  padding-bottom: 2.5rem;    /* Footer height */
}

#footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 6.5rem;            /* Footer height */
}
</style>
