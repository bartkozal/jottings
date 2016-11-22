class DocumentChannel {
  constructor(id) {
    App.document = App.cable.subscriptions.create({
      channel: "DocumentChannel",
      id: id
    }, {
      received(data) {
        // ...
      }
    });
  }
}
