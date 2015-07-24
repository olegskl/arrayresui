fs = require 'fs'
R = require 'ramda'

express = require 'express'
sendJSONFile = require '../../utils/sendJSONFile'

getFileName = (assetId, strategyId) ->
  "#{__dirname}/../../mockResponses/history/#{assetId}/#{strategyId}/reply.json"

module.exports = (do express.Router)
  .post '/', (request, response) ->
    params = request.body
    fileName = getFileName params.asset.id, params.strategy.id
    fs.readFile fileName, 'utf8', (err, data) ->

      if err
        return response.status 500
          .type 'text/plain'
          .send err

      data = JSON.parse data
      id = R.head R.keys data
      data[id].id = id
      response.json data[id]
