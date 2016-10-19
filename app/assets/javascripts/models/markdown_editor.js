//= require codemirror
//= require codemirror/addons/mode/overlay
//= require codemirror/modes/markdown
//= require codemirror/modes/gfm

class MarkdownEditor {
  constructor(el) {
    App.editor = CodeMirror.fromTextArea(el, {
      mode: "gfm"
    });

    App.editor.on("change", (editor, change) => {
      if (change.origin != "setValue") {
          App.document.update(editor.getValue());
      }
    });
  }
}
