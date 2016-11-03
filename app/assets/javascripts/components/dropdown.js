Vue.component('dropdown', {
  data() {
    return {
      isVisible: false
    };
  },
  created() {
    App.bus.$on("closeDropdowns", () => {
      this.isVisible = false;
    });
  },
  template: `
    <div class="dropdown">
      <slot></slot>
    </div>
  `
});
