#
# Serve sequence task (development).
# @module gulp/tasks/dev/serve
#

#
# Runs a sequence of tasks to serve content from the build folder.
# @param  {Function} [done] Optional done callback called on sequence completion.
# @return {Undefined}       Nothing is returned, because run-sequence
#                           has no return statement.
#
module.exports = (done) ->
  runSequence = require 'run-sequence'

  devServeSequence = [
    'dev:browser-sync-create'
    'dev:build'
    'dev:browser-sync-init'
    [
      'dev:watch-core-styles'
      'dev:watch-index'
      'dev:watch-server'
    ]
    done
  ]

  runSequence devServeSequence...
