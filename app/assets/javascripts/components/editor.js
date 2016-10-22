Vue.component('editor', {
  props: ['document'],
  created() {
    App.intervals.editorAutosave = setInterval(() => {
      this.$http.patch(`/editor/documents/${this.document}`, {
        document: {
          body: App.editor.getValue()
        }
      }).then((response) => {
        App.bus.$emit("documentSaved");
      });
    }, 120000);
  },
  mounted() {
    new MarkdownEditor(this.$el);
    new DocumentChannel(this.document);
  },
  template: `
    <textarea>
      <slot></slot>
    </textarea>
  `
});
