//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require action_cable
//= require vue/vue
//= require_tree ./channels
//= require_tree ./models
//= require_tree ./components
//= require_self

this.App = {
  cable: ActionCable.createConsumer()
};

const onLoad = () => {
  new Vue({
    el: "#v-app"
  });
};

document.addEventListener("turbolinks:load", onLoad);
