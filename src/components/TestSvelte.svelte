<!-- first the html -->
<h1> testing svelte </h1>

<p> current currency: {currency} </p>
<p> generator count: {generator} </p>
<p> generator cost: {generatorCost} </p>

<button on:click={incrementCurrency}> increment currency </button>

{#if currency > 10}
   <button on:click={incrementGenerator}> buy a generator </button>
{/if}

<!-- then the css style tag -->
<style>

</style>

<!-- then the js script tag -->
<script>
  // variables are reactive by default
  let currency = 0;
  let generator = 0;
  let generatorCost = 10;

  function incrementCurrency() {
    currency++;
  }

  // basic functionality, no increase on cost
  function incrementGenerator() {
    if (currency >= generatorCost) {
      generator++;
      currency -= generatorCost;
      updateGeneratorCost();
    }
  }

  function updateGeneratorCost() {
    // using function generatorCost = numGenerator ^ 1.5 + 10
    generatorCost = Math.ceil(Math.pow(generator, 1.5) + 10);
  }

  // hard coded generator interval
  // should probably change this to requestAnimationFrame
  // bc right now it can be blocked by other activities on main thread
  setInterval(() => {
    if (generator > 0) {
      currency += generator;
    }
  }, 1000);

</script>
