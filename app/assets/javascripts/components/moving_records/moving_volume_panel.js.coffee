## Key-value table panel without a table header

## Example
#  React.createElement TablePanel,
#    type:  'success'
#    title: "Volume for each room"
#    obj:   { ocean: 23, air: 12, ... }

@MovingVolumePanel = React.createClass
  getInitialState: ->
    data: @props.data

  render: ->
    $ = React.DOM

    $.div
      className: 'col-sm-6'
      $.div
        className: "panel panel-#{ @props.type }"
        $.div
          className: 'panel-heading'
          @props.title
        $.div
          className: 'panel-body'
          $.table
            className: "table table-striped"
            for key, i in Object.keys(@props.data)
              $.tr
                key: i # Requried by React.js
                $.td null, key
                $.td null, @props.data[key]
