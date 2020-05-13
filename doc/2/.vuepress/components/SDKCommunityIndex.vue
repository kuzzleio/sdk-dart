<template>
  <div v-if="kuzzleMajor.toString() === '1'">
    <h3>Community SDKs</h3>
    <span> the SDKs handcrafted by the community:</span>

    <div class="Tiles">
      <a href="https://github.com/prijindal/kuzzle_dart" class="Tiles-item min">
        <img src="/logos/dart.svg" alt="dart logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Dart</div>
      </a>
      <a href="https://github.com/alexandrebouthinon/kuzzle-sdk-rust" class="Tiles-item min">
        <img src="/logos/rust.svg" alt="rust logo" class="Tiles-item-logo">
        <div class="Tiles-item-name">Rust</div>
      </a>
    </div>
    <span>Do not hesitate to contact us or come on our <a href="https://gitter.im/kuzzleio/kuzzle" target="_blank">gitter chat</a> to add your contribution to this list.</span>
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
    console.log(this.kuzzleMajor)
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
