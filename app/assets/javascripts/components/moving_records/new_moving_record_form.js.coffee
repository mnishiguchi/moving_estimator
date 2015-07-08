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
    $.ajax
      method: 'POST'
      url:    "/moving_items"
      data:   { moving_item: @state }
    .done (data, textStatus, XHR) =>
      @setState @getInitialState()  # Update this component's UI.
      @props.handleNewRecord(data)  # Pass new data to the root node.
      $.growl.notice title: "Record added", message: data.name
      console.log data
    .fail (XHR, textStatus, errorThrown) =>
      $.growl.error title: "Error", message: "Error adding record"
      console.error("#{XHR.status}: #{textStatus}: #{errorThrown}")

  render: ->
    $ = React.DOM

    $.form
      className: 'form-inline'
      onSubmit:  @handleSubmit
      $.div
        className: 'form-group'
        $.input
          type:        'text'
          className:   'form-control'
          placeholder: 'Item name'
          name:        'name'
          value:       @state.name
          onChange:    @handleChange
      $.div
        className: 'form-group'
        $.input
          type:        'number'
          className:   'form-control'
          placeholder: 'Volume'
          name:        'volume'
          value:       @state.volume
          onChange:    @handleChange
      $.div
        className: 'form-group'
        $.input
          type:        'number'
          className:   'form-control'
          placeholder: 'Quantity'
          name:        'quantity'
          value:       @state.quantity
          onChange:    @handleChange
      $.div
        className: 'form-group'
        $.input
          type:        'text'
          className:   'form-control'
          placeholder: 'Room'
          name:        'room'
          value:       @state.room
          onChange:    @handleChange
      $.div
        className: 'form-group'
        $.input
          type:        'text'
          className:   'form-control'
          placeholder: 'Category'
          name:        'category'
          value:       @state.category
          onChange:    @handleChange
      $.div
        className: 'form-group'
        $.input
          type:        'text'
          className:   'form-control'
          placeholder: 'Description'
          name:        'description'
          value:       @state.description
          onChange:    @handleChange
      $.button
        type:      'submit'
        className: 'btn btn-primary'
        disabled:  not @valid()
        'Create record'
