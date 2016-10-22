//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require action_cable
//= require vue/vue
//= require vue-resource/vue-resource
//= require vue_csrf_token
//= require_tree ./channels
//= require_tree ./models
//= require_tree ./components
//= require_self

this.App = {
  cable: ActionCable.createConsumer(),
  bus: new Vue(),
  editor: null,
  intervals: {
    editorAutosave: null,
    editorAutosaveBox: null
  }
};

const onLoad = () => {
  window.clearInterval(App.intervals.editorAutosave);
  window.clearInterval(App.intervals.editorAutosaveBox);

  new Vue({
    el: "#v-app"
  });
};

document.addEventListener("turbolinks:load", onLoad);
