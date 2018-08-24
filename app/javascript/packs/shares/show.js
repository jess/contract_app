// This is javscript code, which uses ERB tags for templating
// All the methods will be invoked and their values will be interpolated

import Vue from 'vue';
import SharesShow from 'views/shares/show';

const el = document.getElementById("shares-show-view")
const app = new Vue({
  el,
  render: h => h(SharesShow)
})
