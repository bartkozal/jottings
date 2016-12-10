Vue.component('sidebar-item-document', {
  props: ['document', 'stack'],
  data() {
    return {
      isRemoved: false,
      isDragging: false,
      isDragged: false,
      x: 0,
      y: 0
    };
  },
  mounted() {
    const self = this;
    interact(self.$el, {
      styleCursor: false
    }).draggable({
      autoScroll: true,
      onstart() {
        self.isDragging = true;
      },
      onmove(event) {
        self.translate = {
          x: self.x += event.dx,
          y: self.y += event.dy
        };
      },
      onend() {
        self.isDragging = false;
        self.isDragged = true;
        self.translate = {x: 0, y: 0};
      }
    });
  },
  computed: {
    translate: {
      get() {
        if (this.x !== 0 || this.y !== 0) {
          return `translate(${this.x}px, ${this.y}px)`;
        } else {
          return "";
        }
      },

      set(newValue) {
        this.x = newValue.x;
        this.y = newValue.y;
      }
    }
  },
  template: `
    <li :class="{ 'is-dragging': isDragging }" :style="{ transform: translate }" v-if="!isRemoved">
      <slot></slot>
    </li>
  `
});
