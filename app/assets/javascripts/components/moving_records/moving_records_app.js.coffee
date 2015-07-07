@MovingRecordsApp = React.createClass

  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  # addRecord: (record) ->
  #   records = React.addons.update(@state.records, { $push: [record] })
  #   @setState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  render: ->
    React.createElement Records,
      records: @state.records,
      handleDeleteRecord: @deleteRecord,
      handleUpdateRecord: @updateRecord
