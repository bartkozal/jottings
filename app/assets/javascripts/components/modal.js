Vue.component("modal", {
  props: ['width', 'openOnload'],
  data() {
    return {
      isVisible: false
    };
  },
  created() {
    if (this.openOnload === undefined) { return; }
    this.isVisible = JSON.parse(this.openOnload);
  },
  updated() {
    if (this.$data.isVisible) {
      Vue.nextTick(() => {
        const autofocusEl = this.$el.querySelector("[autofocus]");
        if (autofocusEl !== null) { autofocusEl.focus(); }
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
        <div class="modal-backdrop" v-if="isVisible"></div>
      </transition>

      <transition name="transition-zoom-in">
        <div class="has-modal" v-if="isVisible">
          <div class="modal-close-trigger" @click="isVisible = false"></div>
          <div class="modal box" :style="styleAttr">
            <slot></slot>
          </div>
        </div>
      </transition>
    </div>
  `
});
