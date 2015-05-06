'use strict'

_ = require 'lodash'
express = require 'express'
sendJSONFile = require '../utils/sendJSONFile'

flatten = (source, fields, seed = {}) ->
  _.flatten (for key, value of source
      seed[fields[0]] = key
      if fields.length > 1
        flatten value, (_.rest fields), seed
      else
        _.assign value, seed)

transformer = (obj) ->
  flatten obj, ['market', 'currency', 'asset']

source = "#{__dirname}/../mockResponses/assets/reply.json"

module.exports = (do express.Router)
  .use '/', sendJSONFile source, transformer
