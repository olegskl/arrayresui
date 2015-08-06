#
# Vendor scripts task (development).
# @module gulp/tasks/dev/vendor-scripts
#

#
# Bundles vendor scripts and exposes them to external require calls.
# @param  {Function} [done] Optional done callback (we don't need to use it).
# @return {Stream}          Generated vendor bundle stream.
#
module.exports = ->

  gulp = require 'gulp'
  source = require 'vinyl-source-stream'

  config = require '../../config'
  bundleDependencies = require '../../helpers/bundleDependencies'
  notify = require '../../helpers/notify'

  bundleDependencies config.vendors
    .on 'error', notify.andContinue
    .pipe source 'vendors.js'
    .pipe gulp.dest config.dest.clientRoot
