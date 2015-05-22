React = require 'react'

NavLogo = require './nav/logo'
NavTabs = require './nav/tabs'
NavLegal = require './nav/legal'

# Main navigation component:
module.exports = React.createClass
  render: ->
    <nav className="app-nav">
      <NavLogo/>
      <NavTabs/>
      <NavLegal/>
    </nav>
