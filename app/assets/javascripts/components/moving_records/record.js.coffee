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
    @setState volume:   @props.record.volume
    @setState quantity: @props.record.quantity
    @setState edit:     not @state.edit

  handleDelete: (e) ->
    e.preventDefault()
    @setState ajax: true
    if confirm("Are you sure?")
      $.ajax
        method:   'DELETE'
        url:      "/moving_items/#{ @props.record.id }"
        dataType: 'JSON'
      .done (data, textStatus, XHR) =>
        @setState ajax: false
        @props.handleDeleteRecord @props.record
        $.growl.notice title: "Record deleted", message: ""
      .fail (XHR, textStatus, errorThrown) =>
        @setState ajax: false
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
    @setState ajax: true
    $.ajax
      method:   'PATCH'
      url:      "/moving_items/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        moving_item: data
    .done (data, textStatus, XHR) =>
      @setState edit: false
      @setState ajax: false
      @props.handleEditRecord(@props.record, data)
      $.growl.notice title: "Record updated", message: data.name
    .fail (XHR, textStatus, errorThrown) =>
      @setState ajax: false
      $.growl.error title: "Error", message: "Error updating record"
      console.error("#{XHR.status}: #{textStatus}: #{errorThrown}")

  recordRow: ->
    $ = React.DOM

    $.tr null,
      $.td null, @props.record.name
      $.td null, @props.record.volume
      $.td null, @props.record.quantity
      $.td null, @calculateSubtotal()
      $.td null, @props.record.room
      $.td null, @props.record.category
      $.td null, @props.record.description
      $.td null,
        $.button
          className: 'btn btn-default btn-sm btn-block'
          onClick: @handleToggle
          $.div
            className: 'fa fa-pencil'
            "edit"
        $.button
          className: 'btn btn-default btn-sm btn-block'
          onClick: @handleDelete
          $.div
            className: 'fa fa-trash'

  recordForm: ->
    $ = React.DOM

    $.tr null,
      $.td null,
        $.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.name
          ref: 'name'
      $.td null,
        $.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.volume
          ref: 'volume'   # For referencing DOM
          name: 'volume'  # For referencing event
          onChange: @handleChangeVolume
      $.td null,
        $.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.quantity
          ref: 'quantity'   # For referencing DOM
          name: 'quantity'  # For referencing event
          onChange: @handleChangeVolume
      $.td null, @calculateSubtotal()
      $.td null,
        $.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.room
          ref: 'room'
      $.td null,
        $.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.category
          ref: 'category'
      $.td null,
        $.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.description
          ref: 'description'
      $.td null,
        $.button
          className: 'btn btn-success btn-sm btn-block'
          onClick: @handleEdit
          $.div
            className: 'fa fa-database'
            'Update'
        $.button
          className: 'btn btn-default btn-sm btn-block'
          onClick: @handleToggle
          $.div
            className: 'fa fa-undo'


  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
