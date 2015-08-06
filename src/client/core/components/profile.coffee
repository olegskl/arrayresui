React = require 'react'

module.exports = React.createClass
  render: ->
    <section className="app-main">
      <h1>My profile</h1>
      <div>
        <a
         href="/auth/logout"
         className="app-profile__logout-button">
          Logout
        </a>
      </div>
    </section>
