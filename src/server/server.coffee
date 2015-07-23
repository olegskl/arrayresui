# HTTP server entry point.
#
# This server is used both for delivering the API resources
# and serving static application files.

'use strict'

# Community modules:
path = require 'path'
express = require 'express'
compression = require 'compression'
serveStatic = require 'serve-static'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'

# Our modules:
env = require './env'
apiRouter = require './router/api-router'
authRouter = require './router/auth-router'

# Compatibility headers middleware for Internet Explorer:
compatibilityHeaders = (request, response, next) ->
  # Instruct IE to use the latest available compatibility mode:
  response.setHeader 'X-UA-Compatible', 'IE=edge'
  do next

# Captures and aborts non-authenticated calls:
ensureAuthenticated = (request, response, next) ->
  return next() if request.isAuthenticated()
  response
    .status 401
    .json error: 'not authenticated'

staticDir = path.resolve __dirname, env.STATIC_DIR
staticFileServer = serveStatic staticDir, maxAge: env.CACHE_AGE

# HTML5 mode middleware:
indexFileServer = (request, response) ->
  indexFilePath = path.resolve staticDir, 'index.html'
  response.sendFile indexFilePath, maxAge: env.CACHE_AGE

# Server:
(do express)
  .use compatibilityHeaders
  .use do compression
  .use do cookieParser
  .use do bodyParser.json
  .use authRouter
  .use '/api', [ensureAuthenticated, apiRouter]
  .use staticFileServer
  .use indexFileServer
  .listen env.PORT
