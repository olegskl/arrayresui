#
# BrowserSync server creator (development).
# @module gulp/tasks/dev/browser-sync-create
#

#
# Creates an instance of BrowserSync server.
# @param  {Function} [done] Optional done callback (not used).
# @return {Object}          BrowserSync instance.
#
module.exports = ->
  browserSync = require 'browser-sync'
  browserSync.create 'default'
