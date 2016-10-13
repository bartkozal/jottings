//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require vue/vue
//= require_tree ./components
//= require cable
//= require_self

$(document).on("turbolinks:load", () => {
  new Vue({
    el: "#v-app"
  });
});
