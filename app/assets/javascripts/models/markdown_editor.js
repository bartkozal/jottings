//= require codemirror
//= require codemirror/addons/mode/overlay
//= require codemirror/modes/markdown
//= require codemirror/modes/gfm

class MarkdownEditor {
  constructor(el) {
    CodeMirror.fromTextArea(el, {
      mode: "gfm"
    });
  }
}
