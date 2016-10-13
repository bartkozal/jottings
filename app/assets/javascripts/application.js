//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require vue
//= require_tree .
//= require_self

$(document).on("turbolinks:load", function() {
  new Vue({
    el: "html"
  });
});
