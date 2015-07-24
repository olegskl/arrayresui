'use strict'

module.exports =
  STATIC_DIR: 'static'
  CACHE_AGE: parseInt process.env.ARRAYRES_CACHE_AGE, 10
  PORT: parseInt process.env.ARRAYRES_PORT, 10
  SESSION:
    secret: process.env.ARRAYRES_SESSION_SECRET
    saveUninitialized: no
    resave: no
  GOOGLE_STRATEGY:
    clientID: process.env.ARRAYRES_GOOGLE_CLIENT_ID
    clientSecret: process.env.ARRAYRES_GOOGLE_CLIENT_SECRET
    callbackURL: process.env.ARRAYRES_GOOGLE_CALLBACK_URL
