<template>
  <a-layout :style="{ padding: $mq === 'show' ? '50px' : '0' }">
    <a-layout-content>
      <section :style="{ background: '#fff', padding: '24px', minHeight: '380px' }">
        <h1>{{ show.title }}</h1>
        <p>{{ show.summary }}</p>
        <a-list :loading="loading" item-layout="vertical" :pagination="pagination" :data-source="downloads">
          <a-list-item slot="renderItem" key="item.id" slot-scope="item">
            <a-list-item-meta>
              <span slot="title" style="word-break: break-all">{{ item.title }}</span>
            </a-list-item-meta>
            <a slot="actions" :href="item.link">
              <a-icon type="download" />
            </a>
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
    const show = await $axios.$get('/api/shows/' + params.show);
    // const nzbs = await $axios.$get(`/api/nzbs/${show.data.id}`);
    return {
      show: show.data,
      // downloads: nzbs.data
    };
  },
  created() {
    this.lookup();
  },
  methods: {
    async lookup() {
      this.loading = true;
      const nzbs = await this.$axios.$get(`/api/nzbs/${this.show.id}`);
      this.downloads = nzbs.data;
      this.loading = false;
    }
  }
};
</script>

<style></style>
