# Polyfills:
global.Promise = require 'promise'
require 'whatwg-fetch'

React = require 'react'
Router = require 'react-router'

Home = require './components/home'
App = require './components/app'
About = require './components/about'
Profile = require './components/profile'
Auth = require './components/auth'
Editor = require './components/editor'

{ Route, Redirect, DefaultRoute } = Router

routes =
  <Route name="home" path="/" handler={Home}>
    <Route name="app" path="app" handler={App}>
      <Route name="editor" path="editor" handler={Editor}/>
      <Route name="about" path="about" handler={About}/>
      <Route name="profile" path="profile" handler={Profile}/>
      <Redirect from="/app" to="/app/editor"/>
    </Route>
    <Route name="auth" path="auth" handler={Auth}/>
    <Redirect from="/" to="app"/>
  </Route>

Router.run routes, (Handler) ->
  React.render <Handler/>, document.querySelector '#app'
