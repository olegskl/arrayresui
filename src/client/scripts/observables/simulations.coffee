R = require 'ramda'
Rx = require 'rx'

dispatcher = require '../dispatcher'

options =
  method: 'post'
  headers:
    'Accept': 'application/json'
    'Content-Type': 'application/json'

module.exports = Rx.Observable
  .fromEvent dispatcher, 'simulation'
  .flatMap (payload) ->
    options = R.merge options, body: JSON.stringify payload
    fetch '/api/simulations/', options
      .then (response) -> do response.json
      .then (data) ->
        request: payload
        response: data
