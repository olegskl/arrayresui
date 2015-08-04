#
# Build sequence task (distribution).
# @module gulp/tasks/dist/build
#

#
# Runs a sequence of tasks to build the output folder structure and contents.
# @param  {Function}  [done] Optional done callback called on sequence completion.
# @return {Undefined}        Nothing is returned because run-sequence
#                            has no return statement.
#
module.exports = (done) ->

  runSequence = require 'run-sequence'

  distBuildSequence = [
    'shared:clean-build'
    [
      'shared:favicon'
      'dist:core-styles'
      'dist:core-scripts'
      'dist:vendor-scripts'
      'dist:http-server'
      'dist:package-file'
    ]
    'dist:index-file'
    done
  ]

  runSequence distBuildSequence...
