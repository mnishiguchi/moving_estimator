# Constants (Action types)

constants =
  ADD_TODO:    'ADD_TODO'
  TOGGLE_TODO: 'TOGGLE_TODO'
  CLEAR_TODOS: 'CLEAR_TODOS'

# Stores

TodoStore = Fluxxor.createStore
  initialize: ->
    @todoId = 0
    @todos = {}
    @bindActions(constants.ADD_TODO,    @onAddTodo,
                 constants.TOGGLE_TODO, @onToggleTodo,
                 constants.CLEAR_TODOS, @onClearTodos)

  onAddTodo: (payload) ->
    id = @_nextTodoId()
    todo =
      id:       id
      text:     payload.text
      complete: false
    @todos[id] = todo
    @emit('change')

  onToggleTodo: (payload) ->
    id = payload.id
    @todos[id].complete = not @todos[id].complete
    @emit('change')

  onClearTodos: ->
    todos = @todos
    Object.keys(todos).forEach (key) ->
      if todos[key].complete
        delete(todos[key])
    @emit('change')

  getState: ->
    todos: @todos

  _nextTodoId: ->
    @todoId += 1

# Registering our semantic actions

actions =
  addTodo:    (text) -> @dispatch(constants.ADD_TODO,    text: text)
  toggleTodo: (id)   -> @dispatch(constants.TOGGLE_TODO, id:   id)
  clearTodos:        -> @dispatch(constants.CLEAR_TODOS)

# Instantiating our stores

stores =
  TodoStore: new TodoStore

# Creating a Flux instance with our stores and actions that are defined above

flux = new Fluxxor.Flux(stores, actions)

# Logging upon the "dispatch" event

flux.on 'dispatch', (type, payload) ->
  console.log "[Dispatch]", type, payload if console?.log?

# The main React component (<Application/>)

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Application = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("TodoStore")]

  getInitialState: ->
    newTodoText: ""

  getStateFromFlux: ->
    flux = @getFlux()
    flux.store('TodoStore').getState()

  handleTodoTextChange: (e) ->
    @setState(newTodoText: e.target.value)

  onSubmitForm: (e) ->
    e.preventDefault()
    if @state.newTodoText.trim()
      @getFlux().actions.addTodo(@state.newTodoText)
      @setState(newTodoText: "")

  clearCompletedTodos: (e) ->
    @getFlux().actions.clearTodos()

  render: ->
    todos = @state.todos
    <div>
      <form onSubmit={@onSubmitForm}>
        <div className="form-group">
          <input type="text"
                 placeholder="New Todo"
                 value={@state.newTodoText}
                 onChange={@handleTodoTextChange}
                 className="form-control" />
        </div>
        <div className="form-group">
          <input type="submit"
                 value="Add Todo"
                 className="btn btn-success"/>
          <button onClick={@clearCompletedTodos}
                  className="btn btn-default">
            Clear Completed
          </button>
        </div>
      </form>

      <ul className="list-unstyled list-inline">
        {
          Object.keys(todos).map (id) ->
            <li key={id}>
              <TodoItem todo={todos[id]} />
            </li>
        }
      </ul>
    </div>

# A sub-component (<TodoItem/>)

TodoItem = React.createClass
  mixins: [FluxMixin]

  propTypes:
    todo: React.PropTypes.object.isRequired

  # Its style will be determined based on the completion state.
  render: ->
    checkbox = if @props.todo.complete then "fa fa-check-square-o" else "fa fa-square-o"
    <div onClick={@onClick}>
      <i className={checkbox}></i>
      {@props.todo.text}
    </div>

  # Clicking on a todo item will toggle the completion state.
  onClick: ->
    @getFlux().actions.toggleTodo(@props.todo.id)

# Rendering the whole component
document.addEventListener 'DOMContentLoaded', (e) ->
  React.render <Application flux={flux} />,
                document.getElementById("react_mountPoint")
