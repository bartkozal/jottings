Vue.component('dropdown', {
  data() {
    return {
      isVisible: false
    };
  },
  template: '<div class="dropdown">' +
              '<slot></slot>'        +
            '</div>'
});

Vue.component('dropdown-toggle', {
  computed: {
    isVisible: {
      get() {
        return this.$parent.isVisible;
      },
      set(newValue) {
        this.$parent.isVisible = newValue;
      }
    }
  },
  template: '<a class="dropdown-toggle" @click="isVisible = !isVisible">' +
              '<slot></slot>'                                             +
            '</a>'
});

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
  template: '<ul class="dropdown-menu" :style="styleAttr" v-if="isVisible">' +
              '<slot></slot>'                                                +
            '</ul>'
});
