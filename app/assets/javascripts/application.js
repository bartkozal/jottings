//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require vue/vue
//= require_tree ./components
//= require cable
//= require_self

const onLoad = () => {
  new Vue({
    el: "#v-app"
  });
};

document.addEventListener("turbolinks:load", onLoad);
