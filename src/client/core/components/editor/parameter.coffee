React = require 'react'

# Parameter
module.exports = React.createClass

  propTypes:
    label: React.PropTypes.string.isRequired
    type: React.PropTypes.string
    value: React.PropTypes.string
    isDisabled: React.PropTypes.bool
    changeHandler: React.PropTypes.func.isRequired

  getDefaultProps: ->
    value: null
    isDisabled: no

  handleChange: (event) ->
    @props.changeHandler event.target.value or null

  componentDidUpdate: ->
    @props.changeHandler @refs.input.getDOMNode().value

  render: ->

    type = @props.type or 'text'
    value = @props.value or ''
    parameterId = "#{@props.label}Parameter"

    <div className="app-input__selector-container">
      <label
       htmlFor={parameterId}
       className="app-input__selector-label">
        {@props.label}
      </label>
      <input
       ref="input"
       id={parameterId}
       type={type}
       value={value}
       disabled={@props.isDisabled}
       onChange={@handleChange}
       className="app-input__parameter"/>
    </div>
