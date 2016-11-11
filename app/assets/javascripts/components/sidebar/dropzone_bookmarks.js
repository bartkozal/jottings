Vue.component("sidebar-dropzone-bookmarks", {
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
        self.isDroppable = false;
        self.$http.post(`/editor/documents/${droppedEl.document}/bookmark`).
          then((response) => { window.location.href = "/"; });
      }
    });
  },
  template: `
    <div :class="{'is-droppable': isDroppable}">
      <slot></slot>
    </div>
  `
});
