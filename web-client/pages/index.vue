<template>
  <a-layout :style="{ padding: $mq === 'show' ? '50px' : '0' }">
    <a-layout-content>
      <a-menu mode="horizontal" :selected-keys="[current]" @click="handleClick">
        <a-menu-item key="all">All</a-menu-item>
        <a-menu-item key="movie">Movies</a-menu-item>
        <a-menu-item key="tv">TV</a-menu-item>
        <a-menu-item key="music">Music</a-menu-item>
        <a-menu-item key="comic">Comic</a-menu-item>
      </a-menu>
      <section :style="{ background: '#fff', padding: '24px', minHeight: '380px' }">
        <a-list item-layout="vertical" :pagination="pagination" :data-source="collection">
          <a-list-item slot="renderItem" key="item.id" slot-scope="item">
            <a-list-item-meta>
              <n-link slot="title" :to="{ name: 'show', params: { show: item.id } }">{{ item.title }}</n-link>
              <span slot="description">{{ item.summary }}</span>
            </a-list-item-meta>
            <img slot="extra" alt="poster" :src="item.poster_url" width="92" />
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
      current: 'all',
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
      return this.$store.state.collection.shows.filter(show => show.type === this.current || this.current === 'all');
    }
  },
  fetch({ store }) {
    store.dispatch('collection/loadCollection');
  },
  methods: {
    handleClick(e) {
      this.current = e.key;
    }
  }
};
</script>

<style></style>
