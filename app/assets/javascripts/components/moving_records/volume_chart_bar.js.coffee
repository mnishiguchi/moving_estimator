# props.name - for ref
# props.data

chartType = "Bar"
@VolumeBarChart = React.createClass

  getInitialState: ->
    chartInstance: null

  render: ->
    console.log "VolumeBarChart#render"
    console.log @props

    React.DOM.canvas
      ref:   @props.name
      style: { height: 200, width: 400 }

  componentDidMount: ->
    @initializeChart()

  componentDidUpdate:  ->
    @initializeChart()

  componentWillUnmount: ->
    @state.chartInstance.destroy()

  initializeChart: ->
    canvas = React.findDOMNode(@refs[@props.name])
    ctx    = canvas.getContext("2d")
    chart  = new Chart(ctx).Bar(@props.data)
    @setState.chartInstance = chart
