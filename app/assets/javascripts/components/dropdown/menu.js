Vue.component('dropdown-menu', {
  props: ['width'],
  data() {
    return {
      top: 0,
      topOffset: 16
    };
  },
  mounted() {
    this.top = this.$parent.$el.offsetHeight + this.topOffset;
  },
  computed: {
    isVisible() {
      return this.$parent.isVisible;
    },
    styleAttr() {
      return `width: ${this.width}px; top: ${this.top}px;`;
    }
  },
  template: `
    <transition name="transition-slide-down">
      <ul class="dropdown-menu" :style="styleAttr" v-if="isVisible">
        <slot></slot>
      </ul>
    </transition>
  `
});
