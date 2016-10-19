Vue.component('editor', {
  props: ['document'],
  methods: {
    update() {
      App.document.update(this.$el.value);
    }
  },
  mounted() {
    new DocumentChannel(this.document, this.$el);
    new MarkdownEditor(this.$el);
  },
  template: '<textarea @keyup="update">' +
              '<slot></slot>'            +
            '</textarea>'
});
