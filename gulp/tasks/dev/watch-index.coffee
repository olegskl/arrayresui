#
# Index file changes watcher (development).
# @module gulp/tasks/dev/watch-index
#

#
# Watches index file for changes and reloads necessary tasks.
# @param  {Function} [done] Optional done callback (not used).
# @return {Stream}          Stream that emits Vinyl objects.
#
module.exports = ->

  watch = require 'gulp-watch'
  runSequence = require 'run-sequence'

  config = require '../../config'

  filesToWatch = [
    config.src.clientIndex
    config.src.clientCriticalScripts
    config.src.clientCriticalStyles
  ]
  tasksToStart = [
    'dev:index-file'
  ]

  watch filesToWatch, -> runSequence tasksToStart...
