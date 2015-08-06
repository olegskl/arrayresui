#
# Bundle styles changes watcher (development).
# @module gulp/tasks/dev/watch-bundle-styles
#

#
# Watches bundle styles for changes and reloads necessary tasks.
# @param  {Function} [done] Optional done callback (we don't need to use it).
# @return {Stream}          Stream that emits Vinyl objects.
#
module.exports = ->

  watch = require 'gulp-watch'
  runSequence = require 'run-sequence'

  config = require '../../config'

  filesToWatch = [
    config.src.clientCoreStyles
  ]
  tasksToStart = [
    'dev:core-styles'
  ]

  watch filesToWatch, -> runSequence tasksToStart...
