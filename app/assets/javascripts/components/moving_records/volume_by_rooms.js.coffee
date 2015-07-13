# @props.graphName
# @props.data

@ChartOfVolumeByRooms = React.createClass
  render: ->
    React.DOM.canvas
      id:    @props.graphName
      style: { height: 450, width: 600 }

