#
# Stylesheet bundler (development).
# @module gulp/tasks/dev/client-styles
#

#
# Builds and reloads stylesheet bundles.
# @param  {Function}  [done] Optional done callback called when all is built.
# @return {Stream}           Gulp stream with stylesheet files.
#
module.exports = ->
  gulp = require 'gulp'
  stylus = require 'gulp-stylus'
  sourcemaps = require 'gulp-sourcemaps'
  autoprefixer = require 'gulp-autoprefixer'
  plumber = require 'gulp-plumber'
  browserSync = require 'browser-sync'

  notify = require '../../helpers/notify'
  config = require '../../config'

  runningBrowserSync = browserSync.get 'default'

  gulp
    .src config.src.clientCoreStylesMain
    .pipe do sourcemaps.init
    .pipe plumber notify.andContinue
    .pipe do stylus
    .pipe autoprefixer browsers: config.browsers
    .pipe do sourcemaps.write
    .pipe gulp.dest config.dest.clientRoot
    .pipe runningBrowserSync.reload stream: true
