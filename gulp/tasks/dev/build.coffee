#
# Build sequence task (development).
# @module gulp/tasks/dev/build
#

#
# Runs a sequence of tasks to build the output folder structure and contents.
# @param  {Function}  [done] Optional callback called on sequence completion.
# @return {Undefined}        Nothing is returned, because run-sequence
#                            has no return statement.
#
module.exports = (done) ->
  runSequence = require 'run-sequence'

  devBuildSequence = [
    'shared:clean-build'
    [
      'shared:favicon'
      'dev:core-styles'
      'dev:core-scripts'
      'dev:vendor-scripts'
    ]
    'dev:index-file'
    'dev:http-server'
    done
  ]

  runSequence devBuildSequence...
