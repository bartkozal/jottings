Vue.component('editor', {
  props: ['document'],
  methods: {
    update() {
      App.document.update(this.$el.value);
    }
  },
  mounted() {
    let self = this;
    App.document = App.cable.subscriptions.create({
      channel: "DocumentChannel",
      id: self.document
    },{
      received(data) {
        self.$el.value = data.body;
      },

      update(body) {
        this.perform('update', { body: body });
      }
    });
  },
  template: '<textarea @keyup="update">' +
              '<slot></slot>'            +
            '</textarea>'
});
