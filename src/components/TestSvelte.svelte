<!-- first the html -->
<h1> testing svelte </h1>

<p> current count: {count} </p>

<button on:click={incrementCount}> increment count </button>

{#if count > 10}
   <button on:click={incrementGenerator}> buy a generator </button>
{/if}

<!-- then the css style tag -->
<style>

</style>

<!-- then the js script tag -->
<script>
  // variables are reactive by default
  let count = 0;
  let generator = 0;

  function incrementCount() {
    count++;
  }

  // basic functionality, no increase on cost
  function incrementGenerator() {
    if (count >= 10) {
      generator++;
      count -= 10;
    }
  }

  // hard coded generator interval
  setInterval(() => {
    if (generator > 0) {
      count += generator;
    }
  }, 3000);

</script>
