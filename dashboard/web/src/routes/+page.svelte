<script lang="typescript">
    import { onMount } from "svelte";
    import { apiData, values } from './store.js';
    import { dynamicLoad } from './dynamicload.js';
    

    /**
     * Questions:
     * 
     * $ is there a better way to do this - hard-code URLs?
     */
    const dashboardHost = "http://localhost:8081";
    //const dashboardHost = "http://dashboard-bff-service.mfe:8080";

    let container;

    onMount(async () => {
      fetch(new URL("/component", dashboardHost))
      .then(response => { return response.json(); })
      .then(data => {
        apiData.set(data);
      }).catch(error => {
        console.log(error);
        return [];
      });
    });

    const fetchComponent = async (id) => {
      const url = new URL(`/component/${id}`, dashboardHost);
      const future = fetch(url).then(data => {
        return data.json();
      })
      const json = await future;
      const componentHtml = json.service.webComponent.componentId;
      return componentHtml;
    }

    const addComponent = async (comp) => {

      const id = comp.id;
      const jsUrl = new URL(`/component/${id}/bundle.js`, dashboardHost);
      const cssUrl = new URL(`/component/${id}/bundle.css`, dashboardHost);

      const componentHtml = await fetchComponent(id);

      dynamicLoad(jsUrl, cssUrl);

      const child = document.createElement('span');
      container.innerHTML = componentHtml;
    }

</script>

<main>
  <div id="page-container">
    
    {#if values.length == 1}<h1>One Service</h1>{:else}<h1>{$values.length} Services</h1>{/if}
    
    <ul>
    {#each $values as i}
        <li><div>
          {#if i.isStale}
          <span>{i.label}</span>
          <span class="stale">(component is stale: is was last updated ({i.secondsSinceLastHeartbeat}) seconds ago)</span>
          {:else}
            <a href="#" on:click={addComponent(i)}>{i.label}</a>
          {/if}
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

.stale {
  color :red
}
#footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 6.5rem;            /* Footer height */
}
</style>
