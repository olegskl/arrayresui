React = require 'react'
{ RouteHandler } = require 'react-router'

Nav = require './nav'

module.exports = React.createClass
  render: ->
    <div className="app-layout">
      <Nav/>
      <RouteHandler/>
    </div>
