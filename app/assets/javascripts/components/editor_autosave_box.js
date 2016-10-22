Vue.component('editor-autosave-box', {
  created() {
    App.bus.$on("documentSaved", () => {
      this.isVisible = true;
      window.setTimeout(() => {
        this.isVisible = false;
      }, 3000);
    });
  },
  data() {
    return {
      isVisible: false
    };
  },
  template: `
    <transition name="transition-fade">
      <div class="box box-autosave" v-if="isVisible">
        <slot></slot>
      </div>
    </transition>
  `
});
