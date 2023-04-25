<!--
  testing some logic for an incremental game
  current capacity:
    click to increment by 1

    updating formula to be based on alexander formula:
    price = baseCost * multiplier ^ numberOwned 

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
<p> gen1 count: {gen1Owned} </p>
<p> gen1 cost: {gen1Cost} </p>
<br>
<p> gen2 count: {gen2Owned} </p>
<p> gen2 cost: {gen2Cost} </p>
<br>
<p> gen3 count: {gen3Owned} </p>
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

{#if currency >= intervalDecrementStartCost}
  <button on:click={decrementInterval}> decrease interval </button>
{/if}

<!-- then the css style tag -->
<style>

</style>

<!-- then the js script tag -->
<script>

  import { onMount } from "svelte";

  // variables are reactive by default
  let currency = 0;
  let updateInterval = 1000;
  
  let numIntervalChanges = 0;
  let intervalDecrementAmt = 50;
  let intervalDecrementStartCost = 1000;
  let intervalDecrementCost;

  let valueMultiplier = 1.15;

  let gen1Owned = 0;
  let gen1StartCost = 25;
  let gen1Cost;

  let gen2Owned = 0;
  let gen2StartCost = 75;
  let gen2Cost;

  let gen3Owned = 0;
  let gen3StartCost = 150;
  let gen3Cost;

  // SUDO START

  onMount(async () => {
    gen1Cost = gen1StartCost;
    gen2Cost = gen2StartCost;
    gen3Cost = gen3StartCost;
  })

  // SUDO UPDATE - COULD USE MORE WORK
  
  setInterval(() => {
    if (gen1Owned > 0) {
      currency += gen1Owned;
    }
    if (gen2Owned > 0) {
      currency += 2 * gen2Owned;
    }
    if (gen3Owned > 0) {
      currency += 3 * gen3Owned;
    }
  }, updateInterval);

  // HELPER FUNCTIONS


  function incrementCurrency() {
    currency += 1;
  }

  // basic functionality, no increase on cost
  function incrementGenerator(generatorName) {
    
    switch (generatorName) {
      case "gen1":
        if (currency >= gen1Cost) {
          gen1Owned++;
          currency -= gen1Cost;
          updateGeneratorCost("gen1");
        }
        break;

      case "gen2":
        if (currency >= gen2Cost) {
         gen2Owned++;
         currency -= gen2Cost;
         updateGeneratorCost("gen2");
        }
        break;

      case "gen3":
        if (currency >= gen3Cost) {
          gen3Owned++;
          currency -= gen3Cost;
          updateGeneratorCost("gen3");
        }
        break;
    
      default:
        break;
    }

  }

  function decrementInterval() {
    if (currency > intervalDecrementStartCost) {
      numIntervalChanges++;
      updateInterval -= intervalDecrementAmt;
      currency -= intervalDecrementStartCost;
      updateIntervalDecrementCost();
    }
  }

  function updateGeneratorCost(generatorName) {
    // using base function in above comment
    switch (generatorName) {
      case "gen1":
        gen1Cost = Math.ceil(gen1StartCost * Math.pow(valueMultiplier, gen1Owned))
        break;

      case "gen2":
        gen2Cost = Math.ceil(gen2StartCost * Math.pow(valueMultiplier, gen2Owned));
        break;

      case "gen3":
        gen3Cost = Math.ceil(gen3StartCost * Math.pow(valueMultiplier, gen3Owned));
        break;
    
      default:
        break;
    }
  }

  function updateIntervalDecrementCost() {
    // using base function interval cost = last interval cost + 2 * numIntervalChanges ^ 1.5
    intervalDecrementStartCost = Math.ceil(intervalDecrementStartCost * Math.pow(valueMultiplier, numIntervalChanges))
  }

</script>
