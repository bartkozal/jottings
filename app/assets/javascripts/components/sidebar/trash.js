Vue.component("sidebar-trash", {
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

        self.$http.delete(`/editor/documents/${droppedEl.document}`).
          then((response) => { window.location.href = "/"; });

        self.isDroppable = false;
      }
    });
  },
  template: `
    <li :class="{'is-droppable': isDroppable}">
      <slot></slot>
    </li>
  `
});
