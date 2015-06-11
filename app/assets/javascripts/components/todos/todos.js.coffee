# Defining a navigation bar

@TodoItem = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  # Its style will be determined based on the item's completion state.
  render: ->
    todo = @props.todo

    # / .input-group
    # /   %span.input-group-addon
    # /     %input{ type: "checkbox" }
    # /   %input.form-control{ type: 'text', value: todo.content }
    # /   %span.input-group-addon
    # /     %div
    # /       %a Update
    # /       &nbsp; | &nbsp;
    # /       %a Cancel

  # Clicking on a todo item will toggle the item's completion state.
  onClick: ->
    @getFlux().actions.toggleTodo(@props.todo.id)
