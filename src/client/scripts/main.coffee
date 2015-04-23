'use strict'

angular
  .module 'ArrayResUi', [
    'ui.router'
    'restangular'
  ]

  .config ($stateProvider, $urlRouterProvider) ->

    class OutputController
      constructor: (Assets, Strategies) ->
        @assets = (do Assets.getList).$object
        @strategies = (do Strategies.getList).$object

    $stateProvider
      .state 'editor',
        url: '/editor'
        templateUrl: 'templates/editor/editor.tpl.html'
        controller: OutputController
        controllerAs: 'appOutput'
      .state 'about',
        url: '/about'
        templateUrl: 'templates/about/about.tpl.html'

    $urlRouterProvider
      .when '', '/editor'

  .directive 'appEditor', ($window) ->
    restrict: 'EA'
    link: (scope, element) ->
      editor = $window.ace.edit element[0]
      editor.setTheme 'ace/theme/merbivore_soft'
      editor.getSession().setMode 'ace/mode/scala'


