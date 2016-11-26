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
      <i class="ion-ios-arrow-right sidebar-item-stack-trigger-icon" :class="{ 'is-active': isOpen }"></i>
      <slot></slot>
    </div>
  `
});
