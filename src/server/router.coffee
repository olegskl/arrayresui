# Mock API resource router.
# Ideally should proxy to the backend.

'use strict'

fs = require 'fs'
express = require 'express'

module.exports = router = do express.Router

# TODO: refactor this
router.use '/assets', (req, res) ->
  fileName = "#{__dirname}/mockResponses/assets.json"
  fs.readFile fileName, 'utf8', (err, data) ->
    res.json JSON.parse data

# TODO: refactor this
router.use '/strategies', (req, res) ->
  fileName = "#{__dirname}/mockResponses/strategies.json"
  fs.readFile fileName, 'utf8', (err, data) ->
    res.json JSON.parse data