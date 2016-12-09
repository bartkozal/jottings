Vue.component("editor", {
  data() {
    return {
      isFullscreen: false
    };
  },
  created() {
    const fullscreenValue = localStorage.getItem("fullscreen");
    if (fullscreenValue === null) { return; }
    this.$data.isFullscreen = JSON.parse(fullscreenValue);
  },
  computed: {
    isFullscreen: {
      get() {
        return this.$data.isFullscreen;
      },
      set(newValue) {
        this.$data.isFullscreen = newValue;
        localStorage.setItem("fullscreen", newValue);
      }
    }
  },
  template: `
    <div :class="{ 'fullscreen': isFullscreen }">
      <a class="fullscreen-toggle" @click="isFullscreen = !isFullscreen">
        <i class="ion-arrow-shrink" v-if="!isFullscreen"></i>
        <i class="ion-arrow-expand" v-if="isFullscreen"></i>
      </a>
      <div class="sticky-footer">
        <slot></slot>
      </div>
    </div>
  `
});
