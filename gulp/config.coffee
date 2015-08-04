#
# Build system configuration.
# @module gulp/config
#

minimist = require 'minimist'

argv = minimist process.argv[2..]

src = {}
dest = {}

module.exports =
  src: src
  dest: dest
  browsers: ['last 2 versions']
  vendors: [
    'brace'
    'brace/mode/scala'
    'brace/theme/merbivore_soft'
    'event-emitter'
    'd3'
    'promise'
    'ramda'
    'react'
    'react-router'
    'rx'
    'whatwg-fetch'
  ]

#
# Source files and folders
# --------------------

src.package = 'package.json'

src.clientRoot = 'src/client'

src.clientIndex = "#{src.clientRoot}/index.html"
src.clientFavicon = "#{src.clientRoot}/favicon.ico"

src.clientCriticalStyles = "#{src.clientRoot}/critical**/*.styl"
src.clientCriticalScripts = "#{src.clientRoot}/critical/**/*.coffee"
src.clientCriticalStylesMain = "#{src.clientRoot}/critical/critical.styl"
src.clientCriticalScriptsMain = "#{src.clientRoot}/critical/critical.coffee"

src.clientCoreStyles = "#{src.clientRoot}/core/**/*.styl"
src.clientCoreScripts = "#{src.clientRoot}/core/**/*.coffee"
src.clientCoreStylesMain = "#{src.clientRoot}/core/core.styl"
src.clientCoreScriptsMain = "#{src.clientRoot}/core/core.coffee"

src.serverRoot = 'src/server'
src.serverScripts = "#{src.serverRoot}/**/*.coffee"
src.serverData = [
  "#{src.serverRoot}/**/*.json"
  "#{src.serverRoot}/**/*.csv"
]

#
# Source files and folders
# --------------------

dest.buildRoot = argv.dest or 'build'

dest.serverRoot = "#{dest.buildRoot}/server"

dest.clientRoot = "#{dest.serverRoot}/static"

dest.clientCoreStyles = "#{dest.clientRoot}/core*.css"
dest.clientCoreScripts = "#{dest.clientRoot}/core*.js"
dest.clientVendorScripts = "#{dest.clientRoot}/vendors*.js"
