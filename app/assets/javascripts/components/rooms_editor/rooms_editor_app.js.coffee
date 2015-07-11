@RoomsEditorApp = React.createClass

  getInitialState: ->
    rooms: @props.data

  getDefaultProps: ->
    rooms: []

  # addRecord: (record) ->
  #   # rooms = React.addons.update(@state.rooms, { $unshift: [record] })
  #   # @setState rooms: rooms

  # updateRecord: (record, data) ->
  #   # index = @state.rooms.indexOf record
  #   # rooms = React.addons.update(@state.rooms, { $splice: [[index, 1, data]] })
  #   # @replaceState rooms: rooms

  # deleteRecord: (record) ->
  #   # index = @state.rooms.indexOf record
  #   # rooms = React.addons.update(@state.rooms, { $splice: [[index, 1]] })
  #   # @replaceState rooms: rooms

  # createRooms: =>
  #   for room, i in @props.rooms
  #     React.createElement Room,
  #       key:  i
  #       name: room.name
  #       handleUpdateRecord: @updateRecord
  #       handleDeleteRecord: @deleteRecord

  render: ->
    R = React.DOM

    R.div
      className: "app_wrapper"
      # R.h2 null, "Add a new item"
      # React.createElement NewRoomForm,
      #   handleNewRecord: @addRecord
      # R.hr null

      R.div null,
        for room, i in @state.rooms
          React.createElement Room,
            key:  i,
            room: room
            # handleUpdateRecord: @updateRecord
            # handleDeleteRecord: @deleteRecord
