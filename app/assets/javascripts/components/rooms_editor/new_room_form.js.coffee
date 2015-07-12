# @NewRoomForm = React.createClass

#   getInitialState: ->
#     name:        ""

#   # Updates the active element's value based on user's input.
#   handleChange: (e) ->
#     name = e.target.name
#     @setState "#{ name }": e.target.value

#   handleSubmit: (e) ->
#     e.preventDefault()

#     $.ajax
#       method: 'POST'
#       url:    "/rooms"
#       data:   { room: @state }
#     .done (data, textStatus, XHR) =>
#       @setState @getInitialState()  # Restore component's initial UI.
#       @props.handleNewRecord(data)  # Pass new data to the root node.
#       $.growl.notice title: "Room added", message: data.name
#       console.log data
#     .fail (XHR, textStatus, errorThrown) =>
#       $.growl.error title: "Error adding room", message: "#{errorThrown}"
#       console.error("#{textStatus}: #{errorThrown}")

#   handleClear: (e) ->
#     @setState @getInitialState()  # Restore component's initial UI.

#   valid: -> @state.name && @state.name.length <= 50

#   render: ->
#     R = React.DOM

#     R.form
#       onSubmit:  @handleSubmit
#       R.div
#         className: 'form-group'
#         R.div
#           className: "form-group col-sm-12"
#           R.input
#             type:        'text'
#             className:   'form-control'
#             placeholder: 'Item name'
#             name:        'name'
#             value:       @state.name
#             onChange:    @handleChange

#         R.div
#           className: 'col-sm-6'
#           R.div
#             className: 'form-group col-sm-8'
#             R.button
#               type:      'submit'
#               className: if @valid() then 'btn btn-success btn-block' else 'btn btn-default btn-block'
#               disabled:  not @valid()
#               'Add item'
#           R.div
#             className: 'form-group col-sm-4'
#             R.button
#               className: "btn btn-default btn-block"
#               onClick: @handleClear
#               'Clear'
#         R.div
#           className: 'form-group col-sm-6'
#           R.span
#             id: "helpBlock"
#             className: "help-block text-center"
#             "Please fill in all the required fields"
#       R.div className: "clearfix"
