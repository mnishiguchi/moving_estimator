#   # Example
#   React.createElement AmountPanel,
#     type:       'success'
#     title:      "Volume for each room"
#     keyName:    "room"
#     valName:    "volume"
#     collection: { "masa": "programmer" }

@AmountPanel = React.createClass
  render: ->
    React.DOM.div
      className: 'col-md-4'
      React.DOM.div
        className: "panel panel-#{ @props.type }"
        React.DOM.div
          className: 'panel-heading'
          @props.title
        React.DOM.div
          className: 'panel-body'
          React.DOM.table
            className: "table table-bordered"
            React.DOM.thead null,
              React.DOM.tr null,
                React.DOM.th null, @props.keyName
                React.DOM.th null, @props.valName
            React.DOM.tbody null,
              for k, v of @props.collection
                React.DOM.tr null,
                  React.DOM.td null, k
                  React.DOM.td null, v
