<template>
  <a-layout id="layout-root">
    <a-layout-header :style="{ position: 'fixed', zIndex: 1, width: '100%' }">
      <div class="logo" :style="{ paddingLeft: '50px', float: 'right' }">
        <a-button type="primary" icon="plus" @click="addToLibrary">
          Add
        </a-button>
      </div>
      <a-menu theme="dark" mode="horizontal" :style="{ lineHeight: '64px' }" :selected-keys="[current]" :default-selected-keys="['1']" @click="handleClick">
        <a-menu-item key="1">Library</a-menu-item>
        <a-menu-item key="2">Settings</a-menu-item>
      </a-menu>
    </a-layout-header>
    <a-layout-content
      :style="{
        padding: this.$mq === 'show' ? '24px' : '0',
        marginTop: '64px'
      }"
    >
      <nuxt />
    </a-layout-content>
    <add-form :visible="addVisible" @close="close"></add-form>
  </a-layout>
</template>

<script>
import AddForm from '../components/AddForm.vue';

export default {
  components: { AddForm },
  data() {
    return {
      current: '1',
      addVisible: false
    };
  },
  methods: {
    addToLibrary() {
      this.addVisible = true;
    },
    handleClick(e) {
      this.current = e.key;
    },
    close() {
      this.addVisible = false;
    }
  }
};
</script>

<style>
body {
  background: #f0f2f5;
}
</style>
