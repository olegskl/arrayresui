#
# Bundler of dependencies.
# @module gulp/helpers/bundleDependencies
#

#
# Bundles given dependencies with Browserify.
# @param  {[String]} dependencies List of dependencies to bundle.
# @return {Stream}                Browserify stream.
#
module.exports = (dependencies) ->

  browserify = require 'browserify'
  d3Builder = require 'd3-builder'

  d3CustomModules = [
    'selection/selection'
    'svg/line'
    'time/scale'
  ]

  d3CustomBuild = d3Builder d3CustomModules...

  #
  # Determines if a dependency is D3.
  # @param  {String}  dependency Name of dependency.
  # @return {Boolean}            True if not D3, false otherwise.
  #
  isNotD3 = (dependency) -> dependency isnt 'd3'

  browserify()
    # We would like to have D3 in production dependencies,
    # but D3 is too big, so we need to secretly swap it
    # with a custom build containing only the modules
    # that are necessary to this project:
    # .require dependencies.filter isNotD3
    # .require d3CustomBuild, expose: 'd3'
    .require dependencies
    .bundle()
