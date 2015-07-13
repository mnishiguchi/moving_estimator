## Example
#  React.createElement TablePanel,
#    type:  'success'
#    count: 23
#    icon:  "fa-home"
#    unit:  "rooms"
#    obj:   { ocean: 23, air: 12, ... }

# R = React.DOM

# @MovingVolumePanel = React.createClass

#   getInitialState: ->
#     data: @props.data

#   panelHeading: ->
#     R.div
#       className: 'panel-heading'
#       R.div
#         className: "row"
#         R.div
#           className: "col-xs-3"
#           R.div
#             className: "fa #{@props.icon} fa-5x"
#         R.div
#           className: "col-xs-9 text-right"
#           R.div
#             className: 'huge'
#             @props.count
#           R.div null,
#             @props.unit

#   panelBody: ->
#     R.div
#       className: 'panel-body'
#       R.table
#         className: "table table-striped"
#         R.tbody null,
#           for key, i in Object.keys(@props.data)
#             R.tr
#               key: i # Requried by React.js
#               R.td
#                 className: 'lead text-center col-sm-5'
#                 key
#               R.td
#                 className: 'lead text-center col-sm-5'
#                 @props.data[key]

#   render: ->
#     R.div
#       className: "panel panel-#{@props.type}"
#       @panelHeading()
#       @panelBody()
