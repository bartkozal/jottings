//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require action_cable
//= require vue/vue
//= require vue-resource/vue-resource
//= require vue_csrf_token
//= require interact
//= require_tree ./channels
//= require_tree ./models
//= require_tree ./components
//= require_self

this.App = {
  cable: ActionCable.createConsumer(),
  bus: new Vue(),
  editor: null
};

const onLoad = () => {
  document.body.addEventListener("click", () => {
    // Fix for modals nested in dropdowns i.e. renaming stack modal
    let isModalVisible = document.querySelectorAll('.modal-backdrop').length > 0;
    if (!isModalVisible) { App.bus.$emit("closeDropdowns"); }
  });

  new Vue({
    el: "#v-app"
  });
};

document.addEventListener("turbolinks:load", onLoad);
