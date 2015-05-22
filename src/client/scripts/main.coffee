# Polyfills:
global.Promise = require 'promise'
require 'whatwg-fetch'

React = require 'react'
Router = require 'react-router'

App = require './components/app'
About = require './components/about'
Editor = require './components/editor'

{ Route, Redirect } = Router

routes =
  <Route path="/" handler={App}>
    <Route name="editor" path="/editor/" handler={Editor}/>
    <Route name="about" path="/about/" handler={About}/>
    <Redirect from="/" to="editor"/>
  </Route>

Router.run routes, (Handler) ->
  React.render <Handler/>, document.querySelector '#app'