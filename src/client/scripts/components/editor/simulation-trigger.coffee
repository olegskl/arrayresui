R = require 'ramda'
React = require 'react'

dispatcher = require '../../dispatcher'

# SimulationTrigger
module.exports = React.createClass

  propTypes:
    asset: React.PropTypes.object
    strategy: React.PropTypes.object
    code: React.PropTypes.string

  getDefaultProps: ->
    asset: null
    strategy: null
    code: ''

  isSimulationTriggerDisabled: ->
    if @props.asset and @props.strategy then no else yes

  submitSimulation: ->
    dispatcher.emit 'simulation',
      asset: R.clone @props.asset
      strategy: R.clone @props.strategy
      code: @props.code

  render: ->
    <button
     className="app-input__submit"
     disabled={do @isSimulationTriggerDisabled}
     onClick={@submitSimulation}>
      Run simulation
    </button>