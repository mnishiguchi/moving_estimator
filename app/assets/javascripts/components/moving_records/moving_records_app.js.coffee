R = React.DOM

# Canvases for charts
PieChartCanvas = React.createClass
  render: ->
    React.DOM.canvas
      id:    @props.id
      style: { height: 200, width: 200 }

GraphCanvas = React.createClass
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

  componentDidMount: ->
    @drawCharts()

  componentDidUpdate: ->
    @drawCharts()

  drawCharts: ->
    canvas = document.getElementById("chart")
    ctx    = canvas.getContext("2d")
    chart  = new Chart( ctx ).Pie(@dataForChart())

    canvas = document.getElementById("bar")
    ctx    = canvas.getContext("2d")
    bar    = new Chart( ctx ).Bar(@dataForGraph())

  dataForChart: ->
    [
      {
        value:     300
        color:     "#F7464A"
        highlight: "#FF5A5E"
        label:     "Red"
      },
      {
        value:     50
        color:     "#46BFBD"
        highlight: "#5AD3D1"
        label:     "Green"
      },
      {
        value:     100
        color:     "#FDB45C"
        highlight: "#FFC870"
        label:     "Yellow"
      }
    ]
  dataForGraph: ->
    labels: ["January", "February", "March", "April", "May", "June", "July"],
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 81, 56, 55, 40]
        },
        {
            label: "My Second dataset",
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,0.8)",
            highlightFill: "rgba(151,187,205,0.75)",
            highlightStroke: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 86, 27, 90]
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
        React.createElement GraphCanvas,
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
