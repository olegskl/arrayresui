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

  # We need the force options to allow working
  # on directories outside the cwd:
  delOptions = force: yes

  del config.dest.buildRoot, delOptions, done
