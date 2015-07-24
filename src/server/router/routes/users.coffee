'use strict'

express = require 'express'

module.exports = (do express.Router)
  .get '/:id', (request, response) ->
    # TODO: this shouldn't use sessions
    response.json request.user
