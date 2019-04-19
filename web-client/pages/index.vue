<template>
  <a-layout>
    <a-layout-sider breakpoint="lg" collapsed-width="0">
      <a-menu theme="dark">
        <a-menu-item>Movies</a-menu-item>
        <a-menu-item>TV</a-menu-item>
      </a-menu>
    </a-layout-sider>
    <a-layout-content>
      <section :style="{ background: '#fff', padding: '24px', minHeight: '380px' }">
        <a-list item-layout="vertical" :pagination="pagination" :data-source="collection">
          <a-list-item slot="renderItem" key="item.id" slot-scope="item">
            <a-list-item-meta :title="item.title" />
            <img slot="extra" alt="poster" :src="item.poster_url" width="150" />
            {{ item.summary }}
          </a-list-item>
        </a-list>
      </section>
    </a-layout-content>
  </a-layout>
</template>

<script>
export default {
  data() {
    return {
      pagination: {
        showTotal: (total, range) => {
          return `${total} items`;
        },
        pageSize: 20
      }
    };
  },
  computed: {
    collection() {
      return this.$store.state.collection.shows;
    }
  },
  fetch({ store }) {
    store.dispatch('collection/loadCollection');
  }
};
</script>

<style></style>
