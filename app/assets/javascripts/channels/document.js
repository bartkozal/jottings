App.document = App.cable.subscriptions.create("DocumentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    App.vue.$refs.editor.$el.value = data.body;
  },

  update(body) {
    this.perform('update', { body: body });
  }
});
