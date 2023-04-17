<!--
  testing some logic for an incremental game
  current capacity:
    click to increment by 1

    using base formula 2 * x^1.5 to increment cost on all things

    gen1 gives 1 currency per interval
    gen2 gives 2 currency per interval
    gen3 gives 3 currency per interval

    interval can be decremented by 50

-->

<!-- first the html -->
<h1> first pass incremental game logic :D </h1>

<p> current currency: {currency} </p>
<p> current interval: {updateInterval}</p>
<br>
<p> gen1 count: {gen1} </p>
<p> gen1 cost: {gen1Cost} </p>
<br>
<p> gen2 count: {gen2} </p>
<p> gen2 cost: {gen2Cost} </p>
<br>
<p> gen3 count: {gen3} </p>
<p> gen3 cost: {gen3Cost} </p>
<br>
<button on:click={incrementCurrency}> increment currency </button>


{#if currency >= gen1Cost}
   <button on:click={() => incrementGenerator("gen1")}> buy gen1 </button>
{/if}

{#if currency >= gen2Cost}
  <button on:click={() => incrementGenerator("gen2")}> buy gen 2 </button>
{/if}

{#if currency >= gen3Cost}
  <button on:click={() => incrementGenerator("gen3")}> buy gen 3</button>
{/if}

{#if currency >= intervalDecrementCost}
  <button on:click={decrementInterval}> decrease interval </button>
{/if}

<!-- then the css style tag -->
<style>

</style>

<!-- then the js script tag -->
<script>
  // variables are reactive by default
  let currency = 0;

  let updateInterval = 1000;
  let numIntervalChanges = 0;
  let intervalDecrementAmt = 50;
  let intervalDecrementCost = 1000;

  let gen1 = 0;
  let gen1Cost = 25;

  let gen2 = 0;
  let gen2Cost = 75;

  let gen3 = 0;
  let gen3Cost = 150;

  function incrementCurrency() {
    currency += 1;
  }

  // basic functionality, no increase on cost
  function incrementGenerator(generatorName) {
    
    switch (generatorName) {
      case "gen1":
        if (currency >= gen1Cost) {
          gen1++;
          currency -= gen1Cost;
          updateGeneratorCost("gen1");
        }
        break;

      case "gen2":
        if (currency >= gen2Cost) {
         gen2++;
         currency -= gen2Cost;
         updateGeneratorCost("gen2");
        }
        break;

      case "gen3":
        if (currency >= gen3Cost) {
          gen3++;
          currency -= gen3Cost;
          updateGeneratorCost("gen3");
        }
        break;
    
      default:
        break;
    }

  }

  function decrementInterval() {
    if (currency > intervalDecrementCost) {
      numIntervalChanges++;
      updateInterval -= intervalDecrementAmt;
      currency -= intervalDecrementCost;
      updateIntervalDecrementCost();
    }
  }

  function updateGeneratorCost(generatorName) {
    // using base function generatorCost = last generator cost + 2 * numGenerator ^ 1.5
    switch (generatorName) {
      case "gen1":
        gen1Cost = Math.ceil(2 * Math.pow(gen1, 1.5) + 25);
        break;

      case "gen2":
        gen2Cost = Math.ceil(2 * Math.pow(gen2, 1.5) + 75);
        break;

      case "gen3":
        gen3Cost = Math.ceil(2 * Math.pow(gen3, 1.5) + 150);
        break;
    
      default:
        break;
    }
  }

  function updateIntervalDecrementCost() {
    // using base function interval cost = last interval cost + 2 * numIntervalChanges ^ 1.5
    intervalDecrementCost = Math.ceil(2 * Math.pow(numIntervalChanges, 1.5) + 1000)
  }

  // hard coded generator interval (resolve every second)
  setInterval(() => {
    if (gen1 > 0) {
      currency += gen1;
    }
    if (gen2 > 0) {
      currency += 2 * gen2;
    }
    if (gen3 > 0) {
      currency += 3 * gen3;
    }
  }, updateInterval);

</script>
