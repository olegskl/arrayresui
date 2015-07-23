'use strict'

api = require '../modules/api'

exports.fetchMe = -> api.get '/users/me'
