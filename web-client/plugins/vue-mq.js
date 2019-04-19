import Vue from 'vue';
import VueMq from 'vue-mq';

export default () => {
  Vue.use(VueMq, {
    breakpoints: {
      hide: 992,
      show: Infinity
    },
    defaultBreakpoint: 'hide'
  });
};
