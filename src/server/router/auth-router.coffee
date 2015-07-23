'use strict'

express = require 'express'
expressSession = require 'express-session'
passport = require 'passport'
passportGoogle = require 'passport-google-oauth'

env = require '../env'

# Authentication strategies:
GoogleStrategy = passportGoogle.OAuth2Strategy

strategyCallback = (accessToken, refreshToken, profile, done) ->
  done null, profile

passport.use new GoogleStrategy env.GOOGLE_STRATEGY, strategyCallback

passport.serializeUser (user, done) -> done null, user
passport.deserializeUser (user, done) -> done null, user

googleAuthInit = passport
  .authenticate 'google', scope: ['https://www.googleapis.com/auth/plus.login']
googleAuthCallback = passport
  .authenticate 'google', {successRedirect: '/', failureRedirect: '/'}

authLogout = (request, response) ->
  do request.logout
  response.redirect '/'

module.exports = (do express.Router)
  .use expressSession env.SESSION
  .use do passport.initialize
  .use do passport.session
  .get '/auth/logout', authLogout
  .get '/auth/google', googleAuthInit
  .get '/auth/google/callback', googleAuthCallback
