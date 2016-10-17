//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require vue/vue
//= require_tree ./components
//= require_self
//= require cable

this.App = {};

const onLoad = () => {
  App.vue = new Vue({
    el: "#v-app"
  });
};

document.addEventListener("turbolinks:load", onLoad);
