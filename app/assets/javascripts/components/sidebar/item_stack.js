Vue.component("sidebar-item-stack", {
  props: ['stack'],
  data() {
    return {
      isOpen: true,
      isDroppable: false
    };
  },
  created() {
    const stackValue = localStorage.getItem(this.stackKey);
    if (stackValue === null) { return; }
    this.$data.isOpen = JSON.parse(stackValue);
  },
  mounted() {
    const self = this;
    interact(self.$el).dropzone({
      overlap: 0.1,
      ondragenter() {
        self.isDroppable = true;
      },
      ondragleave() {
        self.isDroppable = false;
      },
      ondrop(event) {
        const droppedEl = event.relatedTarget.__vue__;

        if (droppedEl.stack !== self.stack) {
          self.$http.post(`/editor/documents/${droppedEl.document}/move/${self.stack}`).
            then((response) => { window.location.href = "/"; });
        }

        self.isDroppable = false;
      }
    });
  },
  computed: {
    stackKey() {
      return `stack-${this.stack}`;
    },
    isOpen: {
      get() {
        return this.$data.isOpen;
      },
      set(newValue) {
        this.$data.isOpen = newValue;
        localStorage.setItem(this.stackKey, newValue);
      }
    }
  },
  template: `
    <li :class="{ 'is-open': isOpen, 'is-droppable': isDroppable }">
      <slot></slot>
      <transition name="transition-sidebar-item-stack">
        <slot name="sidebar-item-stack-list" v-if="isOpen"></slot>
      </transition>
    </li>
  `
});
