Vue.component("sidebar-dropzone-documents", {
  data() {
    return {
      isDroppable: false
    };
  },
  mounted() {
    const self = this;
    interact(self.$el).dropzone({
      overlap: 0.1,
      ondragenter() {
        self.isDroppable = true;
      },
      ondragleave() {
        self.isDroppable = false;
      },
      ondrop(event) {
        const droppedEl = event.relatedTarget.__vue__;

        if (droppedEl.stack !== undefined) {
          self.$http.delete(`/editor/documents/${droppedEl.document}/move`).
            then((response) => { window.location.href = "/"; });
        }

        self.isDroppable = false;
      }
    });
  },
  template: `
    <ul :class="{'is-droppable': isDroppable}">
      <slot></slot>
    </ul>
  `
});
