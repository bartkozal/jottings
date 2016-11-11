Vue.component("sidebar-item-document-trigger", {
  methods: {
    resetDragged() {
      this.$parent.isDragged = false;
    },
    preventWhenDragging(event) {
      if (this.$parent.isDragged) {
        event.preventDefault();
      }
    }
  },
  template: `
    <a @click="preventWhenDragging" @mousedown="resetDragged">
      <slot></slot>
    </a>
  `
});
