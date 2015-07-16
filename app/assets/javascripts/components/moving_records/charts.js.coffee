# chartType - e.g. "Bar", "Pie"
# props.name - for ref
# props.data - for drawing a chart
# props.height - for canvas dimension
# props.width  - for canvas dimension

@CustomChart = (chartType) ->

  React.createClass
    displayName: chartType + 'Chart'

    getInitialState: ->
      chartInstance: null

    render: ->
      React.DOM.canvas
        ref:   @props.name
        style: { height: @props.height, width: @props.width }

    componentDidMount: ->
      @initializeChart()

    componentDidUpdate:  ->
      @state.chartInstance.destroy()
      @initializeChart()

    initializeChart: ->
      canvas = React.findDOMNode(@refs[@props.name])
      ctx    = canvas.getContext("2d")
      chart  = new Chart(ctx)[chartType](@props.data)
      @setState.chartInstance = chart
