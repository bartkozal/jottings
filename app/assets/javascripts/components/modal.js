Vue.component("modal", {
  props: ['width'],
  data() {
    return {
      isVisible: false
    };
  },
  updated() {
    if (this.$data.isVisible) {
      Vue.nextTick(() => {
        this.$el.querySelector("[autofocus]").focus();
      });
    }
  },
  computed: {
    isVisible: {
      get() {
        return this.$data.isVisible;
      },
      set(newValue) {
        this.$data.isVisible = newValue;
      }
    },
    styleAttr() {
      return `width: ${this.width}px`;
    }
  },
  template: `
    <div>
      <a @click="isVisible = true" class="modal-trigger">
        <slot name="modal-trigger"></slot>
      </a>
      <transition name="transition-fade">
        <div class="has-modal" v-if="isVisible">
          <div class="modal-backdrop" @click="isVisible = false"></div>
          <div class="modal box" :style="styleAttr">
            <slot></slot>
          </div>
        </div>
      </transition>
    </div>
  `
});
