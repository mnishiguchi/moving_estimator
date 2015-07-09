## Example
#  React.createElement TablePanel,
#    type:  'success'
#    count: 23
#    icon:  "fa-home"
#    unit:  "rooms"
#    obj:   { ocean: 23, air: 12, ... }

@MovingVolumePanel = React.createClass

  getInitialState: ->
    data: @props.data

  panelHeading: ->
    $ = React.DOM

    $.div
      className: 'panel-heading'
      $.div
        className: "row"
        $.div
          className: "col-xs-3"
          $.div
            className: "fa #{@props.icon} fa-5x"
        $.div
          className: "col-xs-9 text-right"
          $.div
            className: 'huge'
            @props.count
          $.div null,
            @props.unit

  panelBody: ->
    $ = React.DOM

    $.div
      className: 'panel-body'
      $.table
        className: "table table-striped"
        $.tbody null,
          for key, i in Object.keys(@props.data)
            $.tr
              key: i # Requried by React.js
              $.td
                className: 'lead text-center col-sm-5'
                key
              $.td
                className: 'lead text-center col-sm-5'
                @props.data[key]

  render: ->
    $ = React.DOM

    $.div
      className: "panel panel-#{@props.type}"
      @panelHeading()
      @panelBody()
