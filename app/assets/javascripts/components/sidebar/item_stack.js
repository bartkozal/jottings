Vue.component("sidebar-item-stack", {
  props: ['stack'],
  data() {
    return {
      isActive: false
    };
  },
  created() {
    this.$data.isActive = JSON.parse(localStorage.getItem(this.stackKey)) || false;
  },
  computed: {
    stackKey() {
      return `stack-${this.stack}`;
    },
    isActive: {
      get() {
        return this.$data.isActive;
      },
      set(newValue) {
        this.$data.isActive = newValue;
        localStorage.setItem(this.stackKey, newValue);
      }
    }
  },
  template: `
    <li :class="{ 'is-active': isActive }">
      <slot></slot>
      <slot name="sidebar-item-stack-list" v-if="isActive"></slot>
    </li>
  `
});
