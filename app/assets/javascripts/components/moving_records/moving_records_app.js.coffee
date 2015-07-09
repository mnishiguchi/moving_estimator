# MovingRecordsApp = myApp || {}

@MovingRecordsApp = React.createClass

  getInitialState: ->
    records: @props.data
    ajax:    false

  getDefaultProps: ->
    records: []

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $unshift: [record] })
    @setState records: records

  # p: "room" or "category"
  volumeSortedBy: (p)->
    hash = {}
    for obj in @state.records
      vol = parseFloat(obj.volume * obj.quantity)
      if hash.hasOwnProperty(obj[p])
        hash[obj[p]] += vol # Add up data to the matched key
      else
        hash[obj[p]] = vol  # Create a key
    console.log hash
    hash

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  noticeProcessingAjax: ->
    $ = React.DOM
    $.div
      className: "alert alert-warning"
      $.i
        className: "fa fa-cog fa-spin fa-3x"
      $.div null,
        "Processing... If this is taking long, please make sure you are online."

  render: ->
    $ = React.DOM
    data1 = @volumeSortedBy("category")
    data2 = @volumeSortedBy("room")

    $.div null,
      @noticeProcessingAjax() if @state.ajax

      $.h2 null, "Moving volume overview"
      $.div
        className: 'row'
        $.div
          className: 'col-sm-6'
          React.createElement MovingVolumePanel,
              type:  'green'
              icon:  "fa-tag"
              count: Object.keys(data1).length
              unit:  "categories"
              data:  data1
        $.div
          className: 'col-sm-6'
          React.createElement MovingVolumePanel,
              type:  'blue'
              icon:  "fa-home"
              count: Object.keys(data2).length
              unit:  "rooms"
              data:  data2
      $.hr null

      $.h2 null, "Add a new item"
      React.createElement NewMovingRecordForm,
        handleNewRecord: @addRecord
      $.hr null

      React.createElement Records,
        records: @state.records,
        handleDeleteRecord: @deleteRecord,
        handleUpdateRecord: @updateRecord
