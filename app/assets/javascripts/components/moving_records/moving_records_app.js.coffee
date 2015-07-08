@MovingRecordsApp = React.createClass

  getInitialState: ->
    records: @props.data
    ajax:    false

  getDefaultProps: ->
    records: []

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
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

    $.div null,
      @noticeProcessingAjax() if @state.ajax

      $.div
        className: 'row'
        $.div
          className: 'col-sm-6'
          React.createElement MovingVolumePanel,
              type:  'green'
              title: "Volume for each category"
              data:  @volumeSortedBy("category")
        $.div
          className: 'col-sm-6'
          React.createElement MovingVolumePanel,
              type:  'blue'
              title: "Volume for each room"
              data:  @volumeSortedBy("room")
      $.hr null

      React.createElement NewMovingRecordForm,
        handleNewRecord: @addRecord
      $.hr null

      React.createElement Records,
        records: @state.records,
        handleDeleteRecord: @deleteRecord,
        handleUpdateRecord: @updateRecord
