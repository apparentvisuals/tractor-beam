<template>
  <a-layout :style="{ padding: $mq === 'show' ? '50px' : '0' }">
    <a-layout-content>
      <section :style="{ background: '#fff', padding: '24px', minHeight: '380px' }">
        <h1>{{ show.title }}</h1>
        <p>{{ show.summary }}</p>
        <a-list item-layout="vertical" :pagination="pagination" :data-source="downloads">
          <a-list-item slot="renderItem" key="item.id" slot-scope="item">
            <a-list-item-meta>
              <n-link slot="title" :to="{ name: 'show', params: { show: item.id } }">{{ item.title }}</n-link>
              <span slot="description">{{ item.summary }}</span>
            </a-list-item-meta>
            <img slot="extra" alt="poster" :src="item.poster_url" width="150" />
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
      current: 'downloads',
      downloads: [],
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
  async asyncData({ $axios, params }) {
    const result = await $axios.$get('/api/shows/' + params.show);
    return {
      show: result.data
    };
  }
};
</script>

<style></style>
