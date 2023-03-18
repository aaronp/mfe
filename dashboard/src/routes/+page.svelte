
<script>
    import { onMount } from "svelte";
    import { apiData, values } from './store.js';
    
    onMount(async () => {
      //fetch("https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Bourbon")
      fetch("http://localhost:8080/api/v1/registry")
      .then(response => response.json())
      .then(data => {
            console.log(data);
        apiData.set(data);
      }).catch(error => {
        console.log(error);
        return [];
      });
    });
</script>

<main>
    <h1>Services</h1>
    <ul>
    {#each $values as service}
        <li>{service}</li>
    {/each}
    </ul>

    <p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>
</main>

<style>

</style>
