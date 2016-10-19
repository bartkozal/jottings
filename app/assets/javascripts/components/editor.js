Vue.component('editor', {
  props: ['document'],
  mounted() {
    new MarkdownEditor(this.$el);
    new DocumentChannel(this.document);

  },
  template: '<textarea>'      +
              '<slot></slot>' +
            '</textarea>'
});
