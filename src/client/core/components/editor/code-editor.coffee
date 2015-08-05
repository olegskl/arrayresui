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
    editor.$blockScrolling = Infinity

    session = editor.getSession()
    session.setMode 'ace/mode/scala'
    session.setValue @props.code
    session.on 'change', -> console.log do editor.getValue

  render: ->
    <pre
     ref="codeEditor"
     className="app-input__editor">
    </pre>
