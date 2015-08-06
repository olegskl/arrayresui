React = require 'react'

chart = require '../charts/position'

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
      <header className="panel__header">Position</header>
      <svg className="panel__body" ref="container"></svg>
    </div>
