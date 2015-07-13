@NewMovingRecordForm = React.createClass

  getInitialState: ->
    name:        ""
    volume:      ""
    quantity:    ""
    room:        ""
    category:    ""
    description: ""

  componentDidMount: ->
    @updateAutocomplete()  # Initialize the jQuery UI autocomplete.

  componentDidUpdate: ->
    @updateAutocomplete()  # Update the jQuery UI autocomplete.

  componentWillUnmount: ->
    # Remove the extra HTML that jQuery UI autocomplete creates.
    $(React.findDOMNode(@refs.room)).autocomplete('destroy')
    $(React.findDOMNode(@refs.category)).autocomplete('destroy')

  # Sets up the jQuery UI autocomplete on the real DOM with the provided data.
  # When an autocomplete item is selected, updates the value accordingly.
  updateAutocomplete: ->
    $(React.findDOMNode(@refs.room)).autocomplete
      source: @props.roomSuggestions
      select: (e, ui) => @setState room: ui.item.value

    $(React.findDOMNode(@refs.category)).autocomplete
      source: @props.categorySuggestions
      select: (e, ui) => @setState category: ui.item.value

  # Updates the active element's value based on user's input.
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
    .fail (XHR, textStatus, errorThrown) =>
      @setState ajax: false
      if error_messages = JSON.parse(XHR.responseText)
        for k, v of error_messages
          $.growl.error title: "#{ @capitalize(k) } #{v}", message: ""
      else
        $.growl.error title: "Error adding record", message: "#{errorThrown}"
      console.error("#{textStatus}: #{errorThrown}")

  handleClear: (e) ->
    @setState @getInitialState()  # Restore component's initial UI.

  # Field validations
  valid: ->
    @validName() && @validVolume() && @validQuantity() &&
    @validRoom() && @validCategory() && @validDescription()
  validName:        -> @state.name && @state.name.length <= 50
  validVolume:      -> @state.volume && @state.volume.length <= 10
  validQuantity:    -> @state.quantity && @state.quantity.length <= 10
  validRoom:        -> @state.room && @state.room.length <= 50
  validCategory:    -> @state.category && @state.category.length <= 50
  validDescription: -> @state.description.length <= 200
  fieldColor: (validator) -> if validator then 'has-success' else 'has-warning'

  capitalize: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  render: ->
    R = React.DOM

    R.form
      onSubmit:  @handleSubmit
      R.div
        className: 'form-group'
        R.div
          className: "form-group col-sm-12 #{@fieldColor(@validName())}"
          R.input
            type:        'text'
            className:   'form-control'
            placeholder: 'Item name'
            name:        'name'
            value:       @state.name
            onChange:    @handleChange
        R.div
          className: "form-group col-sm-6 #{@fieldColor(@validVolume())}"
          R.input
            type:        'number'
            min:         "0"
            step:        "0.5"
            className:   'form-control'
            placeholder: 'Volume'
            name:        'volume'
            value:       @state.volume
            onChange:    @handleChange
        R.div
          className: "form-group col-sm-6 #{@fieldColor(@validQuantity())}"
          R.input
            type:        'number'
            min:         "0"
            className:   'form-control'
            placeholder: 'Quantity'
            name:        'quantity'
            value:       @state.quantity
            onChange:    @handleChange
        R.div
          className: "form-group col-sm-6 #{@fieldColor(@validCategory())}"
          R.input
            type:        'text'
            className:   'form-control'
            ref:         'category'  # for Autocomplete to access the DOM
            name:        'category'  # for @handleChange
            placeholder: 'Category'
            value:       @state.category
            onChange:    @handleChange
        R.div
          className: "form-group col-sm-6 #{@fieldColor(@validRoom())}"
          R.input
            type:        'text'
            className:   'form-control'
            ref:         'room'  # for Autocomplete to access the DOM
            name:        'room'  # for @handleChange
            placeholder: 'Room'
            value:       @state.room
            onChange:    @handleChange
        R.div
          className: "form-group col-sm-6 #{@fieldColor(@validDescription())}"
          R.textarea
            rows:        '3'
            className:   'form-control'
            placeholder: 'Description'
            name:        'description(optional)'
            value:       @state.description
            onChange:    @handleChange

        R.div
          className: 'col-sm-6'
          R.div
            className: 'form-group col-sm-8'
            R.button
              type:      'submit'
              className: if @valid() then 'btn btn-success btn-block' else 'btn btn-default btn-block'
              disabled:  not @valid()
              'Add item'
          R.div
            className: 'form-group col-sm-4'
            R.button
              className: "btn btn-default btn-block"
              onClick: @handleClear
              'Clear'
        R.div
          className: 'form-group col-sm-6'
          R.span
            id: "helpBlock"
            className: "help-block text-center"
            "Please fill in all the required fields"
      R.div className: "clearfix"
