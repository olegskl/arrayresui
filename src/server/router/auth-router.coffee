'use strict'

R = require 'ramda'
express = require 'express'
expressSession = require 'express-session'
passport = require 'passport'
passportGoogle = require 'passport-google-oauth'
connectRedis = require 'connect-redis'

env = require '../env'

# Session options:
RedisStore = connectRedis expressSession
sessionOptions = R.merge env.SESSION, store: new RedisStore

# Authentication strategies:
GoogleStrategy = passportGoogle.OAuth2Strategy

strategyCallback = (accessToken, refreshToken, profile, done) ->
  done null, profile

passport.use new GoogleStrategy env.GOOGLE_STRATEGY, strategyCallback

userSerializer = (user, done) -> done null, user.id
userDeserializer = (serializedUser, done) -> done null, serializedUser
passport.serializeUser userSerializer
passport.deserializeUser userDeserializer

googleAuthInit = passport
  .authenticate 'google', scope: ['https://www.googleapis.com/auth/plus.login']
googleAuthCallback = passport
  .authenticate 'google', {successRedirect: '/', failureRedirect: '/'}

authLogout = (request, response) ->
  do request.logout
  response.redirect '/'

module.exports = (do express.Router)
  .use expressSession sessionOptions
  .use do passport.initialize
  .use do passport.session
  .get '/auth/logout', authLogout
  .get '/auth/google', googleAuthInit
  .get '/auth/google/callback', googleAuthCallback
