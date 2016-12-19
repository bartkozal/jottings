class DocumentChannel {
  constructor(id) {
    App.document = App.cable.subscriptions.create({
      channel: "DocumentChannel",
      id: id
    }, {
      received(data) {
        $("[data-cable-user]").each(function() {
          if (data.online_users.includes($(this).data('cable-user'))) {
            $(this).addClass("is-online");
          } else {
            $(this).removeClass("is-online");
          }
        });
      }
    });
  }
}
