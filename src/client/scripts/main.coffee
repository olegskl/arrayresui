'use strict'

angular
  .module 'ArrayResUi', ['ui.router']

  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'editor',
        url: '/editor'
        templateUrl: 'templates/editor/editor.tpl.html'
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


