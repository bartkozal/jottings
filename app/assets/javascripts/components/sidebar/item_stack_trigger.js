Vue.component("sidebar-item-stack-trigger", {
  computed: {
    isActive: {
      get() {
        return this.$parent.isActive;
      },
      set(newValue) {
        this.$parent.isActive = newValue;
      }
    }
  },
  template: `
    <div @click="isActive = !isActive">
      <slot></slot>
    </div>
  `
});
