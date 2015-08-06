# data Strategy = Object

R = require 'ramda'
React = require 'react'

StrategyParameters = require './strategy-parameters'
Selector = require './selector'
{ makeSelector, makeFilter } = require './maker'

# Private
# --------------------

# selectStrategies :: Criteria -> [Asset] -> [Asset]
selectStrategies = makeSelector 'id'

# findStrategies :: Criteria -> [Strategy] -> [Strategy]
findStrategies = makeFilter 'id', ['id']

# Public
# --------------------

# StrategiesSelector
module.exports = React.createClass

  propTypes:
    strategies: React.PropTypes.array
    changeHandler: React.PropTypes.func.isRequired

  getDefaultProps: ->
    strategies: []

  getInitialState: ->
    strategyId: 'strategy_22'
    parameters: {}

  handleStrategyChange: (strategyId) ->
    return if @state.strategyId is strategyId
    @replaceState
      strategyId: strategyId
      parameters: {}

  handleParametersChange: (parameters) ->
    return if R.eqDeep @state.parameters, parameters
    @setState
      parameters: parameters

  findStrategy: (strategies) ->
    searchCriteria = id: @state.strategyId
    R.head findStrategies searchCriteria, strategies

  componentDidUpdate: ->
    foundStrategy = R.clone @findStrategy @props.strategies
    return if not foundStrategy
    foundStrategy.parameters = R.clone @state.parameters
    @props.changeHandler foundStrategy

  render: ->
    strategyValues = selectStrategies @props.strategies
    foundStrategy = @findStrategy @props.strategies
    strategyParameters = foundStrategy?.parameters

    <div className="app-input__header">
      <div className="app-input__strategy-selector">
        <Selector
         label="Strategy"
         value={@state.strategyId}
         valueList={strategyValues}
         changeHandler={@handleStrategyChange}/>
        <StrategyParameters
         parameters={strategyParameters}
         changeHandler={@handleParametersChange}/>
      </div>
    </div>
