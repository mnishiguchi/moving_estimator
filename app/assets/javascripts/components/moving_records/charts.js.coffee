# chartType - e.g. "Bar", "Pie"

@CustomChart = (chartType) ->

  # props.name - for ref
  # props.data - for drawing a chart
  # props.height - for canvas dimension
  # props.width  - for canvas dimension

  React.createClass
    displayName: chartType + 'Chart'

    getInitialState: ->
      chartInstance: null

    # Create a canvas element on which a chart will be drawn
    render: ->
      # Create a <canvas> element with the props
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
      @state.chartInstance = chart
