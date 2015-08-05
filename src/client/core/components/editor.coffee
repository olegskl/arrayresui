React = require 'react'

Input = require './editor/input'
Output = require './editor/output'

module.exports = React.createClass
  render: ->
    <section className="app-main">
      <Input/>
      <Output/>
    </section>