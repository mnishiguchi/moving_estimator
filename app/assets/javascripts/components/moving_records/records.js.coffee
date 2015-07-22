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
        className: 'table table-hover'
        R.thead null,
          R.tr null,
            R.th null, 'Name'
              R.span className: "arrow"
            R.th null, 'Volume'
              R.span className: "arrow"
            R.th null, 'Quantity'
              R.span className: "arrow"
            R.th null, 'Subtotal'
              R.span className: "arrow"
            R.th null, 'Room'
              R.span className: "arrow"
            R.th null, 'Category'
              R.span className: "arrow"
            R.th null, 'Description'
              R.span className: "arrow"
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
