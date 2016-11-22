//= require codemirror
//= require codemirror/addons/mode/overlay
//= require codemirror/addons/display/placeholder
//= require codemirror/modes/markdown
//= require codemirror/modes/gfm

class MarkdownEditor {
  constructor(el) {
    App.editor = CodeMirror.fromTextArea(el, {
      mode: "gfm",
      viewportMargin: Infinity,
      lineWrapping: true
    });
  }
}
