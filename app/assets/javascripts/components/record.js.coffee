@Record = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/movings/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record

  handleEdit: (e) ->
    e.preventDefault()
    data =
      title:  React.findDOMNode(@refs.title).value
      date:   React.findDOMNode(@refs.date).value
      amount: React.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/movings/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data



  recordRow: ->
    subtotal = @props.record.quantity * @props.record.volume
    React.DOM.tr null,
      React.DOM.td null, @props.record.name
      React.DOM.td null, @props.record.volume
      React.DOM.td null, @props.record.quantity
      React.DOM.td null, subtotal
      React.DOM.td null, @props.record.room
      React.DOM.td null, @props.record.category
      React.DOM.td null, @props.record.description
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default btn-xs'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger btn-xs'
          onClick: @handleDelete
          'Delete'

  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.name
          ref: 'name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.volume
          ref: 'volume'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.quantity
          ref: 'quantity'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.subtotal
          ref: 'subtotal'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.room
          ref: 'room'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.category
          ref: 'category'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.description
          ref: 'description'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default btn-xs'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-warning btn-xs'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
