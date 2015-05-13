'use strict'

express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

source = "#{__dirname}/../mockResponses/strategies/reply.json"

transformer = (obj) ->
  for key, val of obj
    id: key
    name: key # TODO: replace this real name when available
    parameters: val.parameters

module.exports = (do express.Router)
  .use '/', sendJSONFile source, transformer
