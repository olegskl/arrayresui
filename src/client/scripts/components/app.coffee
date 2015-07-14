React = require 'react'
{ RouteHandler, Navigation } = require 'react-router'

authObservable = require '../observables/auth'
firebase = require '../shared/firebase'
Nav = require './nav'

module.exports = React.createClass
  mixins: [Navigation]

  redirectToLogin: ->
    @transitionTo 'auth'

  componentWillMount: ->
    return @redirectToLogin() unless firebase.getAuth()
    @simulationSubscription = authObservable
      .filter (authData) -> authData is null
      .forEach @redirectToLogin

  componentWillUnmount: ->
    @simulationSubscription?.dispose()

  render: ->
    <div className="app-layout">
      <Nav/>
      <RouteHandler/>
    </div>
