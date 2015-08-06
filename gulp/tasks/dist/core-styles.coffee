#
# Core stylesheet bundler (distribution).
# @module gulp/tasks/dist/core-styles
#

#
# Builds stylesheet bundle.
# @param  {Function} [done] Optional done callback (not used).
# @return {Stream}          Gulp script.
#
module.exports = ->

  gulp = require 'gulp'
  rev = require 'gulp-rev'
  stylus = require 'gulp-stylus'
  plumber = require 'gulp-plumber'
  autoprefixer = require 'gulp-autoprefixer'
  cssmin = require 'gulp-cssmin'
  rev = require 'gulp-rev'

  notify = require '../../helpers/notify'
  config = require '../../config'

  gulp
    .src config.src.clientCoreStylesMain
    .pipe plumber notify.andExit
    .pipe stylus()
    .pipe autoprefixer browsers: config.browsers
    .pipe cssmin()
    .pipe rev()
    .pipe gulp.dest config.dest.clientRoot
