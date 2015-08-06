#
# Core scripts bundler (distribution).
# @module gulp/tasks/dist/core-scripts
#

#
# Builds core scripts.
# @param  {Function} [done] Optional done callback (not used).
# @return {Stream}          Gulp stream.
#
module.exports = ->

  gulp = require 'gulp'
  uglify = require 'gulp-uglify'
  rev = require 'gulp-rev'
  browserify = require 'browserify'
  coffeeReactify = require 'coffee-reactify'
  source = require 'vinyl-source-stream'
  buffer = require 'vinyl-buffer'

  notify = require '../../helpers/notify'
  config = require '../../config'

  browserifyOptions =
    entries: [config.src.clientCoreScriptsMain]
    extensions: ['.coffee']

  browserify(browserifyOptions)
    .transform coffeeReactify
    .external config.vendors
    .bundle()
    .on 'error', notify.andExit
    .pipe source 'core.js'
    .pipe buffer()
    .pipe uglify()
    .pipe rev()
    .pipe gulp.dest config.dest.clientRoot
