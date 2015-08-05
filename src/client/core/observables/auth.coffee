{ Observable } = require 'rx'

dispatcher = require '../dispatcher'

module.exports = Observable
  .fromEvent dispatcher, 'auth'
