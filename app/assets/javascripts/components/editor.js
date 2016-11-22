Vue.component('editor', {
  props: ['document', 'shared'],
  mounted() {
    const isShared = JSON.parse(this.shared);
    const mdEditor = new MarkdownEditor(this.$el);

    if (isShared) {
      new DocumentChannel(this.document);
    }
  },
  template: `
    <textarea>
      <slot></slot>
    </textarea>
  `
});
