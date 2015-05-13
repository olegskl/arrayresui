'use strict'

express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

source = "#{__dirname}/../mockResponses/simulations/reply.json"

module.exports = (do express.Router)
  .use '/', sendJSONFile source