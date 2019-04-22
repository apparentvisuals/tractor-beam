<template>
  <a-layout>
    <a-layout-content>
      <section :style="{ padding: $mq === 'show' ? '50px' : '0', background: background }">
        <div :style="{ background: '#fff', padding: '24px', minHeight: '380px' }">
          <h4>{{ show.title }}</h4>
          <p>{{ show.summary }}</p>
          <a-menu mode="horizontal" :selected-keys="[current]" @click="handleClick">
            <a-menu-item key="info">Info</a-menu-item>
            <a-menu-item key="downloads">Downloads</a-menu-item>
          </a-menu>
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
        </div>
      </section>
    </a-layout-content>
  </a-layout>
</template>

<script>
export default {
  data() {
    return {
      current: 'info',
      downloads: [],
      loading: false,
      pagination: {
        showTotal: (total, range) => {
          return `${total} items`;
        },
        pageSize: 20
      },
      show: null
    };
  },
  computed: {
    background() {
      if (this.show && this.show.backdrop_url) {
        return '#f0f2f5 url("' + this.show.backdrop_url + '")';
      } else {
        return '#f0f2f5';
      }
    }
  },
  async asyncData({ $axios, params }) {
    const show = await $axios.$get('/api/shows/' + params.show);
    return {
      show: show.data
    };
  },
  methods: {
    async lookup() {
      this.loading = true;
      const nzbs = await this.$axios.$get(`/api/nzbs/${this.show.id}`);
      this.downloads = nzbs.data;
      this.loading = false;
    },
    handleClick(e) {
      this.current = e.key;
      if (this.downloads.length === 0 && e.key === 'downloads') {
        this.lookup();
      }
    }
  }
};
</script>

<style></style>
