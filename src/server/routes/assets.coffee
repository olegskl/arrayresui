'use strict'

express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

transformer = (obj) ->
  for key, val of obj
    id: key
    MIC: val.MIC
    CCY: val.CCY
    ISIN: val.ISIN
    ticker: val.ticker
    date: val.Date

source = "#{__dirname}/../mockResponses/assets/reply.json"

module.exports = (do express.Router)
  .use '/', sendJSONFile source, transformer
