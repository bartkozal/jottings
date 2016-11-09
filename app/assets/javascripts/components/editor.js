Vue.component('editor', {
  props: ['document', 'shared'],
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
    const isShared = JSON.parse(this.shared);
    const mdEditor = new MarkdownEditor(this.$el);

    if (isShared) {
      new DocumentChannel(this.document);
      mdEditor.broadcast();
    }
  },
  template: `
    <textarea>
      <slot></slot>
    </textarea>
  `
});
