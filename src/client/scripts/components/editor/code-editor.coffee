React = require 'react'
ace = require 'brace'

require 'brace/mode/scala'
require 'brace/theme/merbivore_soft'

module.exports = React.createClass

  propTypes:
    code: React.PropTypes.string

  getDefaultProps: ->
    code: ''

  componentDidMount: ->
    editor = ace.edit do @refs.codeEditor.getDOMNode
    editor.setTheme 'ace/theme/merbivore_soft'
    editor.getSession().setMode 'ace/mode/scala'

  render: ->
    <pre
     ref="codeEditor"
     className="app-input__editor">
      {@props.code}
    </pre>
