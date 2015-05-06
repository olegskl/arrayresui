'use strict'

fs = require 'fs'
express = require 'express'

module.exports = (do express.Router)
  .use '/assets', require './routes/assets'
  .use '/strategies', require './routes/strategies'
  .use '/simulations', require './routes/simulations'
