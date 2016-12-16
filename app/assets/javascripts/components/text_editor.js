Vue.component('text-editor', {
  props: ['document', 'shared', 'placeholder'],
  data() {
    return {
      isVisible: false
    };
  },
  created() {
    const self = this;
    App.bus.$on("changeTextEditorVisibility", (newValue) => {
      self.isVisible = newValue;
    });
  },
  mounted() {
    const isShared = JSON.parse(this.shared);

    new MarkdownEditor({
      el: this.$refs.textarea,
      doc: this.document
    });

    if (isShared) {
      new DocumentChannel(this.document);
    }
  },
  template: `
    <div v-cloak>
      <div class="sk-spinner sk-spinner-pulse" v-if="!isVisible"></div>
      <div v-show="isVisible">
        <textarea ref="textarea" :placeholder="placeholder">
          <slot></slot>
        </textarea>
      </div>
    </div>
  `
});
