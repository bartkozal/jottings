Vue.component("tooltip", {
  props: ['width', 'offset'],
  data() {
    return {
      isVisible: false
    };
  },
  computed: {
    styleAttr() {
      return `width: ${this.width}px; left: ${this.offset || 0}px`;
    }
  },
  template: `
    <span class="has-tooltip">
      <span @mouseover="isVisible = true" @mouseleave="isVisible = false">
        <slot name="tooltip-trigger"></slot>
      </span>

      <transition name="transition-tooltip">
        <div class="tooltip" v-if="isVisible" :style="styleAttr">
          <slot></slot>
        </div>
      </transition>
    </span>
  `
});
