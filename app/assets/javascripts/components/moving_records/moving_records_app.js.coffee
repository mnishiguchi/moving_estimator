@MovingRecordsApp = React.createClass

  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  # addRecord: (record) ->
  #   records = React.addons.update(@state.records, { $push: [record] })
  #   @setState records: records

  # uses hash lookups for primitives
  uniqueArray: (a)->
    prims =
      'boolean': {}
      'number' : {}
      'string' : {}
    a.filter (item) ->
      type = typeof item
      if prims[type].hasOwnProperty(item) then false else (prims[type][item] = true)

  rooms: ->
    rooms = []
    for record in @state.records
      rooms.push record.room
    uniqueArray = @uniqueArray(rooms)
    console.log uniqueArray

  categories: ->
    cats = []
    for record in @state.records
      cats.push record.category
    uniqueArray = @uniqueArray(cats)
    console.log uniqueArray

  volumeByRooms: ->
    hash = {}
    for obj in @state.records
      vol = parseFloat( obj.volume * parseFloat(obj.quantity))
      if hash.hasOwnProperty(obj.room)
        hash[obj.room] += vol
      else
        hash[obj.room] = vol
    hash

  volumeByCategories: ->
    hash = {}
    for obj in @state.records
      vol = (parseFloat(obj.volume * obj.quantity))
      if hash.hasOwnProperty(obj.category)
        hash[obj.category] += vol
      else
        hash[obj.category] = vol
    hash

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  render: ->
    # console.log @volumeByRooms()

    React.DOM.div null,
      React.createElement TablePanel,
          type:  'green'
          title: "Volume for each category"
          data:  @volumeByCategories()
      React.createElement TablePanel,
          type:  'blue'
          title: "Volume for each room"
          data:  @volumeByRooms()
      React.createElement Records,
        records: @state.records,
        handleDeleteRecord: @deleteRecord,
        handleUpdateRecord: @updateRecord
