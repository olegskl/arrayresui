React = require 'react'

# createOption :: Object -> ReactElement
createOption = (spec) ->
  <option key={spec.value} value={spec.value}>
    {spec.content}
  </option>

# Selector component:
module.exports = React.createClass

  propTypes:
    label: React.PropTypes.string.isRequired
    value: React.PropTypes.string
    valueList: React.PropTypes.array
    isDisabled: React.PropTypes.bool
    changeHandler: React.PropTypes.func.isRequired

  getDefaultProps: ->
    value: null
    valueList: []
    isDisabled: no

  handleChange: (event) ->
    @props.changeHandler event.target.value or null

  render: ->
    selectId = "#{@props.label}Selector"
    <div className="app-input__selector-container">
      <label
       htmlFor={selectId}
       className="app-input__selector-label">
        {@props.label}
      </label>
      <select
       id={selectId}
       value={@props.value}
       disabled={@props.isDisabled}
       onChange={@handleChange}
       className="app-input__selector">
        <option value="">- {@props.label} -</option>
        {@props.valueList.map createOption}
      </select>
    </div>
