d3 = require 'd3'

module.exports = class PnLChart

  timeFormat = d3.time.format '%H:%M:%S.%L'
  margin =
    top: 20
    right: 30
    bottom: 30
    left: 80

  xAccessor = (d) -> timeFormat.parse d.Time_PnL
  yAccessor = (d) -> parseInt d.PnL, 10

  formatData = (data) ->
    data.map (d) ->
      x: xAccessor d
      y: yAccessor d

  constructor: (@element) ->
    container = d3.select @element
    container
      .append 'path'
      .classed 'pnl', yes
    container
      .append 'g'
      .classed 'x-axis', yes
    container
      .append 'g'
      .classed 'y-axis', yes

  update: (data = []) ->
    data = formatData data

    xExtent = d3.extent data, (d) -> d.x
    yExtent = d3.extent data, (d) -> d.y

    width = @element.clientWidth - margin.left - margin.right
    height = @element.clientHeight - margin.top - margin.bottom

    xRange = [0, width]
    yRange = [height, 0]

    xScale = d3.time.scale().range(xRange).domain(xExtent).nice()
    yScale = d3.scale.linear().range(yRange).domain(yExtent).nice()

    xAxis = d3.svg.axis().scale(xScale).orient('bottom')
    yAxis = d3.svg.axis().scale(yScale).orient('left').ticks(5)

    line = d3.svg.line()
      .x (d) -> xScale d.x
      .y (d) -> yScale d.y

    container = d3.select @element

    container
      .select '.x-axis'
      .attr 'transform', "translate(#{margin.left}, #{margin.top + height})"
      .call xAxis

    container
      .select '.y-axis'
      .attr 'transform', "translate(#{margin.left}, #{margin.top})"
      .call yAxis

    container
      .select 'path.pnl'
      .datum data
      .style 'stroke', 'white'
      .style 'fill', 'none'
      .attr 'transform', "translate(#{margin.left}, #{margin.top})"
      .attr 'd', line
