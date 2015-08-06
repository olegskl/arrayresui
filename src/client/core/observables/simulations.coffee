Rx = require 'rx'

api = require '../modules/api'
dispatcher = require '../dispatcher'

module.exports = Rx.Observable
  .fromEvent dispatcher, 'simulation'
  .flatMap (payload) ->
    options = body: JSON.stringify payload
    api.post '/simulations/', options
      .then (data) ->
        request: payload
        response: data
