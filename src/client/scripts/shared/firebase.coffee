Firebase = require 'firebase'
dispatcher = require '../dispatcher'

ref = module.exports = new Firebase 'https://arrayres.firebaseio.com'

ref.onAuth (authData) -> dispatcher.emit 'auth', authData
