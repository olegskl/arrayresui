Promise = require 'promise'
d3 = require 'd3'

simulations = require './simulations'

tsv = Promise.denodeify d3.tsv

generateRequestDataList = (response) ->
  response.response.resultGraphs.map (graphName) ->
    graphName: graphName
    assetId: response.request.asset.id
    strategyId: response.request.strategy.id
    simulationId: response.response.id

module.exports = simulations
  .flatMap (response) ->

    requests = generateRequestDataList response
      .map (requestData) ->
        { graphName, assetId, strategyId, simulationId } = requestData
        tsv "/api/graphs/#{graphName}/#{assetId}/#{strategyId}/#{simulationId}"

    Promise.all requests
