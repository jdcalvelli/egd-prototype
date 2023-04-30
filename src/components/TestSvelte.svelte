<!--
  incremental game logic
  current capacity:
    click to increment by increment amount

    updating formula to be based on alexander formula:
    price = baseCost * multiplier ^ numberOwned 

    gen1 gives 1 currency per gen
    gen2 gives 2 currency per gen
    gen3 gives 4 currency per gen
    gen4 gives 8 currency per gen
    gen5 gives 16 currency per gen
    gen6 gives 32 currency per gen

    interval can be decremented by 50, until hitting 500

-->

<!-- first the html -->

<div class="info">
  <h3> work completed: {currency} </h3>
  {#if gen1Owned > 0}
    <p> automated work per tick: {1 * gen1Owned + 2 * gen2Owned + 4 * gen3Owned + 8 * gen4Owned + 16 * gen5Owned + 32 * gen6Owned} </p>
    <p> automated work tick speed: {updateInterval}</p>
  {/if}
</div>

<div class="globals">
  <button on:click={incrementCurrency}>{#if gen6Owned == 0} do work {:else} do work? why bother? you've been replaced. {/if}</button>
  {#if currency >= intervalDecrementStartCost && updateInterval > 500}
    <button on:click={decrementInterval}> automate work faster (cost: {intervalDecrementCost}) </button>
  {/if}
</div>

<div class="genContainer">
  
  {#if currency >= gen1StartCost || gen1Owned >= 1}
    <div class="gen">
      <p> steam engines: {gen1Owned} </p>
      <p> cost: {gen1Cost} </p>
      {#if currency >= gen1Cost}
         <button on:click={() => incrementGenerator("gen1")}> buy steam engine </button>
      {/if}
    </div>
  {/if}
  
  {#if gen1Cost >= gen2StartCost}
    <div class="gen">
      <p> assembly lines: {gen2Owned} </p>
      <p> cost: {gen2Cost} </p>
      {#if currency >= gen2Cost}
        <button on:click={() => incrementGenerator("gen2")}> buy assembly line </button>
      {/if}
    </div>
  {/if}
  
  {#if gen2Cost >= gen3StartCost}
    <div class="gen">
      <p> computers: {gen3Owned} </p>
      <p> cost: {gen3Cost} </p>
      {#if currency >= gen3Cost}
        <button on:click={() => incrementGenerator("gen3")}> buy computer </button>
      {/if}
    </div>
  {/if}
  
  {#if gen3Cost >= gen4StartCost}
    <div class="gen">
      <p> machine learning models: {gen4Owned} </p>
      <p> cost: {gen4Cost} </p>
      {#if currency >= gen4Cost}
        <button on:click={() => incrementGenerator("gen4")}> buy ml model </button>
      {/if}
    </div>
  {/if}
  
  {#if gen4Cost >= gen5StartCost}
    <div class="gen">
      <p> large language models: {gen5Owned} </p>
      <p> cost: {gen5Cost} </p>
      {#if currency >= gen5Cost}
        <button on:click={() => incrementGenerator("gen5")}> buy ll model </button>
      {/if}
    </div>
  {/if}
  
  {#if gen5Cost >= gen6StartCost}
    <div class="gen">
      <p> digital overlords: {gen6Owned} </p>
      <p> cost: {gen6Cost} </p>
      {#if currency >= gen6Cost}
        <button on:click={() => incrementGenerator("gen6")}> buy digital overlord </button>
      {/if}
    </div>
  {/if}

</div>

<!-- then the css style tag -->
<style>
  
  .globals {
    padding-bottom: 64px;
  }
  
  .globals {
    display: flex;
    gap: 16px;
  }
  .genContainer {
    display: flex;
    gap: 16px;
    
    height: 128px;
    width: 100%;
  }
  .gen {
    padding: 8px;
    border: 2px solid black;
    
    height: 100%;
    width: 12%;
  }
</style>

<!-- then the js script tag -->
<script>

  import { onMount } from "svelte";

  // variables are reactive by default
  let currency = 0;
  let updateInterval = 1000;
  
  let incrementAmount = 1;
  
  let numIntervalChanges = 0;
  let intervalDecrementAmt = 50;
  let intervalDecrementStartCost = 2048;
  let intervalDecrementCost;

  let valueMultiplier = 1.2;

  let gen1Owned = 0;
  let gen1StartCost = 32;
  let gen1Cost;

  let gen2Owned = 0;
  let gen2StartCost = 64;
  let gen2Cost;

  let gen3Owned = 0;
  let gen3StartCost = 128;
  let gen3Cost;
  
  let gen4Owned = 0;
  let gen4StartCost = 256;
  let gen4Cost;
  
  let gen5Owned = 0;
  let gen5StartCost = 512;
  let gen5Cost;
  
  let gen6Owned = 0;
  let gen6StartCost = 1024;
  let gen6Cost;

  // SUDO START

  onMount(async () => {
    gen1Cost = gen1StartCost;
    gen2Cost = gen2StartCost;
    gen3Cost = gen3StartCost;
    gen4Cost = gen4StartCost;
    gen5Cost = gen5StartCost;
    gen6Cost = gen6StartCost;
    
    intervalDecrementCost = intervalDecrementStartCost;
    
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
      currency += 4 * gen3Owned;
    }
    if (gen4Owned > 0) {
      currency += 8 * gen4Owned;
    }
    if (gen5Owned > 0) {
      currency += 16 * gen5Owned;
    }
    if (gen6Owned > 0) {
      currency += 32 * gen6Owned;
    }
  }, updateInterval);

  // HELPER FUNCTIONS


  function incrementCurrency() {
    currency += incrementAmount;
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
        
      case "gen4":
        if (currency >= gen4Cost) {
          gen4Owned++;
          currency -= gen4Cost;
          updateGeneratorCost("gen4");
        }
        
      case "gen5":
        if (currency >= gen5Cost) {
          gen5Owned++;
          currency -= gen5Cost;
          updateGeneratorCost("gen5");
        }
        break;
      
      case "gen6":
      if (currency >= gen6Cost) {
        gen6Owned++;
        currency -= gen6Cost;
        updateGeneratorCost("gen6");
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
        
      case "gen4":
        gen4Cost = Math.ceil(gen4StartCost * Math.pow(valueMultiplier, gen4Owned));
        break;
        
      case "gen5":
        gen5Cost = Math.ceil(gen5StartCost * Math.pow(valueMultiplier, gen5Owned));
        break;
        
      case "gen6":
        gen6Cost = Math.ceil(gen6StartCost * Math.pow(valueMultiplier, gen6Owned));
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
