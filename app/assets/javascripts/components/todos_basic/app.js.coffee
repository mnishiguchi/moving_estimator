@loadTodoListBasic = ->

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
    addTodo:    (text) ->
      @dispatch(constants.ADD_TODO,    text: text)
    toggleTodo: (id)   ->
      @dispatch(constants.TOGGLE_TODO, id:   id)
    clearTodos:        ->
      @dispatch(constants.CLEAR_TODOS)

  # Instantiating our stores

  stores =
    TodoStore: new TodoStore

  # Creating a Flux instance with our stores and actions that are defined above

  flux = new Fluxxor.Flux(stores, actions)

  # Logging upon the "dispatch" event

  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  # The main React component (<Application/>)

  Application = React.createClass
    mixins: [ Fluxxor.FluxMixin(React),
              Fluxxor.StoreWatchMixin("TodoStore") ]

    getInitialState: ->
      newTodoText: ""

    getStateFromFlux: ->
      flux = @getFlux()
      flux.store('TodoStore').getState()

    onChangeTodoText: (e) ->
      @setState(newTodoText: e.target.value)

    onSubmitForm: (e) ->
      e.preventDefault()
      if @state.newTodoText.trim()
        @getFlux().actions.addTodo(@state.newTodoText)
        @setState(newTodoText: "")

    onClickClearButton: (e) ->
      @getFlux().actions.clearTodos()

    render: ->
      todos = @state.todos

      anyCompletion = false
      for id, item of todos
        if item.complete
          anyCompletion = true
      clearButton = if anyCompletion then "btn btn-warning" else "btn btn-default"

      <div>
        <form onSubmit={ @onSubmitForm }>
          <div className="form-group">
            <input type="text"
                   placeholder="New Todo"
                   value={ @state.newTodoText }
                   onChange={ @onChangeTodoText }
                   className="form-control" />
          </div>
          <div className="form-group">
            <input type="submit"
                   value="Add Todo"
                   className="btn btn-success"/>
            <button onClick={ @onClickClearButton }
                    className={ clearButton }>
              Clear Completed
            </button>
          </div>
        </form>

        <div className="todo_display well">
          <TodoItemsList todos={ todos }/>
        </div>
      </div>

  # Rendering the whole component to the mount node

  if (mountNode = document.getElementById("react_todolist_basic"))
    React.render <Application flux={ flux } />, mountNode
