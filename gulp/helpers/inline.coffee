#
# Preconfigured inliner of file references into a stream.
# @module gulp/helpers/inline
#

#
# Inlines file references from a given stream to the running stream.
# @param  {Stream}   stream Stream with file references to inline.
# @param  {Function} stream Stream transformer funtion.
# @return {Stream}          Gulp stream.
#
module.exports = inline = (stream, transformer) ->
  gulpInject = require 'gulp-inject'

  gulpInject stream,
    transform: transformer, # custom transformer to force inlining
    name: 'inline' # use with "inline" placeholder <!-- inline:js -->

#
# Inlines JavaScript file references from a given stream to the running stream.
# @param  {Stream} stream Stream with JavaScript file references.
# @return {Stream}        Gulp stream.
#
inline.scripts = (stream) ->
  transform = require './transform'
  inline stream, transform.scripts

#
# Inlines CSS file references from a given stream to the running stream.
# @param  {Stream} stream Stream with CSS file references.
# @return {Stream}        Gulp stream.
#
inline.styles = (stream) ->
  transform = require './transform'
  inline stream, transform.styles
