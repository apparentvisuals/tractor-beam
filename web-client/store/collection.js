export const state = () => ({
  shows: [],
  idIndex: {}
});

export const mutations = {
  ADD_SHOW(state, show) {
    state.shows.push(show);
    state.idIndex[show.external_id] = show.external_source;
  },
  REMOVE_SHOW(state, show) {
    state.shows.$remove(show);
  },
  RELOAD_SHOW(state, { shows, idIndex }) {
    state.shows = shows;
    state.idIndex = idIndex;
  }
};

export const actions = {
  async loadCollection({ commit }) {
    const result = await this.$axios.$get('/api/shows');
    const idIndex = result.data.reduce((acc, value) => {
      acc[value.external_id] = value.external_source;
      return acc;
    }, {});
    commit('RELOAD_SHOW', { shows: result.data, idIndex });
  },
  async addShow({ commit }, show) {
    const result = await this.$axios.$post('/api/shows', { show });
    commit('ADD_SHOW', result.data);
  }
};
