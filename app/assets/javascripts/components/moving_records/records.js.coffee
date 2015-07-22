R = React.DOM

@Records = React.createClass
  propTypes:
    records:            React.PropTypes.arrayOf(React.PropTypes.object)
    handleDeleteRecord: React.PropTypes.func
    handleUpdateRecord: React.PropTypes.func

  dataTable: ->
    R.div
      className: 'moving_records table-responsive'
      R.h2 null, "All items"
      R.table
        id:        "moving_records"
        className: 'table table-bordered table-hover'
        R.thead null,
          R.tr null,
            R.th null, 'Name'
            R.th null, 'Volume'
            R.th null, 'Quantity'
            R.th null, 'Subtotal'
            R.th null, 'Room'
            R.th null, 'Category'
            R.th null, 'Description'
            R.th null, ""
            R.th null, ""
        R.tbody null,
          for record in @props.records
            React.createElement Record,
              key:    record.id
              record: record
              handleDeleteRecord: @props.handleDeleteRecord
              handleEditRecord:   @props.handleUpdateRecord

  render: ->
    R.div null,
      if @props.records.length > 0
        @dataTable()

  componentDidMount: ->
    $("table#moving_records").tablesorter()
