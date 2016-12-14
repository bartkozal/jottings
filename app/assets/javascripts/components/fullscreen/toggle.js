Vue.component('fullscreen-toggle', {
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
        App.bus.$emit("changeFullscreen", newValue);
      }
    }
  },
  template: `
    <a class="fullscreen-toggle" @click="isFullscreen = !isFullscreen">
      <slot></slot>
    </a>
  `
});
