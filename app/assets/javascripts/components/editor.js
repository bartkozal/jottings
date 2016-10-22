Vue.component('editor', {
  props: ['document'],
  mounted() {
    new MarkdownEditor(this.$el);
    new DocumentChannel(this.document);

    window.setInterval(() => {
      this.$http.patch(`/editor/documents/${this.document}`, {
        document: {
          body: App.editor.getValue()
        }
      }).then((response) => {
        App.bus.$emit("documentSaved");
      });
    }, 120000);
  },
  template: `
    <textarea>
      <slot></slot>
    </textarea>
  `
});
