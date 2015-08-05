React = require 'react'

chart = require '../charts/pnl'

module.exports = React.createClass

  propTypes:
    data: React.PropTypes.array

  shouldComponentUpdate: -> no

  componentDidMount: ->
    @chart = new chart @refs.container.getDOMNode()
    @chart.update @props.data if @props.data

  componentWillReceiveProps: (newProps) ->
    @chart.update newProps.data

  render: ->
    <div className="panel">
      <header className="panel__header">PnL</header>
      <div className="panel__body">
        <svg ref="container"></svg>
      </div>
    </div>
