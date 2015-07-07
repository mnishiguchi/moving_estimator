@Records = React.createClass

  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  render: ->
    $ = React.DOM

    $.div null,
      $.div
        className: 'moving_records table-responsive'
        $.table
          className: 'table table-bordered table-hover'
          $.thead
            $.tr null,
              $.th null, 'Name'
              $.th null, 'Volume'
              $.th null, 'Qantity'
              $.th null, 'Subtotal'
              $.th null, 'Room'
              $.th null, 'Category'
              $.th null, 'Description'
              $.th null, ''
          $.tbody
            for record in @state.records
              React.createElement Record,
                key:    record.id,
                record: record,
                handleDeleteRecord: @deleteRecord,
                handleEditRecord:   @updateRecord
