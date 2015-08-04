#
# Build output folder cleaner task (shared).
# @module gulp/tasks/shared/clean-build
#

#
# Cleans build output folder.
# @param  {Function}  [done] Optional done callback called on completion.
# @return {Undefined}        Nothing is returned, done callback is called.
#
module.exports = (done) ->
  del = require 'del'
  config = require '../../config'

  del config.dest.buildRoot, done
