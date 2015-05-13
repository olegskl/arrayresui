'use strict'

angular.module 'ArrayResUi'

  .config (RestangularProvider) ->
    RestangularProvider.setBaseUrl '/api'

  .service 'Assets', (Restangular) ->
    Restangular.service 'assets'

  .service 'Strategies', (Restangular) ->
    Restangular.service 'strategies'

  .service 'Simulations', (Restangular) ->
    Restangular.service 'simulations'
