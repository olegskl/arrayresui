#
# Application HTTP Server (development).
# @module gulp/tasks/dist/http-server
#

#
# Copies server scripts and data files.
# @param  {Function} [done] Optional done callback called on completion (not used).
# @return {Stream}          Gulp stream.
#
module.exports = ->
  gulp = require 'gulp'
  coffee = require 'gulp-coffee'
  series = require 'stream-series'

  config = require '../../config'

  streamingServerData = gulp
    .src config.src.serverData
    .pipe gulp.dest config.dest.serverRoot

  streamingServerScripts = gulp
    .src config.src.serverScripts
    .pipe coffee bare: true # decoffeify without IIFE wrappers
    .pipe gulp.dest config.dest.serverRoot # write to disk

  series streamingServerData, streamingServerScripts
