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

  # p: "room" or "category"
  volumeSortedBy: (p)->
    hash = {}
    for obj in @state.records
      vol = parseFloat(obj.volume * obj.quantity)
      if hash.hasOwnProperty(obj[p])
        hash[obj[p]] += vol # Add up data to the matched key
      else
        hash[obj[p]] = vol  # Create a key
    console.log hash
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
    React.DOM.div null,
      React.createElement MovingVolumePanel,
          type:  'green'
          title: "Volume for each category"
          data:  @volumeSortedBy("category")
      React.createElement MovingVolumePanel,
          type:  'blue'
          title: "Volume for each room"
          data:  @volumeSortedBy("room")
      React.createElement Records,
        records: @state.records,
        handleDeleteRecord: @deleteRecord,
        handleUpdateRecord: @updateRecord
