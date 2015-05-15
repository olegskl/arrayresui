'use strict'

express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

module.exports = (do express.Router)
  .post '/', (request, response) ->
    # Just sending back the response for now...
    response.send request.body
