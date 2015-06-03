# A store to keep track of our todo items

constants =
  ADD_TODO:    'ADD_TODO'
  TOGGLE_TODO: 'TOGGLE_TODO'
  CLEAR_TODOS: 'CLEAR_TODOS'

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
    @emit 'change'

  onToggleTodo: (payload) ->
    id = payload.id
    @todos[id].complete = not @todos[id].complete
    @emit 'change'

  onClearTodos: ->
    todos = @todos
    Object.keys(todos).forEach (key) ->
      if todos[key].complete
        delete todos[key]
    @emit 'change'

  getState:    -> todos: @todos

  _nextTodoId: -> @todoId += 1

# Semantic actions to go along with our action types.

actions =
  addTodo:  (text) -> @dispatch constants.ADD_TODO,    text: text
  toggleTodo: (id) -> @dispatch constants.TOGGLE_TODO, id:   id
  clearTodos:      -> @dispatch constants.CLEAR_TODOS

# Instantiate our store(s) and build a Flux instance.

stores = { TodoStore: new TodoStore }
flux = new Fluxxor.Flux(stores, actions)

# Use the "dispatch" event to add some logging.
flux.on 'dispatch', (type, payload) -> console.log "[Dispatch]", type, payload if console?.log?

# Build a UI with React.

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Application = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("TodoStore")]

  getInitialState: -> { newTodoText: "" }

  getStateFromFlux: ->
    flux = @getFlux()
    flux.store('TodoStore').getState()

  handleTodoTextChange: (e) ->
    @setState { newTodoText: e.target.value }

  onSubmitForm: (e) ->
    e.preventDefault()
    if @state.newTodoText.trim()
      @getFlux().actions.addTodo @state.newTodoText
      @setState { newTodoText: "" }

  clearCompletedTodos: (e) ->
    @getFlux().actions.clearTodos()

  render: ->
    todos = @state.todos
    <div>
      <form onSubmit={@onSubmitForm}>
        <div className="form-group">
          <input type="text" placeholder="New Todo"
                 value={@state.newTodoText}
                 onChange={@handleTodoTextChange}
                 className="form-control" />
        </div>
        <div className="form-group">
          <input type="submit" value="Add Todo" className="btn btn-success"/>
          <button onClick={@clearCompletedTodos} className="btn btn-default">Clear Completed</button>
        </div>
      </form>

      <ul>
        {
          Object.keys(todos).map (id) ->
            <li key={id}><TodoItem todo={todos[id]} /></li>;
        }
      </ul>
    </div>

# The TodoItem component will display and style itself based on the completion
# of the todo, and will dispatch an action indicating its intent to toggle its completion state.

TodoItem = React.createClass
  mixins: [FluxMixin]

  propTypes:
    todo: React.PropTypes.object.isRequired

  render: ->
    style =
      textDecoration: if @props.todo.complete then "line-through" else ""

    <span style={style} onClick={@onClick}>{@props.todo.text}</span>

  onClick: ->
    @getFlux().actions.toggleTodo @props.todo.id

# Render the component.
document.addEventListener 'DOMContentLoaded', (e) ->
  React.render <Application flux={flux} />, document.getElementById 'react_mountPoint'
