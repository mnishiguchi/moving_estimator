R = React.DOM

# Canvases for charts
PieChartCanvas = React.createClass
  render: ->
    React.DOM.canvas
      style: { height: 200, width: 200 }

BarChartCanvas = React.createClass
  render: ->
    React.DOM.canvas
      style: { height: 200, width: 400 }


@MovingRecordsApp = React.createClass

  getInitialState: ->
    records: @props.data
    ajax:    false
    barChartInstance: null
    pieChartInstance: null

  getDefaultProps: ->
    records: []

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $unshift: [record] })
    @setState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  # Relpace a record with the new one.
  updateRecord: (record, newRecord) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, newRecord]] })
    @replaceState records: records

  noticeProcessingAjax: ->
    R.div
      className: "alert alert-warning"
      R.i
        className: "fa fa-cog fa-spin fa-3x"
      R.div null,
        "Processing... If this is taking long, please make sure you are online."

  chartsPanel: ->
    R.div
      className: "panel panel-blue"
      R.div
        className: 'panel-heading'
        R.div
          className: "row"
          R.div
            className: "col-xs-3"
            R.div
              className: "fa fa-home fa-5x"
          R.div
            className: "col-xs-9 text-right"
            R.div
              className: 'huge'
              "Total: #{@totalVolume()}"
            R.div null,
              "cubic feet"
      R.div
        className: 'panel-body'
        R.div
          className: 'row text-center'
          R.div
            className: 'col-sm-6'
            React.createElement BarChartCanvas,
              ref: "barChart"
          R.div
            className: 'col-sm-6'
            React.createElement PieChartCanvas,
              ref: "pieChart"

  totalVolume: ->
    sum = 0
    for obj in @state.records
      sum += (obj.volume * obj.quantity)
    sum

  render: ->
    R.div
      className: "app_wrapper"
      @noticeProcessingAjax() if @state.ajax

      R.h2 null, "Moving volume overview"

      @chartsPanel()
      R.hr null

      R.h2 null, "Add a new item"
      React.createElement NewMovingRecordForm,
        handleNewRecord: @addRecord
        roomSuggestions: @props.roomSuggestions
        categorySuggestions: @props.categorySuggestions
      R.hr null

      React.createElement Records,
        records: @state.records,
        handleDeleteRecord: @deleteRecord,
        handleUpdateRecord: @updateRecord

  # Draw the charts after the component has been rendered.
  componentDidMount: ->
    @drawCharts()

  # Update the chart.
  componentDidUpdate: ->
    @drawCharts()

  componentWillUnmount: ->
    # Remove the extra HTML that Chart.js creates.
    @state.barChartInstance.destroy()
    @state.pieChartInstance.destroy()

  # Find the canvas nodes and create charts.
  drawCharts: ->
    canvas = React.findDOMNode(@refs.barChart)
    ctx    = canvas.getContext("2d")
    @state.barChartInstance = new Chart(ctx).Bar(@dataForBarChart())

    canvas = React.findDOMNode(@refs.pieChart)
    ctx    = canvas.getContext("2d")
    @state.pieChartInstance = new Chart(ctx).Pie(@dataForPieChart())

  shuffleArray: (o) ->
    i = o.length
    while i
      j = Math.floor(Math.random() * i)
      x = o[--i]
      o[i] = o[j]
      o[j] = x
    o

  dataForPieChart: ->
    source = @volumeSortedBy("room")
    ary = []
    colors = ["#FE2E2E", "#FE9A2E", "#FE9A2E", "#9AFE2E", "#2EFE2E", "#2EFE9A",
              "#2EFEF7", "#2E9AFE", "#2E2EFE", "#9A2EFE", "#FE2EF7", "#FE2E9A"]
    @shuffleArray(colors)
    for item, i in source
      obj =
        value:     item.volume
        color:     colors[i]
        highlight: colors[i]
        label:     item.room
      ary.push(obj)
    ary

  dataForBarChart: ->
    source = @volumeSortedBy("category")
    labels = source.map (obj) -> obj.category
    data   = source.map (obj) -> obj.volume
    datasets = [
        {
          fillColor:       "rgba(151,187,205,0.5)"
          strokeColor:     "rgba(151,187,205,0.8)"
          highlightFill:   "rgba(151,187,205,0.75)"
          highlightStroke: "rgba(151,187,205,1)"
          data:            data
        }
      ]
    { labels: labels, datasets: datasets }

  # For sorting an array of objects by the value of specified property.
  predicateBy: (prop) ->
    (a, b) ->
      if a[prop] > b[prop]
        return -1
      else if a[prop] < b[prop]
        return 1
      0

  # prop: "room" or "category"
  volumeSortedBy: (prop) ->
    # 1. Filtering
    filtered = {}
    for obj in @state.records
      vol = parseFloat(obj.volume * obj.quantity)
      if filtered.hasOwnProperty(obj[prop])
        filtered[obj[prop]] += vol  # Add up data to the matched key
      else
        filtered[obj[prop]] = vol   # Create a key
    # 2. Converting to an array of data objects
    ary = []
    for room, volume of filtered
      data = {}
      data[prop] = room
      data["volume"] = volume
      ary.push data
    # 3. Sorting
    ary.sort( @predicateBy("volume") )
