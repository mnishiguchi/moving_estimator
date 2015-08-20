# Chart.js configuration

Chart.defaults.global.tooltipEvents = ["mousemove", "touchstart", "touchmove"]
Chart.defaults.global.scaleLabel    = "<%=value%>cu.ft"

class @Components.ChartComponent
  # console.log "Components.Chart was called"

  constructor: (chartType)->
    return @createClass(chartType)

  createClass: (chartType) ->

    React.createClass
      displayName: "#{chartType}Chart"
      propTypes:
        name:    React.PropTypes.string
        data:    React.PropTypes.oneOfType([React.PropTypes.array, React.PropTypes.object])
        height:  React.PropTypes.number
        width:   React.PropTypes.number
        options: React.PropTypes.object

      getInitialState: ->
        chartInstance: null

      render: ->
        React.DOM.canvas
          ref:   @props.name
          style: { height: @props.height, width: @props.width }

      componentDidMount: ->
        @initializeChart()

      componentWillUnmount: ->
        @state.chartInstance.destroy() if @state.chartInstance

      initializeChart: ->
        canvas = React.findDOMNode(@refs[@props.name])
        ctx    = canvas.getContext("2d")
        chart  = new Chart(ctx)[chartType](@props.data)
        @setState.chartInstance = chart
