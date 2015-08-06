#
# Application HTTP Server (development).
# @module gulp/tasks/dev/http-server
#

#
# Copies server scripts and data files and restarts the server.
# @param  {Function} [done] Optional done callback called on completion (not used).
# @return {Stream}          Gulp stream.
#
module.exports = ->
  server = require 'gulp-develop-server'

  distHttpServer = require '../dist/http-server'
  config = require '../../config'

  serverOptions =
    path: "#{config.dest.serverRoot}/server.js"
    env:
      PORT: 1337
      CACHE_AGE: 0

  distHttpServer()
    .pipe server serverOptions # start or restart the server
