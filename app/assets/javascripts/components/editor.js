Vue.component('editor', {
  methods: {
    update() {
      App.document.update(this.$el.value);
    }
  },
  template: '<textarea @keyup="update">' +
              '<slot></slot>'            +
            '</textarea>'
});
