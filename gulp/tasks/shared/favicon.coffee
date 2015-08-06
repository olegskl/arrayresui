#
# Favicon task (shared).
# @module gulp/tasks/shared/favicon
#

#
# Copies favicon to build output folder.
# @param  {Function} [done] Optional done callback called on completion.
# @return {Stream}          Gulp stream with favicon file.
#
module.exports = ->
  gulp = require 'gulp'
  config = require '../../config'

  return gulp
    .src config.src.clientFavicon
    .pipe gulp.dest config.dest.clientRoot
