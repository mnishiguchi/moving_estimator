R = React.DOM

@Record = React.createClass

  getInitialState: ->
    edit:     false
    volume:   @props.record.volume
    quantity: @props.record.quantity

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
    if confirm("Deleting a record. Are you sure?")
      $.ajax
        method:   'DELETE'
        url:      "/moving_items/#{ @props.record.id }"
        dataType: 'JSON'
      .done (data, textStatus, XHR) =>
        @setState ajax: false
        @props.handleDeleteRecord @props.record
        $.growl.notice title: "Record deleted", message: data.name
      .fail (XHR, textStatus, errorThrown) =>
        @setState ajax: false
        $.growl.error title: "Error deleting record", message: "#{errorThrown}"
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

  calculateSubtotal: ->
    @state.volume * @state.quantity

  capitalize: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  # A table row with the data passed in from the parent node.
  recordRow: ->
    R.tr null,
      R.td
        className: "col-sm-3"
        @props.record.name
      R.td
        className: ""
        @props.record.volume
      R.td
        className: ""
        @props.record.quantity
      R.td
        className: ""
        (@props.record.volume * @props.record.quantity)
      R.td
        className: "col-sm-2"
        @props.record.room
      R.td
        className: "col-sm-2"
        @props.record.category
      R.td
        className: "col-sm-5"
        @props.record.description
      R.td
        className: ""
        R.button
          className: 'btn btn-warning btn-sm'
          onClick: @handleToggle
          R.div
            className: 'fa fa-pencil'
      R.td
        className: ""
        R.button
          className: 'btn btn-danger btn-sm'
          onClick: @handleDelete
          R.div
            className: 'fa fa-trash'

  # An edit form that is displayed when the edit button is clicked.
  recordForm: ->
    R.tr
      className: "edit"
      R.td
        className: "col-sm-3"
        R.textarea
          className: 'form-control'
          defaultValue: @props.record.name
          ref: 'name'
      R.td
        className: "col-sm-1"
        R.input
          className: 'form-control'
          type: 'number'
          min:  "0"
          step: "0.5"
          defaultValue: @props.record.volume
          ref:  'volume'  # For referencing value in actual DOM
          name: 'volume'  # For referencing change event
          onChange: @handleChangeVolume
      R.td
        className: "col-sm-1"
        R.input
          className: 'form-control'
          type: 'number'
          min:  "0"
          defaultValue: @props.record.quantity
          ref:  'quantity'  # For referencing value in actual DOM
          name: 'quantity'  # For referencing change event
          onChange: @handleChangeVolume
      R.td
        className: ""
        @calculateSubtotal()  # Dynamically changing based on user's input
      R.td
        className: "col-sm-2"
        R.textarea
          className: 'form-control'
          defaultValue: @props.record.room
          ref: 'room'
      R.td
        className: "col-sm-2"
        R.textarea
          className: 'form-control'
          defaultValue: @props.record.category
          ref: 'category'
      R.td
        className: "col-sm-5"
        R.textarea
          className: 'form-control'
          defaultValue: @props.record.description
          ref: 'description'
      R.td
        className: ""
        R.button
          className: 'btn btn-success btn-sm'
          onClick: @handleEdit
          R.div
            className: 'fa fa-hdd-o'
      R.td
        className: ""
        R.button
          className: 'btn btn-default btn-sm'
          onClick: @handleToggle
          R.div
            className: 'fa fa-undo'

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
