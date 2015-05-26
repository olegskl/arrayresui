# data Strategy = Object

R = require 'ramda'
React = require 'react'

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

  handleStrategyChange: (value) ->
    @setState strategyId: value

  updateStrategyList: ->
    criteria = id: @state.strategyId
    @props.changeHandler findStrategies criteria, @props.strategies

  componentDidUpdate: ->
    do @updateStrategyList

  render: ->
    strategyValues = selectStrategies @props.strategies

    <div className="app-input__header">
      <div className="app-input__control-group">
        <Selector
         label="Strategy"
         value={@state.strategyId}
         valueList={strategyValues}
         changeHandler={@handleStrategyChange}/>
      </div>
    </div>
