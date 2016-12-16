Vue.component("editor", {
  data() {
    return {
      isFullscreen: false
    };
  },
  created() {
    const self = this;
    const fullscreenValue = localStorage.getItem("fullscreen");

    App.bus.$on("changeFullscreen", (newValue) => {
      self.isFullscreen = newValue;
    });

    if (fullscreenValue !== null) {
      self.isFullscreen = JSON.parse(fullscreenValue);
    }
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
      <div class="sticky-footer">
        <slot></slot>
      </div>
    </div>
  `
});
