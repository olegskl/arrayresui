R = require 'ramda'
React = require 'react'

api = require '../../modules/api'

AssetsSelector = require './assets-selector'
StrategiesSelector = require './strategies-selector'
CodeEditor = require './code-editor'
SimulationTrigger = require './simulation-trigger'

dummyUserCode = require './dummy-user-code'

# AppInput
module.exports = React.createClass

  getInitialState: ->
    availableAssets: []
    availableStrategies: []
    selectedAsset: null
    selectedStrategy: null
    strategyCode: dummyUserCode

  componentDidMount: ->
    api.get '/assets'
      .then (assets) => @setState availableAssets: assets
    api.get '/strategies'
      .then (strategies) => @setState availableStrategies: strategies

  setSelectedAssets: (assets) ->
    return if @state.selectedAsset is assets[0]
    @setState selectedAsset: assets[0]

  setSelectedStrategy: (strategy) ->
    return if R.eqDeep @state.selectedStrategy, strategy
    @setState selectedStrategy: strategy

  render: ->
    <section className="app-input">
      <AssetsSelector
       assets={@state.availableAssets}
       changeHandler={@setSelectedAssets}/>
      <StrategiesSelector
       strategies={@state.availableStrategies}
       changeHandler={@setSelectedStrategy}/>
      <CodeEditor
       code={@state.strategyCode}/>
      <SimulationTrigger
       asset={@state.selectedAsset}
       strategy={@state.selectedStrategy}
       code={@state.strategyCode}/>
    </section>
