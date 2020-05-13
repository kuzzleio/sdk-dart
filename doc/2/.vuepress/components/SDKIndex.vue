<template>
  <div class="Tiles">
    <a
      v-for="sdk in sdkList"
      :key="sdk.language + sdk.version"
      :href="`/sdk/${sdk.language}/${sdk.version}/`"
      class="Tiles-item"
    >
      <img :src="sdk.icon" :alt="`${sdk.language} logo`" class="Tiles-item-logo">
      <div class="Tiles-item-name">{{ sdk.name }}</div>
    </a>
  </div>
</template>

<script>
import { getItemLocalStorage } from '../util'
import sdks from '../sdk.json';

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
    sdkList() {
      const list = sdks[this.kuzzleMajor] || []

      return list.filter(item => item.language !== 'api')
    }
  }
}
</script>

<style>
</style>
