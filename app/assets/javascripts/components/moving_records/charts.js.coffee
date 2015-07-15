# # https://github.com/jhudson8/react-chartjs/blob/master/dist/react-chartjs.js

## Example
# PieChart = CustomChart.Pie
# MyComponent = React.createClass
#   render: ->
#     React.createElement PieChart
#       data:    chartData
#       options: chartOptions

@CustomChart = (chartType) ->
  console.log chartType
  classData =

    displayName: chartType + 'Chart'

    getInitialState: -> {}

    # Create a canvas element on which a chart will be drawn
    render: ->
      # 1. Wrap up all the props passed in and a ref
      _props = ref: 'canvass'
      for name of @props
        if @props.hasOwnProperty(name)
          if name != 'data' and name != 'options'
            _props[name] = @props[name]
      # 2. Create a <canvas> element with the props
      React.createElement 'canvas', _props

    componentDidMount: ->
      @initializeChart(@props)

    componentWillUnmount: ->
      chart = @state.chart
      chart.destroy()

    componentWillReceiveProps: (nextProps) ->
      chart = @state.chart
      chart.destroy()
      @initializeChart nextProps

    initializeChart: (nextProps) ->
      canvas = React.findDOMNode(this)
      ctx    = canvas.getContext('2d')
      chart  = new Chart(ctx)[chartType](nextProps.data, nextProps.options or {})
      @state.chart = chart

    # return the chartjs instance
    getChart: ->
      @state.chart

    # return the canvass element that contains the chart
    getCanvass: ->
      @refs.canvass.getDOMNode()

  React.createClass(classData)
