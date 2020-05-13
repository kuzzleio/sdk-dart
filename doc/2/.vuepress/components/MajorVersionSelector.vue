<template>
  <div class="selector selector-majorVersion" ref="selector" v-if="items.length">
    <div class="selector-selectedItem" @click="toggleList()" v-if="selectedItem">
      <div class="selector-selectedItem-name">
        {{ selectedItem.text }}
        <i class="fa fa-caret-down" aria-hidden="true"></i>
      </div>
    </div>
    <ul :class="`selector-list selector-list-${isListShowed? 'opened': 'closed'}` ">
      <li v-for="item in items" :key="item.value" class="selector-list-item" @click="toggleList()">
        <a class="selector-list-item-link" href="#" @click="onItemClick(item)">
          <span class="selector-list-item-name">{{ item.text }}</span>
        </a>
      </li>
    </ul>
  </div>
</template>

<script>
import { getItemLocalStorage, log } from '../util';

export default {
  data() {
    return {
      items: [
        { value: 1, text: 'Kuzzle v1.x' },
        { value: 2, text: 'Kuzzle v2.x' }
      ],
      selectedItem: {},
      isListShowed: false,
      kuzzleMajor: 2
    };
  },
  methods: {
    toggleList() {
      this.isListShowed = !this.isListShowed;
    },
    onDocumentClick(e) {
      const el = this.$refs.selector,
        target = e.target;

      if (el && el !== target && !el.contains(target)) {
        this.isListShowed = false;
      }
    },
    onItemClick(item) {
      this.selectedItem = item;
      this.$emit('change', item.value);
    }
  },
  mounted() {
    this.kuzzleMajor = getItemLocalStorage('kuzzleMajor') || 2;
    this.selectedItem = this.items.find(
      item => item.value === this.kuzzleMajor
    );

    document.addEventListener('click', this.onDocumentClick);
  }
};
</script>

<style lang="sass" scoped>
</style>
