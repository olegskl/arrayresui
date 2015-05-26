React = require 'react'

AssetsSelector = require './assets-selector'
StrategiesSelector = require './strategies-selector'
CodeEditor = require './code-editor'
SimulationTrigger = require './simulation-trigger'

dummyUserCode = require './dummy-user-code'

# Application input section:
module.exports = React.createClass

  getInitialState: ->
    availableAssets: []
    availableStrategies: []
    selectedAsset: null
    selectedStrategy: null
    strategyCode: dummyUserCode

  componentDidMount: ->
    fetch '/api/assets', 'Accept': 'application/json'
      .then (response) -> do response.json
      .then (assets) => @setState availableAssets: assets
    fetch '/api/strategies', 'Accept': 'application/json'
      .then (response) -> do response.json
      .then (strategies) => @setState availableStrategies: strategies

  setSelectedAssets: (assets) ->
    return if @state.selectedAsset is assets[0]
    @setState selectedAsset: assets[0]

  setSelectedStrategies: (strategies) ->
    return if @state.selectedStrategy is strategies[0]
    @setState selectedStrategy: strategies[0]

  render: ->
    <section className="app-input">
      <AssetsSelector
       assets={@state.availableAssets}
       changeHandler={@setSelectedAssets}/>
      <StrategiesSelector
       strategies={@state.availableStrategies}
       changeHandler={@setSelectedStrategies}/>
      <CodeEditor
       code={@state.strategyCode}/>
      <SimulationTrigger
       asset={@state.selectedAsset}
       strategy={@state.selectedStrategy}
       code={@state.strategyCode}/>
    </section>
