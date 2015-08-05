React = require 'react'
{ RouteHandler, Navigation, State } = require 'react-router'

dispatcher = require '../dispatcher'
authObservable = require '../observables/auth'
usersResource = require '../resources/users'

module.exports = React.createClass
  mixins: [Navigation, State]

  getInitialState: -> hasFetchedUser: no
  handleLogin: -> @transitionTo 'app' unless @isActive 'app'
  handleLogout: -> @transitionTo 'auth' unless @isActive 'auth'

  componentWillMount: ->
    @authCheckSubscription = authObservable
      .first()
      .forEach => @setState hasFetchedUser: yes
    @loginSubscription = authObservable
      .filter (authData) -> authData isnt null
      .forEach => @handleLogin()
    @logoutSubscription = authObservable
      .filter (authData) -> authData is null
      .forEach => @handleLogout()
    usersResource
      .fetchMe()
      .then (user) -> dispatcher.emit 'auth', user

  componentWillUnmount: ->
    @loginSubscription?.dispose()
    @logoutSubscription?.dispose()

  render: ->
    return <RouteHandler/> if @state.hasFetchedUser
    <section className="app-login">loading...</section>
