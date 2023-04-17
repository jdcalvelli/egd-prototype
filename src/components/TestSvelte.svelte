<!-- first the html -->
<h1> testing svelte </h1>

<p> current count: {count} </p>

<button on:click={incrementCount}> increment count </button>

<!-- then the css style tag -->
<style>

</style>

<!-- then the js script tag -->
<script>
  // variables are reactive by default
  let count = 0;
  function incrementCount() {
    count++;
  }
</script>
