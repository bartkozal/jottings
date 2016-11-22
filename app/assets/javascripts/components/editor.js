Vue.component('editor', {
  props: ['document', 'shared'],
  mounted() {
    const isShared = JSON.parse(this.shared);

    new MarkdownEditor({
      el: this.$el,
      doc: this.document
    });

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
