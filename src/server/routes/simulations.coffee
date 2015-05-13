'use strict'

express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

source = "#{__dirname}/../mockResponses/simulations/reply.json"

module.exports = (do express.Router)
  .get '/', sendJSONFile source
  .post '/', (request, response) ->
    response.send 'new simulation created from ' + JSON.stringify request.body
