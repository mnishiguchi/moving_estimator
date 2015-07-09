@NewMovingRecordForm = React.createClass

  getInitialState: ->
    name:        ""
    volume:      ""
    quantity:    ""
    room:        ""
    category:    ""
    description: ""

  valid: ->
    @validName() && @validVolume() && @validQuantity() &&
    @validRoom() && @validCategory() && @validDescription()

  # validators
  validName: ->
    @state.name && @state.name.length <= 50
  validVolume: ->
    @state.volume && @state.volume.length <= 10
  validQuantity: ->
    @state.quantity && @state.quantity.length <= 10
  validRoom: ->
    @state.room && @state.room.length <= 50
  validCategory: ->
    @state.category && @state.category.length <= 50
  validDescription: ->
    @state.description.length <= 200

  fieldColor: (validator) ->
    if validator then 'has-success' else 'has-warning'

  handleClear: (e) ->
    @setState @getInitialState()  # Restore component's initial UI.

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
          className: "form-group col-sm-12 #{@fieldColor(@validName())}"
          $.input
            type:        'text'
            className:   'form-control'
            placeholder: 'Item name'
            name:        'name'
            required:    true
            value:       @state.name
            onChange:    @handleChange
        $.div
          className: "form-group col-sm-6 #{@fieldColor(@validVolume())}"
          $.input
            type:        'number'
            min:         "0"
            step:        "0.5"
            className:   'form-control'
            placeholder: 'Volume'
            name:        'volume'
            required:    true
            value:       @state.volume
            onChange:    @handleChange
        $.div
          className: "form-group col-sm-6 #{@fieldColor(@validQuantity())}"
          $.input
            type:        'number'
            min:         "0"
            className:   'form-control'
            placeholder: 'Quantity'
            name:        'quantity'
            required:    true
            value:       @state.quantity
            onChange:    @handleChange
        $.div
          className: "form-group col-sm-6 #{@fieldColor(@validCategory())}"
          $.input
            type:        'text'
            className:   'form-control'
            placeholder: 'Category'
            name:        'category'
            required:    true
            value:       @state.category
            onChange:    @handleChange
        $.div
          className: "form-group col-sm-6 #{@fieldColor(@validRoom())}"
          $.input
            type:        'text'
            className:   'form-control'
            placeholder: 'Room'
            name:        'room'
            required:    true
            value:       @state.room
            onChange:    @handleChange
        $.div
          className: "form-group col-sm-6 #{@fieldColor(@validDescription())}"
          $.textarea
            rows:        '3'
            className:   'form-control'
            placeholder: 'Description'
            name:        'description(optional)'
            value:       @state.description
            onChange:    @handleChange
        $.div
          className: 'form-group col-sm-3'
          $.button
            type:      'submit'
            className: if @valid() then 'btn btn-success btn-block' else 'btn btn-default btn-block'
            disabled:  not @valid()
            'Add item'
        $.div
          className: 'form-group col-sm-3'
          $.button
            type:      'submit'
            className: "btn btn-default btn-block"
            onClick: @handleClear
            'Clear'
          $.span
            id: "helpBlock"
            className: "help-block"
            "Please fill in all the required fields"
      $.div className: "clearfix"
