//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require action_cable
//= require vue/vue
//= require vue-resource/vue-resource
//= require vue_csrf_token
//= require interact
//= require cocoon
//= require env
//= require_tree ./channels
//= require_tree ./models
//= require_tree ./components
//= require_self

App.cable = ActionCable.createConsumer();
App.bus = new Vue();

const onLoad = () => {
  document.body.addEventListener("click", (event) => {
    // Allows to open modals nested in dropdowns
    let isModalVisible = document.querySelectorAll('.modal-backdrop').length > 0;
    if (!isModalVisible) { App.bus.$emit("closeDropdowns"); }
  });

  new Vue({
    el: "#v-app"
  });
};

document.addEventListener("turbolinks:load", onLoad);
