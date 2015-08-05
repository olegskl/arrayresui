#
# Preconfigured injector of file references into a stream.
# @module gulp/helpers/inject
#

#
# Injects file references from a given stream to the running stream.
# @param  {Stream} stream Stream with file references.
# @return {Stream}        Gulp stream.
#
module.exports = (stream) ->
  gulpInject = require 'gulp-inject'
  config = require '../config'

  gulpInject stream,
    ignorePath: config.dest.clientRoot, # remove "build/server/" from paths
    name: 'inject' # use with "inject" prefix, e.g. <!-- inject:js -->
