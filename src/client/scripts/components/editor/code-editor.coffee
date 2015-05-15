React = require 'react'

module.exports = React.createClass
  componentDidMount: ->
    editor = ace.edit @refs.codeEditor.getDOMNode()
    editor.setTheme 'ace/theme/merbivore_soft'
    editor.getSession().setMode 'ace/mode/javascript'
  render: ->
    <pre
     ref="codeEditor"
     className="app-input__editor">
      {@props.code}
    </pre>
