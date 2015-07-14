React = require 'react'
{ Navigation } = require 'react-router'

firebase = require '../shared/firebase'

module.exports = React.createClass
  mixins: [Navigation]

  delegateAuth: ->
    firebase.authWithOAuthPopup 'google', (error, authData) =>
      if error
        console.log 'Login Failed!', error
      else
        console.log 'Authenticated successfully with payload:', authData
        @transitionTo 'app'

  render: ->
    <section className="app-login">
      <div className="app-login__panel">
        <h1 className="app-login__header-text">
          ArrayResolution
        </h1>
        <a
         className="app-login__action-button"
         onClick={@delegateAuth}>
          Login with Google
        </a>
      </div>
    </section>
