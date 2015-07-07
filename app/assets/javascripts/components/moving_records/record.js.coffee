@Record = React.createClass
  getInitialState: ->
    edit:     false
    volume:   @props.record.volume
    quantity: @props.record.quantity

  calculateSubtotal: ->
    @state.volume * @state.quantity

  handleChangeVolume: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

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
    React.DOM.tr null,
      React.DOM.td null, @props.record.name
      React.DOM.td null, @props.record.volume
      React.DOM.td null, @props.record.quantity
      React.DOM.td null, @calculateSubtotal()
      React.DOM.td null, @props.record.room
      React.DOM.td null, @props.record.category
      React.DOM.td null, @props.record.description
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-default btn-sm btn-block'
          React.DOM.i
            className: 'fa fa-pencil'
            onClick: @handleToggle
            "edit"
        React.DOM.button
          className: 'btn btn-default btn-sm btn-block'
          React.DOM.i
            className: 'fa fa-trash'
            onClick: @handleDelete

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
          name: 'volume'
          onChange: @handleChangeVolume
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.quantity
          ref: 'quantity'
          name: 'quantity'
          onChange: @handleChangeVolume
      React.DOM.td null, @calculateSubtotal()
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
        React.DOM.button
          className: 'btn btn-default btn-sm btn-block'
          React.DOM.i
            className: 'fa fa-database'
            onClick: @handleEdit
            'Update'
        React.DOM.button
          className: 'btn btn-default btn-sm btn-block'
          React.DOM.i
            className: 'fa fa-undo'
            onClick: @handleToggle

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
