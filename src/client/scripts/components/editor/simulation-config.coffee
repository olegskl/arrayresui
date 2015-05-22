# data Criteria = Object
# data Asset = Object
# data Strategy = Object

R = require 'ramda'
React = require 'react'

Selector = require './selector'
dispatcher = require '../../dispatcher'

# Private
# --------------------

# compareByContentAsc :: [Object] -> [Object] -> Boolean
compareByContentAsc = R.comparator (a, b) -> a.content < b.content

# sortByContentAsc :: [Object] -> [Object]
sortByContentAsc = R.sort compareByContentAsc

# makeFilter :: String, Array -> (Criteria -> [Asset] -> [Asset])
makeFilter = (idPropertyName, criteriaPropertyNameList) ->
  # unique :: [Object] -> [Object]
  unique = R.uniqWith R.eqProps idPropertyName
  # criteriaMatcher :: Object -> Object -> Boolean
  criteriaMatcher = R.compose R.whereEq, R.pick criteriaPropertyNameList
  # filter :: Object -> [Object] -> [Object]
  filter = R.useWith R.filter, criteriaMatcher, R.identity
  # uniqueFilter :: [Object] -> [Object]
  uniqueFilter = R.compose unique, filter

# makeSelector :: String -> [Strategy]
makeSelector = (idPropertyName) ->
  # transform :: [Object] -> [Object]
  transform = R.map (o) ->
    value: o[idPropertyName]
    content: o[idPropertyName]
  # selector :: Object -> [Object] -> [Object]
  selector = R.compose sortByContentAsc, transform

# makeSelector :: String, Array -> (Criteria -> [Asset] -> [Asset])
makeFilteredSelector = (idPropertyName, criteriaPropertyNameList) ->
  # filter :: Criteria -> [Asset] -> [Asset]
  filter = makeFilter idPropertyName, criteriaPropertyNameList
  # selector :: Object -> [Object] -> [Object]
  selector = makeSelector idPropertyName, criteriaPropertyNameList
  # Object -> [Object] -> [Object]
  R.compose selector, filter

# selectStrategies :: Criteria -> [Asset] -> [Asset]
selectStrategies = makeSelector 'id'

# selectMarkets :: Criteria -> [Asset] -> [Asset]
selectMarkets = makeFilteredSelector 'MIC', []

# selectCurrencies :: Criteria -> [Asset] -> [Asset]
selectCurrencies = makeFilteredSelector 'CCY', ['MIC']

# selectTickers :: Criteria -> [Asset] -> [Asset]
selectTickers = makeFilteredSelector 'ISIN', ['MIC', 'CCY']

# selectDates :: Criteria -> [Asset] -> [Asset]
selectDates = makeFilteredSelector 'date', ['MIC', 'CCY', 'ISIN']

# strategyFilter :: Criteria -> [Strategy] -> [Strategy]
strategyFilter = makeFilter 'id', ['id']
# findStrategy :: [Strategy] -> Strategy
findStrategy = R.compose R.head, strategyFilter

# assetFilter :: Criteria -> [Asset] -> [Asset]
assetFilter = makeFilter 'id', ['MIC', 'CCY', 'ISIN', 'date']
# findAsset :: [Asset] -> Asset
findAsset = R.compose R.head, assetFilter

# Public
# --------------------

# SimulationConfig component:
module.exports = React.createClass

  propTypes:
    assets: React.PropTypes.array
    strategies: React.PropTypes.array

  getDefaultProps: ->
    assets: []
    strategies: []

  getInitialState: ->
    strategyId: 'strategy_12'
    MIC: 'MIC0'
    CCY: 'CCY0'
    ISIN: 'ISIN0'
    date: '05-07'

  isStrategySelectorDisabled: -> no # always enabled
  isMarketSelectorDisabled: -> no # always enabled
  isCurrencySelectorDisabled: -> if @state.MIC then no else yes
  isTickerSelectorDisabled: -> if @state.CCY then no else yes
  isDateSelectorDisabled: -> if @state.ISIN then no else yes

  isSimulationRunnerDisabled: ->
    if @state.date and @state.strategyId then no else yes

  handleStrategyChange: (value) ->
    @setState strategyId: value

  handleMarketChange: (value) ->
    @setState MIC: value
    @handleCurrencyChange null

  handleCurrencyChange: (value) ->
    @setState CCY: value
    @handleTickerChange null

  handleTickerChange: (value) ->
    @setState ISIN: value
    @handleDateChange null

  handleDateChange: (value) ->
    @setState date: value

  runSimulation: ->
    simulationProps =
      asset: findAsset @state, @props.assets
      strategy: findStrategy {id: @state.strategyId}, @props.strategies
    dispatcher.emit 'simulation', simulationProps

  render: ->

    strategyValues = selectStrategies @props.strategies
    marketValues = selectMarkets @state, @props.assets
    currencyValues = selectCurrencies @state, @props.assets
    tickerValues = selectTickers @state, @props.assets
    dateValues = selectDates @state, @props.assets

    <header className="app-input__header">
      <div className="app-input__control-group">
        <Selector
         label="Strategy"
         value={@state.strategyId}
         valueList={strategyValues}
         isDisabled={do @isStrategySelectorDisabled}
         changeHandler={@handleStrategyChange}/>
        <Selector
         label="Market"
         value={@state.MIC}
         valueList={marketValues}
         isDisabled={do @isMarketSelectorDisabled}
         changeHandler={@handleMarketChange}/>
        <Selector
         label="Currency"
         value={@state.CCY}
         valueList={currencyValues}
         isDisabled={do @isCurrencySelectorDisabled}
         changeHandler={@handleCurrencyChange}/>
        <Selector
         label="Ticker"
         value={@state.ISIN}
         valueList={tickerValues}
         isDisabled={do @isTickerSelectorDisabled}
         changeHandler={@handleTickerChange}/>
        <Selector
         label="Date"
         value={@state.date}
         valueList={dateValues}
         isDisabled={do @isDateSelectorDisabled}
         changeHandler={@handleDateChange}/>
      </div>
      <button
       className="app-input__submit"
       onClick={@runSimulation}
       disabled={do @isSimulationRunnerDisabled}>
        Run simulation
      </button>
    </header>
