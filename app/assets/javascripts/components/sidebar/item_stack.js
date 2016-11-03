Vue.component("sidebar-item-stack", {
  props: ['stack'],
  data() {
    return {
      isVisible: false
    };
  },
  created() {
    this.$data.isVisible = JSON.parse(localStorage.getItem(this.stackKey)) || false;
  },
  computed: {
    stackKey() {
      return `stack-${this.stack}`;
    },
    isVisible: {
      get() {
        return this.$data.isVisible;
      },
      set(newValue) {
        this.$data.isVisible = newValue;
        localStorage.setItem(this.stackKey, newValue);
      }
    }
  },
  template: `
    <li @click="isVisible = !isVisible" class="sidebar-item-stack" :class="{ 'is-visible': isVisible }">
      <slot></slot>
      <slot name="sidebar-item-stack-list" v-if="isVisible"></slot>
    </li>
  `
});
