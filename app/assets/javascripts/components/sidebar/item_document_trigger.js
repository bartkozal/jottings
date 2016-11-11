Vue.component("sidebar-item-document-trigger", {
  methods: {
    resetDragged() {
      this.$parent.dragged = false;
    },
    preventWhenDragging(event) {
      if (this.$parent.dragged) {
        event.preventDefault();
      } else {
        return;
      }
    }
  },
  template: `
    <a @click="preventWhenDragging" @mousedown="resetDragged">
      <slot></slot>
    </a>
  `
});
