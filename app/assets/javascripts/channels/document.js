class DocumentChannel {
  constructor(id) {
    App.document = App.cable.subscriptions.create({
      channel: "DocumentChannel",
      id: id
    }, {
      received(data) {
        let cursor = App.editor.getCursor();
        App.editor.setValue(data.body);
        App.editor.setCursor(cursor);
      },

      update(body) {
        this.perform('update', { body: body });
      }
    });
  }
}
