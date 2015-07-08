@Records = React.createClass

  render: ->
    $ = React.DOM

    $.div null,
      $.div
        className: 'moving_records table-responsive'
        $.table
          className: 'table table-bordered table-hover'
          $.thead null,
            $.tr null,
              $.th null, 'Name'
              $.th null, 'Volume'
              $.th null, 'Qantity'
              $.th null, 'Subtotal'
              $.th null, 'Room'
              $.th null, 'Category'
              $.th null, 'Description'
              $.th null, ''
          $.tbody null,
            for record, i in @props.records
              React.createElement Record,
                key:    i,
                record: record,
                handleDeleteRecord: @props.handleDeleteRecord,
                handleEditRecord:   @props.handleUpdateRecord
