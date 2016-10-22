Vue.component('dropdown-toggle', {
  computed: {
    isVisible: {
      get() {
        return this.$parent.isVisible;
      },
      set(newValue) {
        this.$parent.isVisible = newValue;
      }
    }
  },
  template: `
    <a class="dropdown-toggle" @click="isVisible = !isVisible">
      <slot></slot>
    </a>
  `
});
