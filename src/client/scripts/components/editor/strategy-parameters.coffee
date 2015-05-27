R = require 'ramda'
React = require 'react'

Parameter = require './parameter'

# Private
# --------------------

types =
  i: 'number'
  f: 'number'
  b: 'checkbox'

makeParameter = (options) ->
  <Parameter
   key={options.name}
   label={options.name}
   type={types[options.type]}
   value={options.value?.toString()}
   changeHandler={options.changeHandler}/>

# Public
# --------------------

# StrategyParameters
module.exports = React.createClass

  propTypes:
    parameters: React.PropTypes.object.isRequired
    changeHandler: React.PropTypes.func.isRequired

  getDefaultProps: ->
    parameters: {}

  getInitialState: -> {}

  componentDidUpdate: ->
    parameters = R.omit ['parameters', 'changeHandler'], @state
    @props.changeHandler parameters

  componentWillReceiveProps: (nextProps) ->
    return if R.eqDeep @props.parameters, nextProps.parameters
    @replaceState {}

  configureParameter: ([key, value]) ->
    name: key
    type: value.type
    value: @state[key] or value.value
    changeHandler: (val) =>
      return if @state[key] is val
      stateDiff = {}
      stateDiff[key] = val
      @setState stateDiff

  getStrategyParams: ->
    R.map @configureParameter, R.toPairs @props.parameters

  render: ->
    <div className="app-input__strategy-parameters">
      {R.map makeParameter, @getStrategyParams()}
    </div>
