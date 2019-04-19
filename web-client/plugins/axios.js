export default ({ store, app: { $axios } }) => {
  $axios.setToken('Bearer something');
};
