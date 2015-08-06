#
# Server files changes watcher (development).
# @module gulp/tasks/dev/watch-server
#

#
# Watches server files for changes, then rebuilds and restarts the server.
# @param  {Function} [done] Optional done callback (not used).
# @return {Stream}          Stream that emits Vinyl objects.
#
module.exports = ->

  r = require 'ramda'
  watch = require 'gulp-watch'
  gutil = require 'gulp-util'
  runSequence = require 'run-sequence'

  config = require '../../config'

  filesToWatch = r.flatten [
    config.src.serverScripts
    config.src.serverData
  ]
  tasksToStart = [
    'dev:http-server'
    -> gutil.log 'You may need to refresh your browser windows...'
  ]

  watch filesToWatch, -> runSequence tasksToStart...
