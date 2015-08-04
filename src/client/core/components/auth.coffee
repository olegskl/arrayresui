React = require 'react'
{ Navigation } = require 'react-router'

module.exports = React.createClass
  mixins: [Navigation]

  render: ->
    <section className="app-login">
      <div className="app-login__panel">
        <h1 className="app-login__header-text">
          ArrayResolution
        </h1>
        <a
         href="/auth/google"
         className="app-login__action-button">
          Login with Google
        </a>
      </div>
    </section>
