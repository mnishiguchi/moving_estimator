# Defining a todo item

TodoItem = React.createClass
  mixins: [ Fluxxor.FluxMixin(React) ]

  # Its style will be determined based on the item's completion state.
  render: ->
    todo = @props.todo
    checkbox = if todo.complete then "fa fa-check-square-o" else "fa fa-square-o"

    <li>
      <div onClick={ @onClick }>
        <i className={ checkbox }></i>
        { todo.text }
      </div>
    </li>

  # Clicking on a todo item will toggle the item's completion state.
  onClick: ->
    @getFlux().actions.toggleTodo(@props.todo.id)

# Defining a todo items list

@TodoItemsList = React.createClass
  propTypes:
    todos: React.PropTypes.object.isRequired

  createTodoItems: (todos) ->
    for id, todo of todos
      <TodoItem key={ id } todo={ todo } />

  render: ->
    <ul className="list-unstyled list-inline">
      { @createTodoItems(@props.todos) }
    </ul>
