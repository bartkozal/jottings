//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require vue/vue
//= require_tree ./components
//= require action_cable
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
