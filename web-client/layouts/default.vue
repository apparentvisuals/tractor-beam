<template>
  <a-layout id="layout-root">
    <a-layout-header :style="{ padding: $mq === 'show' ? '0 50px' : '0 24px', position: 'fixed', zIndex: 1, width: '100%' }">
      <div :style="{ float: 'right' }">
        <a-button type="primary" icon="plus" @click="addToLibrary">
          Add
        </a-button>
      </div>
      <a-menu theme="dark" mode="horizontal" :style="{ lineHeight: '64px' }" :selected-keys="[current]" @click="handleClick">
        <a-menu-item key="library">Library</a-menu-item>
        <a-menu-item key="settings">Settings</a-menu-item>
      </a-menu>
    </a-layout-header>
    <a-layout-content :style="{ marginTop: '64px' }">
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
      current: 'library',
      addVisible: false
    };
  },
  methods: {
    addToLibrary() {
      this.addVisible = true;
    },
    handleClick(e) {
      this.current = e.key;
      switch (e.key) {
        case 'library':
          this.$router.push('/');
          break;
        case 'settings':
          break;
      }
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
