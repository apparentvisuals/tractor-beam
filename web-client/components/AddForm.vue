<template>
  <a-modal
    theme="dark"
    :visible="visible"
    title="Search"
    okText="Close"
    @cancel="close"
    :footer="null"
    width="90%"
  >
    <a-input-search placeholder="show name" @search="search" v-model="name">
      <a-select slot="addonBefore" defaultValue="movie" v-model="type">
        <a-select-option value="movie">Movie</a-select-option>
        <a-select-option value="tv">TV</a-select-option>
      </a-select>
    </a-input-search>
    <a-list :loading="loading" itemLayout="vertical" :pagination="pagination" :dataSource="results">
      <a-list-item slot="renderItem" slot-scope="item" key="item.id">
        <img slot="extra" alt="poster" :src="item.poster_url">
        <a-list-item-meta :title="item.title" :description="item.summary"></a-list-item-meta>
      </a-list-item>
    </a-list>
  </a-modal>
</template>

<script>
export default {
  props: ['visible'],
  data() {
    return {
      type: 'movie',
      name: null,
      loading: false,
      results: [],
      pagination: {
        onChange: page => {
          this.search(page)
        },
        showTotal: (total, range) => {
          return `${total} items`;
        },
        total: 0,
        pageSize: 20
      }
    }
  },
  methods: {
    async search(page = 1) {
      this.loading = true
      const result = await this.$axios.get('/api/search', {
        params: {
          type: this.type,
          name: this.name,
          page: page
        }
      })
      this.results = result.data.data
      this.pagination.total = result.data.total
      this.loading = false
    },
    close() {
      this.results = []
      this.pagination.total = 0
      this.loading = false
      this.$emit('close')
    }
  }
}
</script>


<style></style>
