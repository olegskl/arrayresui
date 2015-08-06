React = require 'react'

# NavLegal component (copyright stuff):
module.exports = React.createClass
  shouldComponentUpdate: -> no
  render: ->
    <div className="app-nav__legal">
      Copyright and legal information goes here as well as contact details if necessary.
    </div>
