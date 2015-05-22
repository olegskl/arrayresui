d3 = require 'd3'
Promise = require 'promise'

simulations = require './simulations'

generateRequestDataList = (response) ->
  response.response.resultGraphs.map (graphName) ->
    graphName: graphName
    assetId: response.request.asset.id
    strategyId: response.request.strategy.id
    simulationId: response.response.id

tsv = Promise.denodeify d3.tsv

request = (requestData) ->
  { graphName, assetId, strategyId, simulationId } = requestData
  tsv "/api/graphs/#{graphName}/#{assetId}/#{strategyId}/#{simulationId}"

sims = simulations
  .filter (x) -> Array.isArray x?.response?.resultGraphs
  .flatMap generateRequestDataList

exports.pnl = sims
  .filter (x) -> x.graphName is 'pnl'
  .flatMap request

exports.position = sims
  .filter (x) -> x.graphName is 'position'
  .flatMap request
