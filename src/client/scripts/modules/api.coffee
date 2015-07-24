'use strict'

R = require 'ramda'
dispatcher = require '../dispatcher'

generateOptions = (method) ->
  method: method
  credentials: 'same-origin'
  headers:
    'Accept': 'application/json'
    'Content-Type': 'application/json'

['get', 'post', 'put', 'delete'].forEach (method) ->
  fetchOptions = generateOptions method
  exports[method] = (url, customOptions) ->
    mergedOptions = R.merge fetchOptions, customOptions
    fetch "/api#{url}", mergedOptions
      .then (response) ->
        if response.status is 401
          dispatcher.emit 'auth', null
          throw new Error "#{response.status} #{response.statusText}"
        response
      .then (response) -> do response.json
