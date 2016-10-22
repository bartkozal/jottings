Vue.component('dropdown', {
  data() {
    return {
      isVisible: false
    };
  },
  template: `
    <div class="dropdown">
      <slot></slot>
    </div>
  `
});
