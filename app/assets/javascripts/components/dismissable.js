Vue.component('dismissable', {
  data() {
    return {
      isVisible: true
    };
  },
  template: `
    <transition name="transition-fade">
      <div class="has-dismiss" v-if="isVisible">
        <a @click="isVisible = false" class="dismiss">
          <i class="ion-close"></i>
        </a>
        <slot></slot>
      </div>
    </transition>
  `
});
