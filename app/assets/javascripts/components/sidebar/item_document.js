Vue.component('sidebar-item-document', {
  data() {
    return {
      isDragging: false,
      dragged: false,
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
      onstart(event) {
        self.isDragging = true;
      },
      onmove(event) {
        self.translate = {
          x: self.x += event.dx,
          y: self.y += event.dy
        };
      },
      onend(event) {
        self.dragged = true;
        self.isDragging = false;
        self.translate = {x: 0, y: 0};
      }
    });
  },
  computed: {
    translate: {
      get() {
        return `translate(${this.x}px, ${this.y}px)`;
      },

      set(newValue) {
        this.x = newValue.x;
        this.y = newValue.y;
      }
    }
  },
  template: `
    <li :class="{ 'is-dragging': isDragging }" :style="{ transform: translate }">
      <slot></slot>
    </li>
  `
});
