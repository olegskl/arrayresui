#
# Scripts bundler (development).
# @module gulp/tasks/dev/client-scripts
#

setupBundle = (bundleMain, externalDeps) ->
  r = require 'ramda'
  browserify = require 'browserify'
  watchify = require 'watchify'
  coffeeReactify = require 'coffee-reactify'

  options = r.merge watchify.args,
    entries: [bundleMain]
    extensions: ['.coffee']
    debug: yes

  browserify(options)
    .transform coffeeReactify
    .external externalDeps

buildBundle = (bundle, bundleDest) ->
  gulp = require 'gulp'
  sourcemaps = require 'gulp-sourcemaps'
  source = require 'vinyl-source-stream'
  buffer = require 'vinyl-buffer'

  notify = require '../../helpers/notify'

  bundle
    .bundle()
    .on 'error', notify.andContinue
    .pipe source 'core.js'
    .pipe buffer()
    .pipe sourcemaps.init loadMaps: yes
    .pipe sourcemaps.write()
    .pipe gulp.dest bundleDest

reloadBundle = (bundle) ->
  browserSync = require 'browser-sync'
  runningBrowserSync = browserSync.get 'default'

  bundle
    .pipe runningBrowserSync.reload stream: true

module.exports = ->
  watchify = require 'watchify'
  gutil = require 'gulp-util'

  config = require '../../config'

  bundleDeps = config.vendors
  bundleMain = config.src.clientCoreScriptsMain
  bundleDest = config.dest.clientRoot

  bundleSetup = setupBundle bundleMain, bundleDeps
  bundle = buildBundle bundleSetup, bundleDest

  watcher = watchify bundleSetup, verbose: true
  watcher.on 'update', -> reloadBundle buildBundle bundleSetup, bundleDest
  watcher.on 'log', gutil.log

  bundle
