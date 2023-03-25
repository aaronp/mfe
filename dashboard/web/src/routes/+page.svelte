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


    const url = (path) => new URL(path, `http://${window.location.host}`);

    const fetchComponent = async (id) => {
      const json = await fetch(url(`/api/component/${id}`)).then(data => {
        return data.json();
      });
      return json.service.webComponent.componentId;
    }

    const addComponent = async (comp) => {
      const id = comp.id;

      const componentHtml = await fetchComponent(id);

      dynamicLoad(url(`/api/component/${id}/bundle.js`), url(`/api/component/${id}/bundle.css`));

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
          <s>{i.label}</s><span class="stale">(last update was ({i.secondsSinceLastHeartbeat}) seconds ago)</span>
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
