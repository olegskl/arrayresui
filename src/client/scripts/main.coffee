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

    # Sorts elements in ascending order:
    sortAsc = R.sort R.comparator (a, b) -> a < b
    # Applies sort to unique values:
    uniqueSorted = R.compose sortAsc, R.uniq

    constructor: (Assets, Strategies) ->
      @assets = Assets.getList().$object
      @strategies = Strategies.getList().$object

      @simulationProps = {}
      ['MIC', 'CCY', 'ISIN', 'date'].forEach (key, i, arr) =>
        Object.defineProperty @simulationProps, key,
          enumerable: true,
          get: => @simulationProps["_#{key}"]
          set: (v) =>
            @simulationProps["_#{key}"] = v
            @simulationProps[arr[i + 1]] = null if not v and i + 1 < arr.length

    # Markets
    # --------------------
    marketsAccessor = R.compose uniqueSorted, R.pluck 'MIC'
    getMarkets: -> marketsAccessor @assets

    # Currencies
    # --------------------
    currenciesAccessor = R.compose uniqueSorted, R.pluck 'CCY'
    getCurrencies: (criteria) ->
      filter = R.filter R.where R.pick 'MIC', criteria
      currenciesAccessor filter @assets

    # Tickers
    # --------------------
    tickersAccessor = R.compose uniqueSorted, R.pluck 'ISIN'
    getTickers: (criteria) ->
      filter = R.filter R.where R.pick ['MIC', 'CCY'], criteria
      tickersAccessor filter @assets

    # Dates
    # --------------------
    dateAccessor = R.compose uniqueSorted, R.pluck 'date'
    getDates: (criteria) ->
      filter = R.filter R.where R.pick ['MIC', 'CCY', 'ISIN'], criteria
      dateAccessor filter @assets

    # Simulation runner
    # --------------------
    runSimulation: (criteria) ->
      searchFn = R.where R.pick ['MIC', 'CCY', 'ISIN', 'date'], criteria
      sim = R.find searchFn, @assets
      console.log "submitted simulation #{sim.id}"

  .directive 'appEditor', ($window) ->
    restrict: 'EA'
    link: (scope, element) ->
      editor = $window.ace.edit element[0]
      editor.setTheme 'ace/theme/merbivore_soft'
      editor.getSession().setMode 'ace/mode/scala'
