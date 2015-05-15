React = require 'react'

# Simulation results
module.exports = React.createClass
  render: ->
    <section className="app-output">
      This area is the visualization interface.
      <br/><br/>
      User enters the strategy code in the editor on the left and clicks the submit button.
      <br/><br/>
      Results are then displayed here as graphs, tables, ...
    </section>