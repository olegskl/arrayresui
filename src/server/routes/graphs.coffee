'use strict'

fs = require 'fs'
express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

rootDir = "#{__dirname}/../mockResponses/graph/"

module.exports = (do express.Router)
  .get '/:graphName/:assetId/:strategyId/:simulationId', (request, response) ->
    { graphName, assetId, strategyId, simulationId } = request.params
    fileName = "#{rootDir}#{graphName}/#{assetId}/#{strategyId}/#{simulationId}/reply.csv"
    fs.readFile fileName, 'utf8', (err, data) ->
      response
        .status 200
        .type 'text/csv'
        .send data
