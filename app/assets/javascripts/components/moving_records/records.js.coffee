@Records = React.createClass

  dataTable: ->
    $ = React.DOM

    $.div
      className: 'moving_records table-responsive'
      $.h2 null, "All items"
      $.table
        className: 'table table-bordered table-hover'
        $.thead null,
          $.tr null,
            $.th null, 'Name'
            $.th null, 'Volume'
            $.th null, 'Quantity'
            $.th null, 'Subtotal'
            $.th null, 'Room'
            $.th null, 'Category'
            $.th null, 'Description'
            $.th null, ""
            $.th null, ""
        $.tbody null,
          for record in @props.records
            React.createElement Record,
              key:    record.id
              record: record
              handleDeleteRecord: @props.handleDeleteRecord
              handleEditRecord:   @props.handleUpdateRecord

  render: ->
    $ = React.DOM

    $.div null,
      if @props.records.length > 0
        @dataTable()
