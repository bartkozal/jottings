Vue.component('sidebar-item-document', {
  mounted() {
    interact(this.$el, {
      styleCursor: false
    }).draggable({
      autoScroll: true,
      onstart(event) {
        event.target.classList.add("is-dragged");
      },
      onmove(event) {
        let target = event.target,
            x = +(target.dataset.x || 0) + event.dx,
            y = +(target.dataset.y || 0) + event.dy;

        target.style.transform = `translate(${x}px, ${y}px)`;
        target.dataset.x = x;
        target.dataset.y = y;
      },
      onend(event) {
        let target = event.target;

        target.classList.remove("is-dragged");
        target.style.transform = null;
        target.dataset.x = 0;
        target.dataset.y = 0;
      }
    });
  },
  template: `
    <li>
      <slot></slot>
    </li>
  `
});
