@ChartComponent = (chartType) ->

  React.createClass
    displayName: "#{chartType}Chart"

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
