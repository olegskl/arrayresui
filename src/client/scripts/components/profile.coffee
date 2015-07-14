React = require 'react'

firebase = require '../shared/firebase'

module.exports = React.createClass
  logout: ->
    console.log 'unauth handler'
    do firebase.unauth
  render: ->
    <section className="app-main">
      <h1>My profile</h1>
      <div>
        <a
         className="app-profile__logout-button"
         onClick={@logout}>
          Logout
        </a>
      </div>
    </section>
