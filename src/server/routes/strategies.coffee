'use strict'

express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

source = "#{__dirname}/../mockResponses/strategies/reply.json"

transformer = (obj) ->
  Object
    .keys obj
    .map (key) ->
      name: key,
      parameters: obj[key].parameters

module.exports = (do express.Router)
  .use '/', sendJSONFile source, transformer
