@NewMovingRecordForm = React.createClass

  getInitialState: ->
      name:        ""
      volume:      ""
      quantity:    ""
      room:        ""
      category:    ""
      description: ""

  valid: ->
    # presence validation
    @state.name && @state.volume && @state.quantity && @state.room &&
    @state.category

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    @setState ajax: true
    $.ajax
      method: 'POST'
      url:    "/moving_items"
      data:   { moving_item: @state }
    .done (data, textStatus, XHR) =>
      @setState ajax: false
      @setState @getInitialState()  # Restore component's initial UI.
      @props.handleNewRecord(data)  # Pass new data to the root node.
      $.growl.notice title: "Record added", message: data.name
      console.log data
    .fail (XHR, textStatus, errorThrown) =>
      @setState ajax: false
      $.growl.error title: "Error", message: "Error adding record"
      console.error("#{XHR.status}: #{textStatus}: #{errorThrown}")

  render: ->
    $ = React.DOM

    $.form
      onSubmit:  @handleSubmit
      $.div
        className: 'form-group'
        $.div
          className: 'form-group col-sm-12'
          $.input
            type:        'text'
            className:   'form-control'
            placeholder: 'Item name'
            name:        'name'
            value:       @state.name
            onChange:    @handleChange
        $.div
          className: 'form-group col-sm-6'
          $.input
            type:        'number'
            className:   'form-control'
            placeholder: 'Volume'
            name:        'volume'
            value:       @state.volume
            onChange:    @handleChange
        $.div
          className: 'form-group col-sm-6'
          $.input
            type:        'number'
            className:   'form-control'
            placeholder: 'Quantity'
            name:        'quantity'
            value:       @state.quantity
            onChange:    @handleChange
        $.div
          className: 'form-group col-sm-6'
          $.input
            type:        'text'
            className:   'form-control'
            placeholder: 'Category'
            name:        'category'
            value:       @state.category
            onChange:    @handleChange
        $.div
          className: 'form-group col-sm-6'
          $.input
            type:        'text'
            className:   'form-control'
            placeholder: 'Room'
            name:        'room'
            value:       @state.room
            onChange:    @handleChange
        $.div
          className: 'form-group col-sm-6'
          $.textarea
            rows:        '3'
            className:   'form-control'
            placeholder: 'Description'
            name:        'description'
            value:       @state.description
            onChange:    @handleChange
        $.div
          className: 'form-group col-sm-6'
          $.button
            type:      'submit'
            className: if @valid() then 'btn btn-success btn-block' else 'btn btn-default btn-block'
            disabled:  not @valid()
            'Add item'
          $.span
            id: "helpBlock"
            className: "help-block"
            "Please fill in all the required fields"
      $.div className: "clearfix"
