'use strict'

fs = require 'fs'

module.exports = (fileName, transformer) ->
  (req, res) ->
    fs.readFile fileName, 'utf8', (err, data) ->
      if transformer
        res.json transformer JSON.parse data
      else
        res
          .status 200
          .type 'application/json'
          .send data

