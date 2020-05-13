<template>
  <div class="Tiles">
    <a
      v-for="plugin in pluginList"
      :key="plugin.name + plugin.version"
      :href="plugin.url"
      class="Tiles-item"
    >
      <img :src="plugin.icon" :alt="plugin.iconAlt" class="Tiles-item-logo">
      <div class="Tiles-item-name">{{ `${plugin.name} v${plugin.version}.x` }}</div>
    </a>
  </div>
</template>

<script>
import { getItemLocalStorage } from '../util'
import plugins from '../plugins.json';

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
  },
  computed: {
    pluginList() {
      return plugins[this.kuzzleMajor] || []
    }
  }
}
</script>

<style>
</style>
