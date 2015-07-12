R = React.DOM

@MovingRecordsApp = React.createClass

  getInitialState: ->
    records: @props.data
    ajax:    false

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
          React.createElement MovingVolumePanel,
              type:  'green'
              icon:  "fa-tag"
              count: Object.keys(data1).length
              unit:  "categories"
              data:  data1
        R.div
          className: 'col-sm-6'
          React.createElement MovingVolumePanel,
              type:  'blue'
              icon:  "fa-home"
              count: Object.keys(data2).length
              unit:  "rooms"
              data:  data2
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
