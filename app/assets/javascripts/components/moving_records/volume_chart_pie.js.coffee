# props.name - for ref
# props.data

# chartType = "Pie"
# @VolumePieChart = React.createClass

#   getInitialState: ->
#     chartInstance: null

#   render: ->
#     React.DOM.canvas
#       ref:   @props.name
#       style: { height: 200, width: 200 }

#   componentDidMount: ->
#     @initializeChart()

#   componentDidUpdate:  ->
#     @state.chartInstance.destroy()
#     @initializeChart()

#   initializeChart: ->
#     canvas = React.findDOMNode(@refs[@props.name])
#     ctx    = canvas.getContext("2d")
#     chart  = new Chart(ctx)[chartType](@props.data)
#     @state.chartInstance = chart
