@RoomsEditorApp = React.createClass

  getInitialState: ->
    rooms: @props.data

  getDefaultProps: ->
    rooms: []

  addRecord: (room) ->
    rooms = React.addons.update(@state.rooms, { $unshift: [room] })
    @setState rooms: rooms

  updateRecord: (room, newData) ->
    index = @state.rooms.indexOf room
    rooms = React.addons.update(@state.rooms, { $splice: [[index, 1, newData]] })
    @replaceState rooms: rooms

  deleteRecord: (room) ->
    index = @state.rooms.indexOf room
    rooms = React.addons.update(@state.rooms, { $splice: [[index, 1]] })
    @replaceState rooms: rooms

  render: ->
    R = React.DOM

    R.div
      className: "app_wrapper"

      # The add room form
      R.h2 null,
        "Add a new item"
      React.createElement NewRoomForm,
        handleNewRecord: @addRecord

      # The rooms list
      R.h2 null,
        "All rooms"
      R.div null,
        for room, i in @state.rooms
          React.createElement Room,
            key:  i,
            room: room
            handleUpdateRecord: @updateRecord
            handleDeleteRecord: @deleteRecord
