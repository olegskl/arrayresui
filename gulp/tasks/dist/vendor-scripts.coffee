#
# Vendor scripts task (distribution).
# @module gulp/tasks/dist/vendor-scripts
#

#
# Bundles optimized vendor scripts and exposes them to external require calls.
# @param  {Function} [done] Optional done callback (not used).
# @return {Stream}          Generated optimized vendor bundle stream.
#
module.exports = ->

  gulp = require 'gulp'
  rev = require 'gulp-rev'
  uglify = require 'gulp-uglify'
  source = require 'vinyl-source-stream'
  buffer = require 'vinyl-buffer'

  config = require '../../config'
  bundleDependencies = require '../../helpers/bundleDependencies'
  notify = require '../../helpers/notify'

  return bundleDependencies(config.vendors)
    .on 'error', notify.andExit
    .pipe source 'vendors.js'
    .pipe buffer()
    .pipe uglify()
    .pipe rev()
    .pipe gulp.dest config.dest.clientRoot
