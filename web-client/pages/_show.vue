<template>
  <a-layout>
    <a-layout-content>
      <section :style="{ padding: $mq === 'show' ? '50px' : '0', background: background, backgroundSize: 'cover' }">
        <a-card :style="{ background: '#fff', minHeight: '380px' }">
          <div style="display: flex">
            <div style="flex: 1">
              <h1>{{ show.title }}</h1>
            </div>
            <div>
              <a-button-group>
                <a-button icon="reload" size="large" />
              </a-button-group>
              <a-button icon="delete" type="danger" size="large" @click="deleteShow" />
            </div>
          </div>
          <p style="margin: 10px 0">{{ show.summary }}</p>
          <a-tabs @change="handleChange">
            <a-tab-pane key="info" tab="Info"></a-tab-pane>
            <a-tab-pane key="downloads" tab="Downloads">
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
            </a-tab-pane>
          </a-tabs>
        </a-card>
      </section>
    </a-layout-content>
  </a-layout>
</template>

<script>
export default {
  data() {
    return {
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
    const show = await $axios.$get(`/api/shows/${params.show}`);
    return {
      show: show.data
    };
  },
  methods: {
    async lookup() {
      if (this.show.external_id) {
        this.loading = true;
        const nzbs = await this.$axios.$get(`/api/nzbs/${this.show.id}`);
        this.downloads = nzbs.data;
        this.loading = false;
      }
    },
    async deleteShow() {
      await this.$axios.$delete(`/api/shows/${this.show.id}`);
      this.$router.go(-1);
    },
    handleChange(key) {
      if (this.downloads.length === 0 && key === 'downloads') {
        this.lookup();
      }
    }
  }
};
</script>

<style></style>
