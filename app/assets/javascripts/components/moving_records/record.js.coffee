@Record = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    if confirm("Are you sure?")
      $.ajax
        method: 'DELETE'
        url: "/moving_items/#{ @props.record.id }"
        dataType: 'JSON'
      .done (data, textStatus, XHR) =>
        @props.handleDeleteRecord @props.record
        $.growl.notice title: "Record deleted", message: ""
      .fail (XHR, textStatus, errorThrown) =>
        $.growl.error title: "Error", message: "Error deleting record"
        console.error("#{XHR.status}: #{textStatus}: #{errorThrown}")

  handleEdit: (e) ->
    e.preventDefault()
    data =
      name:        React.findDOMNode(@refs.name).value
      volume:      React.findDOMNode(@refs.volume).value
      quantity:    React.findDOMNode(@refs.quantity).value
      room:        React.findDOMNode(@refs.room).value
      category:    React.findDOMNode(@refs.category).value
      description: React.findDOMNode(@refs.description).value
    $.ajax
      method:   'PATCH'
      url:      "/moving_items/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        moving_item: data
    .done (data, textStatus, XHR) =>
      @setState edit: false
      @props.handleEditRecord(@props.record, data)
      $.growl.notice title: "Record updated", message: data.name
    .fail (XHR, textStatus, errorThrown) =>
      $.growl.error title: "Error", message: "Error updating record"
      console.error("#{XHR.status}: #{textStatus}: #{errorThrown}")

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
    subtotal = @props.record.quantity * @props.record.volume

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
      React.DOM.td null, subtotal
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
          className: 'btn btn-default btn-xs'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
