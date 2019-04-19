<template>
  <a-modal :visible="visible" :footer="null" theme="dark" title="Search" ok-text="Close" width="90%" @cancel="close">
    <a-input-search v-model="name" placeholder="show name" @search="search">
      <a-select slot="addonBefore" v-model="type" default-value="movie">
        <a-select-option value="movie">Movie</a-select-option>
        <a-select-option value="tv">TV</a-select-option>
      </a-select>
    </a-input-search>
    <a-list :loading="loading" item-layout="vertical" :pagination="pagination" :data-source="results">
      <a-list-item slot="renderItem" key="item.id" slot-scope="item">
        <a-list-item-meta :title="item.title" />
        <img slot="extra" alt="poster" :src="item.poster_url" width="154" />
        <a-button v-if="idIndex[item.id] === 'tmdb'" slot="actions" icon="check" disabled>Added</a-button>
        <a-button v-else slot="actions" type="primary" icon="plus" @click="add(item)">
          Add
        </a-button>
        {{ item.summary }}
      </a-list-item>
    </a-list>
  </a-modal>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  props: {
    visible: Boolean
  },
  data() {
    return {
      type: 'movie',
      name: null,
      loading: false,
      results: [],
      pagination: {
        onChange: page => {
          this.search(page);
        },
        showTotal: (total, range) => {
          return `${total} items`;
        },
        total: 0,
        pageSize: 20
      }
    };
  },
  computed: {
    idIndex() {
      return this.$store.state.collection.idIndex;
    }
  },
  methods: {
    async search(page = 1) {
      this.loading = true;
      const result = await this.$axios.$get('/api/search', {
        params: {
          type: this.type,
          name: this.name,
          page: page
        }
      });
      this.results = result.data;
      this.pagination.total = result.total;
      this.loading = false;
    },
    close() {
      this.results = [];
      this.pagination.total = 0;
      this.loading = false;
      this.$emit('close');
    },
    add(item) {
      const show = {
        type: this.type,
        title: item.title,
        summary: item.summary,
        poster_url: item.poster_url,
        external_id: item.id,
        external_source: 'tmdb'
      };
      this.addShow(show);
    },
    ...mapActions({
      addShow: 'collection/addShow'
    })
  }
};
</script>

<style>
.poster {
  width: 100px;
  height: 150px;
  text-align: center;
}
</style>
