#
# Index file builder (development).
# @module gulp/tasks/dev/index-file
#

#
# Returns a processed stream of critical styles.
# @param  {Object} config Gulp configuration object.
# @return {Stream}        Processed critical styles stream.
#
streamCriticalStyles = (config) ->
  gulp = require 'gulp'
  stylus = require 'gulp-stylus'
  plumber = require 'gulp-plumber'
  base64 = require 'gulp-base64'
  autoprefixer = require 'gulp-autoprefixer'

  notify = require '../../helpers/notify'

  gulp
    .src config.src.clientCriticalStylesMain
    .pipe plumber notify.andContinue
    .pipe stylus()
    .pipe autoprefixer browsers: config.browsers
    .pipe base64 maxImageSize: 128

#
# Returns a processed stream of critical scripts.
# @param  {Object} config Gulp configuration object.
# @return {Stream}        Processed critical scripts stream.
#
streamCriticalScripts = (config) ->
  browserify = require 'browserify'
  coffeeReactify = require 'coffee-reactify'
  source = require 'vinyl-source-stream'
  buffer = require 'vinyl-buffer'

  config = require '../../config'
  notify = require '../../helpers/notify'

  browserify(config.src.clientCriticalScriptsMain)
    .transform [coffeeReactify]
    .bundle()
    .on 'error', notify.andContinue
    .pipe source 'critical.js'
    .pipe buffer()

#
# Returns a stream of core styles.
# @param  {Object} config Gulp configuration object.
# @return {Stream}        Core styles stream.
#
streamCoreStyles = (config) ->
  gulp = require 'gulp'
  gulp.src config.dest.clientCoreStyles

#
# Returns a stream of core scripts.
# @param  {Object} config Gulp configuration object.
# @return {Stream}        Core scripts stream.
#
streamCoreScripts = (config) ->
  gulp = require 'gulp'
  gulp.src config.dest.clientCoreScripts

#
# Returns a stream of vendor scripts.
# @param  {Object} config Gulp configuration object.
# @return {Stream}        Vendor scripts stream.
#
streamVendorScripts = (config) ->
  gulp = require 'gulp'
  gulp.src config.dest.clientVendorScripts

#
# Builds the index file.
# @param  {Function} [done] Optional done callback (not needed).
# @return {Stream}          Generated index file stream.
#
module.exports = ->
  gulp = require 'gulp'
  series = require 'stream-series'
  browserSync = require 'browser-sync'

  config = require '../../config'
  inline = require '../../helpers/inline'
  inject = require '../../helpers/inject'

  runningBrowserSync = browserSync.get 'default'
  streamingVendorScripts = streamVendorScripts config
  streamingCoreScripts = streamCoreScripts config

  gulp
    .src config.src.clientIndex
    .pipe inline.styles streamCriticalStyles config
    .pipe inline.scripts streamCriticalScripts config
    .pipe inject streamCoreStyles config
    .pipe inject series streamingVendorScripts, streamingCoreScripts
    .pipe gulp.dest config.dest.clientRoot
    .pipe runningBrowserSync.reload stream: yes
