class DocumentChannel {
  constructor(id, el) {
    App.document = App.cable.subscriptions.create({
      channel: "DocumentChannel",
      id: id
    }, {
      received(data) {
        el.value = data.body;
      },

      update(body) {
        this.perform('update', { body: body });
      }
    });
  }
}
