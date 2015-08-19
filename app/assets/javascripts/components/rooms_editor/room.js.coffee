R = React.DOM

class @Components.Room
  # console.log "Components.Room was called"

  constructor: ->
    @Room = React.createClass

      getInitialState: ->
        value:   @props.room.name
        changed: false
        updated: false

      # When a room name is edited, puts it into "edit mode".
      handleChange: (e) ->
        input = e.target.value
        if input is @props.room.name
          @setState(value: input, changed: false, updated: false)
        else
          @setState(value: input, changed: true, updated: false)

      # When the update button is clicked, saves it to database via Ajax.
      handleUpdate: (e) ->
        e.preventDefault()
        input =
          name: React.findDOMNode(@refs.input).value
        $.ajax
          method:   'PATCH'
          url:      "/rooms/#{ @props.room.id }"
          dataType: 'JSON'
          data: { room: input }
        .done (data, textStatus, XHR) =>
          @props.handleUpdateRecord(@props.room, data)
          @setState(changed: false, updated: true)
          $.growl.notice title: "Room updated", message: data.name
        .fail (XHR, textStatus, errorThrown) =>
          if error_messages = JSON.parse(XHR.responseText)
            for k, v of error_messages
              $.growl.error title: "#{ @capitalize(k) } #{ v }", message: ""
          else
            $.growl.error title: "Error updating room", message: "#{errorThrown}"
          console.error("#{textStatus}: #{errorThrown}")

      handleDelete: (e) ->
        e.preventDefault()
        if confirm("Deleting a room. Are you sure?")
          $.ajax
            method:   'DELETE'
            url:      "/rooms/#{ @props.room.id }"
            dataType: 'JSON'
          .done (data, textStatus, XHR) =>
            @props.handleDeleteRecord @props.room
            $.growl.notice title: "Room deleted", message: data.name
          .fail (XHR, textStatus, errorThrown) =>
            $.growl.error title: "Error deleting room", message: "#{errorThrown}"
            console.error("#{textStatus}: #{errorThrown}")

      handleCancelChange: (e) ->
        e.preventDefault()
        @setState(value: @props.room.name, changed: false)

      updateButton: ->
        R.div
          className: "input-group-addon"
          R.div null,
            R.a
              onClick: @handleUpdate
              "Update"
            R.div
              "\u0020|\u0020"
            R.a
              onClick: @handleCancelChange
              "Cancel"

      deleteButton: ->
        R.button
          className: "btn btn-default"
          onClick: @handleDelete
          R.i
            className: "fa fa-times"
            style: { color: "#DD0000" }

      fieldColor: ->
        if @state.changed
          'has-warning'
        else if @state.updated
          'has-success'

      capitalize: (string) ->
        string.charAt(0).toUpperCase() + string.slice(1)

      render: ->
        R.form
          className: "form-horizontal"
          R.div
            className: "form-group #{@fieldColor()}"
            R.div
              className: "input-group"
              R.div
                className: "input-group-btn"
                @deleteButton()
              R.input
                style: { "fontSize": "1.5em" }
                className:   "form-control"
                type:        "text"
                placeholder: "new room"
                ref:         'input'
                value:       @state.value
                onChange:    @handleChange
              @updateButton() if @state.changed
    return @Room
