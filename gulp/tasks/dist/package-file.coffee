#
# Package file task (distribution).
# @module gulp/tasks/dist/package-file
#

#
# Copies package.json to build output folder.
# @param  {Function} [done] Optional done callback (not used).
# @return {Stream}          Gulp stream with package.json file.
#
module.exports = ->
  gulp = require 'gulp'
  config = require '../../config'

  gulp
    .src config.src.package
    .pipe gulp.dest config.dest.buildRoot
