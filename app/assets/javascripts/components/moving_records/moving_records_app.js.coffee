# @props.id
# @props.data
# @props.volumeByCategories
# @props.volumeByRooms

R = React.DOM

# Canvases for charts
PieChartCanvas = React.createClass
  render: ->
    React.DOM.canvas
      id:    @props.id
      style: { height: 200, width: 200 }

BarChartCanvas = React.createClass
  render: ->
    React.DOM.canvas
      id:    @props.id
      style: { height: 200, width: 200 }

@MovingRecordsApp = React.createClass

  getInitialState: ->
    records: @props.data
    ajax:    false

  getDefaultProps: ->
    records: []

  # Draw the charts after the component has been rendered.
  componentDidMount: ->
    @drawCharts()

  # Update the chart.
  componentDidUpdate: ->
    @drawCharts()

  # Find the canvas nodes and create charts.
  drawCharts: ->
    canvas = document.getElementById("chart")
    ctx    = canvas.getContext("2d")
    chart  = new Chart( ctx ).Pie(@dataForPie())

    canvas = document.getElementById("bar")
    ctx    = canvas.getContext("2d")
    bar    = new Chart( ctx ).Bar(@dataForGraph())

  shuffleArray: (o) ->
    i = o.length
    while i
      j = Math.floor(Math.random() * i)
      x = o[--i]
      o[i] = o[j]
      o[j] = x
    o

  dataForPie: ->
    # sample data
    volumeByRooms = [
        {
          room: ""
          volume: 300
        }
        {
          room: ""
          volume: 200
        }
        {
          room: ""
          volume:  100
        }
      ]
    ary = []
    colors = ["#995577", "#005588", "#668833", "#CC7700", "#665533", "#883355",
              "#AA3333", "#446633", "3388AA", "#CC5522", "#999988", "#DD5555"]
    @shuffleArray(colors)
    for item in volumeByRooms
      numOfColors = colors.length
      color = colors.pop(Math.floor(Math.random() * numOfColors))
      obj =
        value:     item.volume
        color:     color
        highlight: color
        label:     item.room
      ary.push(obj)
    ary

  dataForGraph: ->
    labels:   ["January", "February", "March", "April", "May", "June", "July"]
    datasets: [
        {
          label:           "My First dataset"
          fillColor:       "rgba(220,220,220,0.5)"
          strokeColor:     "rgba(220,220,220,0.8)"
          highlightFill:   "rgba(220,220,220,0.75)"
          highlightStroke: "rgba(220,220,220,1)"
          data:            [65, 59, 80, 81, 56, 55, 40]
        }
        {
          label:           "My Second dataset"
          fillColor:       "rgba(151,187,205,0.5)"
          strokeColor:     "rgba(151,187,205,0.8)"
          highlightFill:   "rgba(151,187,205,0.75)"
          highlightStroke: "rgba(151,187,205,1)"
          data:            [28, 48, 40, 19, 86, 27, 90]
        }
      ]
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

  # prop: "room" or "category"
  volumeSortedBy: (prop)->
    hash = {}
    for obj in @state.records
      vol = parseFloat(obj.volume * obj.quantity)
      if hash.hasOwnProperty(obj[prop])
        hash[obj[prop]] += vol  # Add up data to the matched key
      else
        hash[obj[prop]] = vol   # Create a key
    hash

  noticeProcessingAjax: ->
    R.div
      className: "alert alert-warning"
      R.i
        className: "fa fa-cog fa-spin fa-3x"
      R.div null,
        "Processing... If this is taking long, please make sure you are online."

  barChartPanel: ->
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
        className: 'panel-body'
        React.createElement BarChartCanvas,
          id: "bar"

  pieChartPanel: ->
    R.div
      className: "panel panel-red"
      R.div
        className: 'panel-heading'
        R.div
          className: "row"
          R.div
            className: "col-xs-3"
            R.div
              className: "fa fa-home fa-5x"
      R.div
        className: 'panel-body'
        React.createElement PieChartCanvas,
          id: "chart"

  render: ->
    data1 = @volumeSortedBy("category")
    data2 = @volumeSortedBy("room")

    R.div
      className: "app_wrapper"
      @noticeProcessingAjax() if @state.ajax

      R.h2 null, "Moving volume overview"
      R.div
        className: 'row'
        R.div
          className: 'col-sm-6'
          @barChartPanel()
        R.div
          className: 'col-sm-6'
          @pieChartPanel()

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
