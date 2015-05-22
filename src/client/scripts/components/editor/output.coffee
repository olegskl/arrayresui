React = require 'react'

OutputResult = require './output-result'
OutputGraphPnL = require './output-graph-pnl'
OutputGraphPosition = require './output-graph-position'

simulations = require '../../observables/simulations'
graphs = require '../../observables/graphs'

# Simulation results
module.exports = React.createClass

  getInitialState: ->
    simulation: {}
    graphPnL: []
    graphPosition: []

  updateSimulation: (data) ->
    console.info 'got simulation:', data
    @setState simulation: data

  updatePnLGraph: (data) ->
    console.info 'got pnl graph:', data
    @setState graphPnL: data

  updatePositionGraph: (data) ->
    console.info 'got position graph:', data
    @setState graphPosition: data

  componentDidMount: ->
    @simulationSubscription = simulations.forEach @updateSimulation
    @pnlGraphSubscription = graphs.pnl.forEach @updatePnLGraph
    @positionGraphSubscription = graphs.position.forEach @updatePositionGraph

  componentWillUnmount: ->
    do @simulationSubscription.dispose
    do @pnlGraphSubscription.dispose
    do @positionGraphSubscription.dispose

  render: ->
    <section className="app-output">
      <OutputResult value={@state.simulation.response}/>
      <OutputGraphPnL data={@state.graphPnL}/>
      <OutputGraphPosition data={@state.graphPosition}/>
    </section>
