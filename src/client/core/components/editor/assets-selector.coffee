# data Criteria = Object
# data Asset = Object

React = require 'react'

Selector = require './selector'
{ makeSelector, makeFilteredSelector, makeFilter } = require './maker'

# Private
# --------------------

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

# findAssets :: Criteria -> [Asset] -> [Asset]
findAssets = makeFilter 'id', ['MIC', 'CCY', 'ISIN', 'date']

# Public
# --------------------

# AssetsSelector
module.exports = React.createClass

  propTypes:
    assets: React.PropTypes.array
    changeHandler: React.PropTypes.func.isRequired

  getDefaultProps: ->
    assets: []

  getInitialState: ->
    MIC: 'MIC0'
    CCY: 'CCY0'
    ISIN: 'ISIN0'
    date: '05-07'

  isMarketSelectorDisabled: -> no # always enabled
  isCurrencySelectorDisabled: -> if @state.MIC then no else yes
  isTickerSelectorDisabled: -> if @state.CCY then no else yes
  isDateSelectorDisabled: -> if @state.ISIN then no else yes

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

  updateAssetList: ->
    assets = findAssets @state, @props.assets
    @props.changeHandler assets

  componentDidUpdate: ->
    do @updateAssetList

  render: ->

    marketValues = selectMarkets @state, @props.assets
    currencyValues = selectCurrencies @state, @props.assets
    tickerValues = selectTickers @state, @props.assets
    dateValues = selectDates @state, @props.assets

    <div className="app-input__header">
      <div className="app-input__control-group">
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
    </div>
