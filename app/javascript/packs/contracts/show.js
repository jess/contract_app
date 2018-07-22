// This is javscript code, which uses ERB tags for templating
// All the methods will be invoked and their values will be interpolated

import Vue from 'vue';
import ContractsShow from 'views/contracts/show';

const el = document.getElementById("contracts-show-view")
const app = new Vue({
  el,
  render: h => h(ContractsShow)
})
