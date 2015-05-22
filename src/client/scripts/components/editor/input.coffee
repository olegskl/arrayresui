React = require 'react'

CodeEditor = require './code-editor'
SimulationConfig = require './simulation-config'
dummyUserCode = require './dummy-user-code'

# Application input section:
module.exports = React.createClass

  getInitialState: ->
    assets: []
    strategies: []

  componentDidMount: ->
    fetch '/api/assets', 'Accept': 'application/json'
      .then (response) -> do response.json
      .then (assets) => @setState assets: assets
    fetch '/api/strategies', 'Accept': 'application/json'
      .then (response) -> do response.json
      .then (strategies) => @setState strategies: strategies

  render: ->
    <section className="app-input">
      <SimulationConfig
       assets={@state.assets}
       strategies={@state.strategies}/>
      <CodeEditor
       code={dummyUserCode}/>
    </section>
