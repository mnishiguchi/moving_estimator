@Records = React.createClass
  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  # credits: ->
  #   credits = @state.records.filter (val) -> val.amount >= 0
  #   credits.reduce ((prev, curr) ->
  #     prev + parseFloat(curr.amount)
  #   ), 0

  # debits: ->
  #   debits = @state.records.filter (val) -> val.amount < 0
  #   debits.reduce ((prev, curr) ->
  #     prev + parseFloat(curr.amount)
  #   ), 0

  # balance: ->
  #   @debits() + @credits()

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
    div   = React.DOM.div
    hr    = React.DOM.hr
    table = React.DOM.table
    thead = React.DOM.thead
    tr    = React.DOM.tr
    th    = React.DOM.th
    tbody = React.DOM.tbody

    div
      className: 'moving_records table-responsive'
      # React.DOM.h2
      #   'Records'
      # React.DOM.div
      #   className: 'row'
        # React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
        # React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
        # React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'
      # React.createElement RecordForm, handleNewRecord: @addRecord
      # hr null
      table
        className: 'table table-bordered table-condensed'
        thead
          tr
            th null, 'Name'
            th null, 'Volume'
            th null, 'Qantity'
            th null, 'Subtotal'
            th null, 'Room'
            th null, 'Category'
            th null, 'Description'
            th null, ''
        tbody null,
          for record in @state.records
            React.createElement Record,
              key:    record.id,
              record: record,
              handleDeleteRecord: @deleteRecord,
              handleEditRecord:   @updateRecord
