Vue.component("sidebar-item-stack-trigger", {
  computed: {
    isOpen: {
      get() {
        return this.$parent.isOpen;
      },
      set(newValue) {
        this.$parent.isOpen = newValue;
      }
    }
  },
  template: `
    <div @click="isOpen = !isOpen">
      <slot></slot>
    </div>
  `
});
