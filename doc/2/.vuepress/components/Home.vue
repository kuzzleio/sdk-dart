<template>
  <div>
    <h2>What is Kuzzle</h2>
    <p>
      Kuzzle is a ready-to-use, open-source, on-premises suite that allows you to build modern web,
      mobile and IoT applications in no time.
    </p>

    <h2>Learn more about Kuzzle now</h2>
    <div class="Tiles">
      <a :href="getPath('/guides/getting-started/running-kuzzle/')" class="Tiles-item medium">
        <img src="/logos/rocket.svg" alt="Running Kuzzle logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Running Kuzzle</div>
      </a>
      <a :href="getPath('/api/essentials/connecting-to-kuzzle/')" class="Tiles-item medium">
        <img src="/logos/search.svg" alt="Explore API logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Explore API</div>
      </a>
      <a href="/sdk/" class="Tiles-item medium">
        <img src="/logos/brackets.svg" alt="SDK logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Find your SDK</div>
      </a>
      <a :href="getPath('/guides/essentials/admin-console/')" class="Tiles-item medium">
        <img src="/logos/tools.svg" alt="Admin console logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Admin console</div>
      </a>
      <a :href="getPath('/guides/essentials/configuration/')" class="Tiles-item medium">
        <img src="/logos/settings.svg" alt="Configure Kuzzle logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Configure Kuzzle</div>
      </a>
      <a href="/official-plugins/" class="Tiles-item medium">
        <img src="/logos/plugin.svg" alt="Plugins logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Plugins</div>
      </a>
      <a :href="getPath('/guides/essentials/introduction/')" class="Tiles-item medium">
        <img src="/logos/book.svg" alt="More guides logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">More guides</div>
      </a>
    </div>
  </div>
</template>

<script>

import { getItemLocalStorage } from '../util'

export default {
  data () {
    return {
      kuzzleMajor: '2'
    }
  },
  mounted () {
    this.kuzzleMajor = getItemLocalStorage('kuzzleMajor') || '2'
  },
  methods: {
    getPath (path) {
      return `/core/${this.kuzzleMajor}${path}`
    }
  }
}

</script>

<style>
</style>
