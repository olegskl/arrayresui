React = require 'react'

simulations = require '../../observables/simulations'
graphs = require '../../observables/graphs'

# Simulation results
module.exports = React.createClass

  componentDidMount: ->
    simulations.subscribe (data) -> console.log 'got simulation:', data
    graphs.subscribe (data) -> console.log 'got graphs:', data

  render: ->
    <section className="app-output">
      This area is the visualization interface.
      <br/><br/>
      User enters the strategy code in the editor on the left and clicks the submit button.
      <br/><br/>
      Results are then displayed here as graphs, tables, ...
    </section>