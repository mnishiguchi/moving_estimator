# props.name - for ref
# props.data

chartType = "Pie"
@VolumePieChart = React.createClass

  getInitialState: ->
    chartInstance: null

  render: ->
    console.log "VolumePieChart#render"
    console.log @props

    React.DOM.canvas
      ref:   @props.name
      style: { height: 200, width: 200 }

  componentDidMount: ->
    @initializeChart()

  componentDidUpdate:  ->
    @initializeChart()

  componentWillUnmount: ->
    @state.chartInstance.destroy()

  initializeChart: ->
    canvas = React.findDOMNode(@refs[@props.name])
    ctx    = canvas.getContext("2d")
    chart  = new Chart(ctx).Pie(@props.data)
    @setState.chartInstance = chart
