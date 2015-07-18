R = React.DOM

@RoomsEditorApp = React.createClass

  getInitialState: ->
    rooms: @props.data

  getDefaultProps: ->
    rooms: []

  updateRecord: (room, newData) ->
    index = @state.rooms.indexOf room
    rooms = React.addons.update(@state.rooms, { $splice: [[index, 1, newData]] })
    @replaceState rooms: rooms

  deleteRecord: (room) ->
    index = @state.rooms.indexOf room
    rooms = React.addons.update(@state.rooms, { $splice: [[index, 1]] })
    @replaceState rooms: rooms

  render: ->
    R.div
      className: "app_wrapper"

      # The rooms list
      R.div null,
        for room in @state.rooms
          React.createElement Room,
            key:  room.id,  # Use resource id instead of i
            room: room
            handleUpdateRecord: @updateRecord
            handleDeleteRecord: @deleteRecord
