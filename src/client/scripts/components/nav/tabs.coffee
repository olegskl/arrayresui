React = require 'react'
{ Link } = require 'react-router'

# NavTabs component:
module.exports = React.createClass
  render: ->
    <div className="app-nav__item-list">
      <Link
       to="editor"
       className="app-nav__item"
       activeClassName="app-nav__item--active">
        Strategy editor
      </Link>
      <Link
       to="about"
       className="app-nav__item"
       activeClassName="app-nav__item--active">
        About
      </Link>
    </div>