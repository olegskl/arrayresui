'use strict'

angular
  .module 'ArrayResUi'

  .config (RestangularProvider) ->
    RestangularProvider.setBaseUrl '/api'

  .factory 'Assets', (Restangular) ->
    Restangular.service 'assets'

  .factory 'Strategies', (Restangular) ->
    Restangular.service 'strategies'
