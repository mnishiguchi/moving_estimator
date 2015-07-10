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
        $.growl.error title: "Error deleting record", message: "#{textStatus}: #{errorThrown}"
        console.error("#{textStatus}: #{errorThrown}")

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
      if error_messages = JSON.parse(XHR.responseText)
        for k, v of error_messages
          $.growl.error title: "#{ @capitalize(k) } #{ v }", message: ""
      else
        $.growl.error title: "Error updating record", message: "#{errorThrown}"
      console.error("#{textStatus}: #{errorThrown}")

  capitalize: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  recordRow: ->
    $ = React.DOM

    $.tr null,
      $.td
        className: "col-md-2"
        @props.record.name
      $.td
        className: "col-md-1"
        @props.record.volume
      $.td
        className: "col-md-1"
        @props.record.quantity
      $.td
        className: "col-md-1"
        @calculateSubtotal()
      $.td
        className: "col-md-1"
        @props.record.room
      $.td
        className: "col-md-1"
        @props.record.category
      $.td
        className: "col-md-4"
        @props.record.description
      $.td
        className: "col-md-1"
        $.button
          className: 'btn btn-warning btn-sm'
          onClick: @handleToggle
          $.div
            className: 'fa fa-pencil'
        $.button
          className: 'btn btn-danger btn-sm'
          onClick: @handleDelete
          $.div
            className: 'fa fa-trash'

  recordForm: ->
    $ = React.DOM

    $.tr
      className: "edit"
      $.td
        className: "col-md-2"
        $.textarea
          className: 'form-control'
          defaultValue: @props.record.name
          ref: 'name'
      $.td
        className: "col-md-1"
        $.input
          className: 'form-control'
          type: 'number'
          min:  "0"
          step: "0.5"
          defaultValue: @props.record.volume
          ref:  'volume'  # For referencing DOM
          name: 'volume'  # For referencing event
          onChange: @handleChangeVolume
      $.td
        className: "col-md-1"
        $.input
          className: 'form-control'
          type: 'number'
          min:  "0"
          defaultValue: @props.record.quantity
          ref:  'quantity'  # For referencing DOM
          name: 'quantity'  # For referencing event
          onChange: @handleChangeVolume
      $.td
        className: "col-md-1"
        @calculateSubtotal()
      $.td
        className: "col-md-1"
        $.textarea
          className: 'form-control'
          defaultValue: @props.record.room
          ref: 'room'
      $.td
        className: "col-md-1"
        $.textarea
          className: 'form-control'
          defaultValue: @props.record.category
          ref: 'category'
      $.td
        className: "col-md-4"
        $.textarea
          className: 'form-control'
          defaultValue: @props.record.description
          ref: 'description'
      $.td
        className: "col-md-1"
        $.button
          className: 'btn btn-success btn-sm'
          onClick: @handleEdit
          $.div
            className: 'fa fa-hdd-o'
        $.button
          className: 'btn btn-default btn-sm'
          onClick: @handleToggle
          $.div
            className: 'fa fa-undo'

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
