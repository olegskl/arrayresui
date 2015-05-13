'use strict'

angular.module 'ArrayResUi', [
    'ui.router'
    'restangular'
  ]

  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'editor',
        url: '/editor'
        templateUrl: 'templates/editor/editor.tpl.html'
        controller: 'OutputCtrl'
        controllerAs: 'appOutput'
      .state 'about',
        url: '/about'
        templateUrl: 'templates/about/about.tpl.html'
    $urlRouterProvider
      .when '', '/editor'

  .controller 'OutputCtrl', class OutputCtrl

    # data Criteria = Object
    # data Asset = Object

    # Private
    # --------------------

    # makeSelector :: String, Array -> (Criteria -> [Asset] -> [Asset])
    makeSelector = (idPropertyName, criteriaPropertyNameList) ->
      # unique :: [Object] -> [Object]
      unique = R.uniqWith R.eqProps idPropertyName
      # criteriaMatcher :: Object -> Object
      criteriaMatcher = R.compose R.where, R.pick criteriaPropertyNameList
      # filter :: Object -> [Object] -> [Object]
      filter = R.useWith R.filter, criteriaMatcher, R.identity
      # selector :: Object -> [Object] -> [Object]
      selector = R.compose unique, filter

    # Constructor
    # --------------------

    constructor: (@Assets, @Strategies, @Simulations) ->
      @assetList = @Assets.getList().$object
      @strategyList = @Strategies.getList().$object

      @simulationProps = {}
      ['MIC', 'CCY', 'ISIN', 'date'].forEach (key, i, arr) =>
        Object.defineProperty @simulationProps, key,
          enumerable: true,
          get: => @simulationProps["_#{key}"]
          set: (v) =>
            @simulationProps["_#{key}"] = v
            @simulationProps[arr[i + 1]] = null if not v and i + 1 < arr.length

    # Public
    # --------------------

    # selectMarkets :: Criteria -> [Asset] -> [Asset]
    selectMarkets: makeSelector 'MIC', []

    # selectCurrencies :: Criteria -> [Asset] -> [Asset]
    selectCurrencies: makeSelector 'CCY', ['MIC']

    # selectTickers :: Criteria -> [Asset] -> [Asset]
    selectTickers: makeSelector 'ISIN', ['MIC', 'CCY']

    # selectDates :: Criteria -> [Asset] -> [Asset]
    selectDates: makeSelector 'date', ['MIC', 'CCY', 'ISIN']

    # selectAssets :: Criteria -> [Asset] -> [Asset]
    selectAssets: makeSelector 'id', ['MIC', 'CCY', 'ISIN', 'date']

    # runSimulation :: Criteria, [Asset] -> Promise
    runSimulation: (criteria, assets) ->
      @Simulations
        .post R.head @selectAssets criteria, assets
        .then (response) -> console.log "received response \"#{response}\""
        .catch (error) -> console.error "caught an error #{error}"

  .directive 'appEditor', ($window) ->
    restrict: 'EA'
    link: (scope, element) ->
      editor = $window.ace.edit element[0]
      editor.setTheme 'ace/theme/merbivore_soft'
      editor.getSession().setMode 'ace/mode/scala'
