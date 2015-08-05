React = require 'react'

module.exports = React.createClass
  render: ->
    if not @props.value
      return <div>Run a simulation...</div>

    if not @props.value.result
      return <div>
        Error... probably no mock data available.<br/>
        Try "strategy_12", "strategy_22", or "strategy_26".
      </div>

    { id, trades, balance, pnl, position } = @props.value.result

    <div className="panel">

      <header className="panel__header">
        Simulation results
      </header>

      <div className="panel__body--padded">
        <div>id: {id}</div>
        <div>trades: {trades}</div>

        <br/>

        <div>balance current: {balance.current}</div>
        <div>balance max: {balance.max}</div>
        <div>balance min: {balance.min}</div>

        <br/>

        <div>pnl current: {pnl.current}</div>
        <div>pnl max: {pnl.max}</div>
        <div>pnl min: {pnl.min}</div>

        <br/>

        <div>position current: {position.current}</div>
        <div>position max: {position.max}</div>
        <div>position min: {position.min}</div>
      </div>

    </div>